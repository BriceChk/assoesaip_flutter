import 'package:assoesaip_flutter/models/news.dart';
import 'package:assoesaip_flutter/services/api.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsListWidget extends StatefulWidget {
  @override
  _NewsListWidgetState createState() => _NewsListWidgetState();
}

class _NewsListWidgetState extends State<NewsListWidget> {
  final RoundedRectangleBorder roundedBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  );
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
    } else if (news == null) {
      return Text('Erreur');
    } else {
      return Text('Chargement ...');
    }
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
    return n.event == null && n.link == null
        ? Container(
            child: Icon(
              FontAwesomeIcons.calendarAlt,
              size: 17.5,
            ),
          )
        : n.event == null
            ? Container(
                child: Icon(
                  FontAwesomeIcons.externalLinkAlt,
                  size: 17.5,
                ),
              )
            : n.article == null
                ? Container(
                    child: Icon(
                      FontAwesomeIcons.newspaper,
                      size: 17.5,
                    ),
                  )
                : Container(
                    child: Icon(Icons.campaign_rounded),
                  );
  }

  Widget _buildNewsWidget(News n) {
    String imageUrl =
        'https://asso-esaip.bricechk.fr/media/cache/medium/images/';
    if (n.project.logoFileName == null) {
    } else {
      imageUrl += 'project-logos/' + n.project.logoFileName;
    }

    String content = n.content;
    if (n.article != null) {
      content = n.article.abstract;
    } else if (n.event != null) {
      content = n.event.abstract;
    }

    DateFormat formatter = DateFormat('dd MMMM yyyy', 'fr_FR');
    String date = formatter.format(n.datePublished);

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
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.contain,
                  ),
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
                    SizedBox(height: 3),
                    //* Name of the association
                    Text(
                      n.project.name,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: classicFont,
                      ),
                    ),
                    SizedBox(height: 2),
                    //* Date of the news
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          date,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: classicFont,
                          ),
                        ),
                        Row(
                          children: [_buildNewsIcons(n), SizedBox(width: 10)],
                        ),
                      ],
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
