import 'package:assoesaip_flutter/models/eventOccurrence.dart';
import 'package:flutter/material.dart';

import 'constant.dart';

class EventsOccurrencesList extends StatelessWidget {
  final List<EventOccurrence> events;

  EventsOccurrencesList(this.events);

  @override
  Widget build(BuildContext context) {
    if (events.length == 0) {
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
              "Aucun événement :(",
              style: TextStyle(fontSize: 18, fontFamily: classicFont),
            ),
          ],
        ),
      );
    } else {
      return Column(
        children: events.map((e) => _buildEventWidget(e)).toList(),
      );
    }
  }

  Widget _buildEventWidget(EventOccurrence n) {
    return Padding(
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
                          child: Text('image?')
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      //* Container with the name of the project
                      Text(
                        'Lorem ipsum',
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
                Container(
                  //color: Colors.amber,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Lorem ipsum',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: classicFont,
                        ),
                      ),
                    ]
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
