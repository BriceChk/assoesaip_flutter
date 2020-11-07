import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

class CarouselWidget extends StatefulWidget {
  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  final List<List<String>> events = [
    [
      'assets/images/HomePage/event_1.jpg',
      'Event_1',
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

  void _next() {
    setState(
      () {
        if (currentIndex < events.length - 1) {
          currentIndex++;
        } else {
          currentIndex = currentIndex;
        }
      },
    );
  }

  void _preve() {
    setState(
      () {
        if (currentIndex > 0) {
          currentIndex--;
        } else {
          currentIndex = 0;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.velocity.pixelsPerSecond.dx > 0) {
          _preve();
        } else if (details.velocity.pixelsPerSecond.dx < 0) {
          _next();
        }
      },
      child: Container(
        width: double.infinity,
        height: 350,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(events[currentIndex][0]), fit: BoxFit.cover),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Colors.grey[700].withOpacity(0.90),
                Colors.grey.withOpacity(0),
              ],
            ),
          ),
          //Here we create the column with the indicator, title & description
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              /*Here we have the title and the description. In order to have them align on the left of the screen 
                    with need to wrap them in a row*/
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                //The alignement on the left is possible here with the row
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Just the column of the title and the description
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          events[currentIndex][1],
                          style: TextStyle(
                            fontSize: 30,
                            color: blue_2,
                          ),
                        ),
                        Text(
                          events[currentIndex][2],
                          style: TextStyle(
                            fontSize: 16,
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 90,
                    margin: EdgeInsets.only(bottom: 50),
                    child: Row(
                      children: _buildIndicator(),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return Expanded(
      child: Container(
        height: 4,
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isActive ? Colors.grey[800] : Colors.white,
        ),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < events.length; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
}
