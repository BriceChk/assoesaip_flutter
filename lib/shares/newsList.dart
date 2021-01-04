import 'package:assoesaip_flutter/models/news.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
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

  static Widget newsListPlaceholder() {
    List<Widget> list = List();

    for (var i = 0; i < 10; i++) {
      list.add(Card(
        elevation: 0.5,
        color: cardColor,
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
        baseColor: cardColor,
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
              style: TextStyle(fontSize: 18, fontFamily: classicFont),
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
        fontFamily: classicFont,
        color: titleColor,
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

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: starCommandBlue,
      ),
      height: 35,
      width: 35,
      child: Icon(icon, size: 15, color: white),
    );
  }

  Widget _buildNewsWidget(News n, BuildContext context) {
    String imageUrl = 'https://asso-esaip.bricechk.fr/';
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
          color: whiteWhite,
          borderRadius: cardsBorderRadius,
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
                          fontFamily: classicFont,
                          color: greyfontColor,
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
                              fontFamily: classicFont,
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
                        offset: Offset(-5, 25),
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
        splashColor: splashColor,
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
        splashColor: splashColor,
        child: Container(child: card),
        onTap: () {
          Navigator.of(context, rootNavigator: true).pushNamed('/article', arguments: n.article);
        },
      );
    }

    if (n.event != null) {
      return InkWell(
        borderRadius: splashBorderRadius,
        splashColor: splashColor,
        child: Container(child: card),
        onTap: () {
          Navigator.of(context, rootNavigator: true).pushNamed('/event', arguments: n.event);
        },
      );
    }
    return card;
  }
}
