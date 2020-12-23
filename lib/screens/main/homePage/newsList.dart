import 'package:assoesaip_flutter/models/news.dart';
import 'package:assoesaip_flutter/services/api.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsListWidget extends StatefulWidget {
  @override
  _NewsListWidgetState createState() => _NewsListWidgetState();
}

class _NewsListWidgetState extends State<NewsListWidget> {
  final RoundedRectangleBorder roundedBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  );
  final BorderRadius splashBorderRadius = BorderRadius.circular(15);
  final BorderRadius roundedImage = BorderRadius.circular(15);

  List<News> news;

  @override
  void initState() {
    super.initState();
    getNews().then((value) {
      setState(() {
        news = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (news is List<News>) {
      return _newsListWidget();
    } else {
      return _newsListPlaceholder();
    }
  }

  Widget _newsListPlaceholder() {
    List<Widget> list = List();

    for (var i = 0; i < 3; i++) {
      list.add(Card(
        elevation: 0.5,
        color: cardColor,
        shape: roundedBorder,
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
        )
    );
  }

  Widget _newsListWidget() {
    return Column(
      children: news.map((e) => _buildNewsWidget(e)).toList(),
    );
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
      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: Icon(icon, size: 17.5, color: greyIconColor),
    );
  }

  Widget _buildNewsWidget(News n) {
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

    DateFormat formatter = DateFormat("dd MMMM yyyy · HH'h'mm", 'fr_FR');
    String date = formatter.format(n.datePublished.toLocal());

    Widget card = Card(
      elevation: 0.5,
      color: cardColor,
      shape: roundedBorder,
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding: EdgeInsets.all(4),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //* Container with the image inside
              Container(
                height: double.infinity,
                width: 90,
                decoration: BoxDecoration(
                  //* have the same rounded corner as the big container
                  borderRadius: roundedImage,
                  //* URL of the picture of the news
                ),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: imageUrl,
                  fit: BoxFit.contain,
                  fadeInDuration: Duration(milliseconds: 150),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* Title of the news
                    _buildNewsTitle(n),
                    //* Description of the news
                    Text(
                      content,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: classicFont,
                      ),
                    ),
                    SizedBox(height: 10),
                    //* Row in order to have the icon and 2 text align each other
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //* Alignment of the 2 Text: Name and Date
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //* Name of the association
                            Text(
                              n.project.name,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: classicFont,
                              ),
                            ),
                            //* Date of the news
                            Text(
                              date,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: classicFont,
                              ),
                            ),
                          ],
                        ),
                        //* Icon for each type of news
                        _buildNewsIcons(n)
                      ].where((o) => o != null).toList(),
                    ),
                  ]
                      .where((o) => o != null)
                      .toList(), // Remove the eventually null Text for the title
                ),
              ),
            ],
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

    return card;
  }
}
