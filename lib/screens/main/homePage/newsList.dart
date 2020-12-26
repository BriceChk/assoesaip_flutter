import 'package:assoesaip_flutter/models/news.dart';
import 'package:assoesaip_flutter/screens/main/homePage/newsPage.dart';
import 'package:assoesaip_flutter/services/api.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';
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
  final BorderRadius roundedImage = BorderRadius.circular(5);

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
    IconData icon;

    if (n.event != null) {
      icon = FontAwesomeIcons.calendarAlt;
    } else if (n.article != null) {
      icon = FontAwesomeIcons.newspaper;
    } else if (n.link != null) {
      icon = FontAwesomeIcons.externalLinkAlt;
    } else {
      return Container();
    }

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: starCommandBlue,
      ),
      height: 35,
      width: 35,
      child: Icon(icon, size: 17.5, color: white),
    );
  }

  Widget _buildNewsWidget(News n) {
    String imageUrl = 'https://asso-esaip.bricechk.fr/images/';
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

    DateFormat formatter = DateFormat("dd MMMM yyyy", 'fr_FR');
    String date = formatter.format(n.datePublished.toLocal());

    Widget card = Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Card(
        elevation: 3,
        color: whiteWhite,
        shape: roundedBorder,
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Padding(
          padding: EdgeInsets.all(4),
          child: IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* Row with the first line of the card: image + date + name project
                  FittedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        //* Container with the picture of the Project
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: roundedImage,
                            image: DecorationImage(
                              //! A CHANGER
                              image:
                                  AssetImage('assets/images/SuperBowlLogo.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        //* Container with the name of the project
                        Container(
                          child: Text(
                            n.project.name,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: classicFont,
                              color: greyfontColor,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          height: 15,
                          width: 1,
                          color: greyfontColor,
                        ),
                        //* Container with the date of the news
                        Container(
                          child: Text(
                            date,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: classicFont,
                              color: greyfontColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    height: 1,
                    color: greyfontColor,
                  ),
                  Stack(
                    children: [
                      Container(
                        //color: Colors.amber,
                        padding: EdgeInsets.symmetric(vertical: 10),
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
                          offset: Offset(0, 20),
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
      ),
    );

    if (n.link != null) {
      return InkWell(
        borderRadius: splashBorderRadius,
        splashColor: splashColor,
        child: Container(child: card),
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewsPage(n.article)));
        },
      );
    }

    return card;
  }
}
