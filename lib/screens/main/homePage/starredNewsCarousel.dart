import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class StarredNewsCarouselWidget extends StatefulWidget {
  @override
  _StarredNewsCarouselWidgetState createState() =>
      _StarredNewsCarouselWidgetState();
}

class _StarredNewsCarouselWidgetState extends State<StarredNewsCarouselWidget> {
  final List<List<String>> events = [
    [
      'assets/images/HomePage/event_1.jpg',
      'COVID-19 : dernières informations',
      'Lorem ipsum dolor sit amet, consectetur.',
    ],
    [
      'assets/images/HomePage/event_2.jpg',
      'Event_2',
      'Lorem ipsum dolor sit amet, consectetur.',
    ],
    [
      'assets/images/HomePage/event_3.jpg',
      'Event_3',
      'Lorem ipsum dolor sit amet, consectetur.',
    ],
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, bottom: 10),
          child: Text(
            "À la une",
            style: TextStyle(
              fontSize: 25,
              fontFamily: classicFont,
            ),
          ),
        ),
        CarouselSlider.builder(
          //* All the option of the carousel see the pubdev page
          options: CarouselOptions(
            height: 275,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(
                () {
                  currentIndex = index;
                },
              );
            },
          ),
          itemCount: events.length,
          itemBuilder: (BuildContext context, int currentIndex) => Container(
            //* Container of each event
            child: Container(
              //* We want the rounded corner for the image
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                //* Picture of the events
                image: DecorationImage(
                  image: AssetImage(events[currentIndex][0]),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                //* Rounded corner for the grey shadow too and display of the shadow
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey[700].withOpacity(0.90),
                      Colors.grey.withOpacity(0),
                    ],
                    begin: Alignment.bottomRight,
                  ),
                ),
                //* Here we create the column with the indicator, title & description
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //* Here we have the title and the description. In order to have them align on the left of the screen
                    //* with need to wrap them in a row
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      //* The alignement on the left is possible here with the row
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //! Wrap the column inside a flexible widget in order to do not have the text overflow
                          //! Like this we have a multiple line text
                          Flexible(
                            //* Just the column of the title and the description
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  events[currentIndex][1],
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: titleCarouselColor,
                                    fontFamily: classicFont,
                                  ),
                                ),
                                //! See the overflow of the text right here
                                Text(
                                  events[currentIndex][2],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: fontColor,
                                    fontFamily: classicFont,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
