import 'package:assoesaip_flutter/models/news.dart';
import 'package:assoesaip_flutter/shares/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsListWidget extends StatelessWidget {
  final List<News> news;

  NewsListWidget(this.news);

  final BorderRadius splashBorderRadius = BorderRadius.circular(15);

  static Widget newsListPlaceholder({count: 10}) {
    List<Widget> list = List();

    for (var i = 0; i < count; i++) {
      list.add(Card(
        elevation: 0.5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //* Container with the image inside
            Container(
              height: 90,
            ),
          ],
        ),
      ));
    }

    return Shimmer.fromColors(
        baseColor: COLOR_SHIMMER_WHITE,
        highlightColor: Colors.grey[200],
        child: Column(
          children: list,
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (news.length == 0) {
      return Padding(
        padding: EdgeInsets.only(top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                "assets/images/no_data.png",
                fit: BoxFit.contain,
              ),
              height: 200,
            ),
            SizedBox(height: 25),
            Text(
              "Aucune actualité :(",
              style: TextStyle(fontSize: 18, fontFamily: FONT_NUNITO),
            ),
          ],
        ),
      );
    } else {
      return Column(
        children: news.map((e) => _buildNewsWidget(e, context)).toList(),
      );
    }
  }

  Widget _buildNewsTitle(News n) {
    if (n.article == null && n.event == null) return null;

    var title = n.article != null ? n.article.title : n.event.title;

    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontFamily: FONT_NUNITO,
        color: COLOR_NAVY_BLUE,
      ),
    );
  }

  Widget _buildNewsIcons(News n) {
    IconData icon;

    if (n.event != null) {
      icon = FontAwesomeIcons.calendarAlt;
    } else if (n.article != null) {
      icon = FontAwesomeIcons.newspaper;
    } else if (n.link != null) {
      icon = FontAwesomeIcons.externalLinkAlt;
    } else {
      return null;
    }

    var color = COLOR_AE_BLUE;
    List<Widget> widgets = [];

    widgets.add(Transform.translate(
      child: Icon(icon, size: 15, color: Colors.white),
      offset: Offset(0, -1),
    ));

    if (n.event != null || n.article != null) {
      widgets.add(SizedBox(width: 8));
      widgets.add(Text(
        n.event == null ? n.article.category.name : n.event.category.name,
        style: TextStyle(
            color: Colors.white,
            fontFamily: FONT_NUNITO),
      ));

      color = n.event == null ? HexColor.fromHex(n.article.category.color) : HexColor.fromHex(n.event.category.color);
    }


    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: color,
      ),
      height: 25,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widgets,
      ),
    );
  }

  Widget _buildNewsWidget(News n, BuildContext context) {
    String imageUrl = 'https://$AE_HOST/';
    if (n.project.logoFileName == null) {
      imageUrl += 'build/images/project-placeholder.png';
    } else {
      imageUrl += 'images/project-logos/' + n.project.logoFileName;
    }

    String content = n.content;
    if (n.article != null) {
      content = n.article.abstract;
    } else if (n.event != null) {
      content = n.event.abstract;
    }

    DateFormat formatter = DateFormat("dd/MM/yyyy · HH'h'mm", 'fr_FR');
    String date = formatter.format(n.datePublished.toLocal());

    Widget card = Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(BORDER_RADIUS_CARD),
          boxShadow: <BoxShadow>[
            new BoxShadow(
              color: Colors.grey[400],
              blurRadius: 3.0,
              offset: new Offset(0.0, 0.0),
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //* Row with the first line of the card: image + date + name project
                FittedBox(
                  child: Row(
                    children: [
                      //* Container with the picture of the Project
                      Container(
                          height: 30,
                          width: 30,
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                          )
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      //* Container with the name of the project
                      Text(
                        n.project.name + ' | ' + date,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: FONT_NUNITO,
                          color: COLOR_GREY_TEXT,
                        ),
                      ),
                      //* Container with the date of the news
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  height: 1,
                  color: Colors.grey[500],
                ),
                Stack(
                  children: [
                    Container(
                      //color: Colors.amber,
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          //* Title of the news
                          _buildNewsTitle(n),
                          SizedBox(height: 10),
                          //* Description of the news
                          Text(
                            content,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: FONT_NUNITO,
                            ),
                          ),
                        ]
                            .where((o) => o != null)
                            .toList(), // Remove the eventually null Text for the title
                      ),
                    ),
                    //* Icon for each type of news
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Transform.translate(
                        offset: Offset(-5, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _buildNewsIcons(n),
                          ].where((o) => o != null).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (n.link != null) {
      return InkWell(
        borderRadius: splashBorderRadius,
        splashColor: COLOR_AE_BLUE,
        child: card,
        onTap: () async {
          if (await canLaunch(n.link)) {
            await launch(n.link);
          } else {
            throw 'Could not launch ' + n.link;
          }
        },
      );
    }

    if (n.article != null) {
      return InkWell(
        borderRadius: splashBorderRadius,
        splashColor: COLOR_AE_BLUE,
        child: Container(child: card),
        onTap: () {
          Navigator.of(context, rootNavigator: true).pushNamed('/article', arguments: n.article);
        },
      );
    }

    if (n.event != null) {
      return InkWell(
        borderRadius: splashBorderRadius,
        splashColor: COLOR_AE_BLUE,
        child: Container(child: card),
        onTap: () {
          Navigator.of(context, rootNavigator: true).pushNamed('/event', arguments: n.event);
        },
      );
    }
    return card;
  }
}
