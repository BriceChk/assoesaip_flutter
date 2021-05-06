import 'package:assoesaip_flutter/models/eventOccurrence.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'constants.dart';

class EventsOccurrencesList extends StatelessWidget {
  final List<EventOccurrence>? events;

  EventsOccurrencesList(this.events);

  @override
  Widget build(BuildContext context) {
    if (events!.length == 0) {
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
              style: TextStyle(fontSize: 18, fontFamily: FONT_NUNITO),
            ),
          ],
        ),
      );
    } else {
      return Column(
        children: events!.map((e) => _buildEventWidget(e, context)).toList(),
      );
    }
  }

  Widget _buildEventWidget(EventOccurrence occ, BuildContext context) {
    String imageUrl = 'https://$AE_HOST/';
    if (occ.event!.project!.logoFileName == null) {
      imageUrl += 'build/images/project-placeholder.png';
    } else {
      imageUrl += 'images/project-logos/' + occ.event!.project!.logoFileName!;
    }

    DateFormat formatterAllDay = DateFormat("EEE dd MMM", 'fr_FR');
    DateFormat formatter = DateFormat("EEE dd MMM H'h'mm", 'fr_FR');
    var startDate;
    var endString = ' - ';

    if (occ.event!.allDay!) {
      startDate = formatterAllDay.format(occ.date!.toLocal());
    } else {
      startDate = formatter.format(occ.date!.toLocal());
    }

    if (occ.event!.occurrencesCount == 1) {
      if (occ.event!.allDay!) {
        endString = formatterAllDay.format(occ.event!.dateEnd!.toLocal());
        if (endString == startDate) {
          endString = '';
        } else {
          endString = ' - ' + endString;
        }
      } else {
        endString += formatter.format(occ.event!.dateEnd!.toLocal());
      }
    } else {
      var endDate = occ.date!.add(Duration(minutes: occ.event!.duration!));
      if (occ.event!.allDay!) {
        if (occ.event!.duration! > 0) {
          // More than a day: show end date
          endString += formatterAllDay.format(endDate.toLocal());
        } else {
          endString = '';
        }
      } else {
        var formatterTime = DateFormat("H'h'mm", 'fr_FR');
        if (formatterAllDay.format(occ.date!.toLocal()) ==
            formatterAllDay.format(endDate.toLocal())) {
          endString += formatterTime.format(endDate.toLocal());
        } else {
          endString += formatter.format(endDate.toLocal());
        }
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(BORDER_RADIUS_CARD),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.grey[400]!,
            blurRadius: 3.0,
            offset: new Offset(0.0, 0.0),
          ),
        ],
      ),
      margin: EdgeInsets.fromLTRB(8, 10, 8, 15),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: InkWell(
          splashColor: COLOR_AE_BLUE,
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            Navigator.of(context, rootNavigator: true)
                .pushNamed('/event', arguments: occ.event);
          },
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
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      //* Container with the name of the project
                      Text(
                        occ.event!.project!.name!,
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
                            Text(
                              occ.event!.title!,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: FONT_NUNITO,
                                color: COLOR_NAVY_BLUE,
                              ),
                            ),
                            Text(
                              occ.event!.abstract!,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: FONT_NUNITO,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  FontAwesomeIcons.solidCalendarAlt,
                                  size: 15,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  startDate + endString,
                                  style: TextStyle(fontFamily: FONT_NUNITO),
                                ),
                              ],
                            ),
                          ]),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Transform.translate(
                        offset: Offset(0, 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color:
                                    HexColor.fromHex(occ.event!.category!.color!),
                              ),
                              height: 25,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Center(
                                child: Text(
                                  occ.event!.category!.name!,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: FONT_NUNITO),
                                ),
                              ),
                            ),
                          ],
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
  }
}
