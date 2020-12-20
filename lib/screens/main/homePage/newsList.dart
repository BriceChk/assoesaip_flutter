import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

class NewsListWidget extends StatefulWidget {
  @override
  _NewsListWidgetState createState() => _NewsListWidgetState();
}

class _NewsListWidgetState extends State<NewsListWidget> {
  final List<List<String>> news = [
    [
      'assets/images/HomePage/event_1.jpg',
      'Théâtre',
      'Atelier théâtre présenté par le BDA',
      'BDA - Bureau des Arts (Angers)',
      'Date : 21 octobre 2020',
    ],
    [
      'assets/images/HomePage/event_2.jpg',
      'WEI',
      'Week-end d\'intégration',
      'BDE - Bureau des étudiant (Angers)',
      'Date : 23 octobre 2020',
    ],
    [
      'assets/images/HomePage/event_3.jpg',
      'Soirée Halloween',
      'Soirée déguisé d\'halloween',
      'NRS - Nouvelle route du son (Angers)',
      'Date : 31 octobre 2020',
    ],
    [
      'assets/images/HomePage/event_3.jpg',
      'Soirée Halloween',
      'Soirée déguisé d\'halloween',
      'NRS - Nouvelle route du son (Angers)',
      'Date : 31 octobre 2020',
    ],
    [
      'assets/images/HomePage/event_3.jpg',
      'Soirée Halloween',
      'Soirée déguisé d\'halloween',
      'NRS - Nouvelle route du son (Angers)',
      'Date : 31 octobre 2020',
    ],
    [
      'assets/images/HomePage/event_3.jpg',
      'Soirée Halloween',
      'Soirée déguisé d\'halloween',
      'NRS - Nouvelle route du son (Angers)',
      'Date : 31 octobre 2020',
    ],
    [
      'assets/images/HomePage/event_3.jpg',
      'Soirée Halloween',
      'Soirée déguisé d\'halloween',
      'NRS - Nouvelle route du son (Angers)',
      'Date : 31 octobre 2020',
    ],
    [
      'assets/images/HomePage/event_3.jpg',
      'Soirée Halloween',
      'Soirée déguisé d\'halloween',
      'NRS - Nouvelle route du son (Angers)',
      'Date : 31 octobre 2020',
    ],
    [
      'assets/images/HomePage/event_3.jpg',
      'Soirée Halloween',
      'Soirée déguisé d\'halloween',
      'NRS - Nouvelle route du son (Angers)',
      'Date : 31 octobre 2020',
    ],
    [
      'assets/images/HomePage/event_3.jpg',
      'Soirée Halloween',
      'Soirée déguisé d\'halloween',
      'NRS - Nouvelle route du son (Angers)',
      'Date : 31 octobre 2020',
    ],
    [
      'assets/images/HomePage/event_3.jpg',
      'Soirée Halloween',
      'Soirée déguisé d\'halloween',
      'NRS - Nouvelle route du son (Angers)',
      'Date : 31 octobre 2020',
    ],
  ];

  int currentIndex = 0;
  final String classicFont = "Nunito";
  final Color backgroundColor = whiteWhite;
  final Color cardColor = white;
  final Color titleColor = navyBlue;

  final RoundedRectangleBorder roundedBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  );
  final BorderRadius roundedImage = BorderRadius.circular(15);

  @override
  Widget build(BuildContext context) {
    currentIndex = 0;
    return Container(
      color: backgroundColor,
      //* Container of the white widget with the rounded corner
      child: Container(
        //* Size of the screen
        width: MediaQuery.of(context).size.width,
        //* Column if widget in order to have the buildnews working I.E starredNewsCarousel.dart
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Want to have space between the carousel and the top of the rounded container
            Padding(
              padding: EdgeInsets.only(top: 5, left: 10),
              child: Text(
                "Actualités",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: classicFont,
                ),
              ),
            ),
            //* Sizedbox in order to have a apsace between the rounded and the first news
            SizedBox(
              height: 15,
            ),
            //! Container of each news
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: _buildNews(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _news(bool isActive) {
    return Padding(
      padding: EdgeInsets.only(right: 10, left: 10, bottom: 7.5),
      child: Card(
        elevation: 0.5,
        color: cardColor,
        shape: roundedBorder,
        child: Container(
          height: 95,
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
                    image: AssetImage(news[currentIndex][0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  //* Title of the news
                  Text(
                    news[currentIndex][1],
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: classicFont,
                      color: titleColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  //* Description of the news
                  Text(
                    news[currentIndex][2],
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: classicFont,
                    ),
                  ),
                  SizedBox(height: 2),
                  //* Name of the association
                  Text(
                    news[currentIndex][3],
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: classicFont,
                    ),
                  ),
                  SizedBox(height: 2.5),
                  //* Date of the news
                  Text(
                    news[currentIndex][4],
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: classicFont,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildNews() {
    List<Widget> newsNumber = [];
    for (int i = 0; i < news.length; i++) {
      if (currentIndex == i) {
        newsNumber.add(_news(true));
      } else {
        newsNumber.add(_news(false));
      }
      currentIndex++;
    }
    return newsNumber;
  }
}
