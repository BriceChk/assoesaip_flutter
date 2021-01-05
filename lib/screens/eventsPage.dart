import 'dart:convert';

import 'package:assoesaip_flutter/models/event.dart';
import 'package:assoesaip_flutter/services/api.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class EventPage extends StatefulWidget {
  EventPage(this.n);

  final Event n;
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final double titleSize = 27.5;

  Event e;
  WebViewPlusController _controller;
  double _height = 1;

  num _stackToView = 1;

  final BorderRadius buttonBorderRadius = BorderRadius.circular(10);
  final BorderRadius bottomSheetBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(10),
    topRight: Radius.circular(10),
  );

  DateFormat formatter = DateFormat("dd/MM/yyyy · HH'h'mm", 'fr_FR');

  @override
  void initState() {
    super.initState();
    getEvent(widget.n.id).then((value) {
      setState(() {
        e = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Voir l'événement",
          style: TextStyle(
            fontSize: 30,
            color: headerTextColor,
            fontFamily: classicFont,
          ),
        ),
        centerTitle: true,
        backgroundColor: starCommandBlue,
      ),
      body: e is Event
          ? _buildEventWidget()
          : Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildEventWidget() {
    String date = formatter.format(e.datePublished.toLocal());

    return IndexedStack(index: _stackToView, children: [
      Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: starCommandBlue,
          icon: Icon(Icons.calendar_today),
          label: Text('Voir les dates'),
          onPressed: () {
            _showBottomSheet();
          },
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              constraints: BoxConstraints(minHeight: 10),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: titleSize,
                        color: titleColor,
                        fontFamily: classicFont),
                  ),
                  SizedBox(height: 10),
                  Text(
                    e.abstract,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontFamily: classicFont, fontSize: 14),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Article publié le ' + date,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontFamily: classicFont, fontSize: 12),
                  ),
                  SizedBox(height: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/project',
                              arguments: e.project);
                        },
                        child: FittedBox(
                          child: Text(
                            e.project.name,
                            style: TextStyle(
                                fontFamily: classicFont, color: white),
                          ),
                        ),
                        color: starCommandBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: buttonBorderRadius),
                      ),
                      FlatButton(
                        onPressed: () async {
                          if (await canLaunch('mailto:' + e.author.username)) {
                            await launch('mailto:' + e.author.username);
                          } else {
                            throw 'Could not launch mailto:' +
                                e.author.username;
                          }
                        },
                        child: FittedBox(
                          child: Text(
                            e.author.firstName + ' ' + e.author.lastName,
                            style: TextStyle(
                                fontFamily: classicFont, color: white),
                          ),
                        ),
                        color: starCommandBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: buttonBorderRadius),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: _height,
              child: WebViewPlus(
                onWebViewCreated: (controller) {
                  this._controller = controller;
                  _loadHtmlFromString();
                },
                onPageFinished: (url) {
                  _controller.getHeight().then((double height) {
                    setState(() {
                      _height = height;
                      _stackToView = 0;
                    });
                  });
                },
                javascriptMode: JavascriptMode.unrestricted,
                navigationDelegate: (action) async {
                  if (await canLaunch(action.url)) {
                    await launch(action.url);
                  } else {
                    throw 'Could not launch ' + action.url;
                  }
                  return NavigationDecision.prevent;
                },
              ),
            ),
          ],
        ),
      ),
      Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        ],
      )
    ]);
  }

  Widget _buildDate() {
    String dateStart;
    String dateEnd;
    List<String> occurenceList = [];
    DateFormat formatterAllDay = DateFormat("EEEE dd MMM", 'fr_FR');

    if (e.occurrencesCount == 1) {
      if (e.allDay) {
        dateStart = formatterAllDay.format(e.dateStart) + ', toute la journée';
        dateEnd = formatterAllDay.format(e.dateEnd) + ', toute la journée';
      } else {
        dateStart = formatter.format(e.dateStart.toLocal());
        dateEnd = formatter.format(e.dateEnd.toLocal());
      }

      if (dateStart == dateEnd) {
        return ListTile(
          leading: Icon(Icons.calendar_today),
          title: Text(
            dateStart,
            style: TextStyle(fontFamily: classicFont),
          ),
          onTap: () => {},
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Container(
                width: 60,
                child: Text(
                  'Début : ' + dateStart,
                  style: TextStyle(fontFamily: classicFont),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Container(
                width: 60,
                child: Text(
                  'Fin : ' + dateEnd,
                  style: TextStyle(fontFamily: classicFont),
                ),
              ),
            )
          ],
        );
      }
    } else {
      if (e.occurrences.length == 0) {
        return Text("Toutes les dates sont passées");
      } else {
        if (e.allDay) {
          for (var item in e.occurrences) {
            occurenceList.add(formatterAllDay.format(item.date.toLocal()));
          }
          return Column(
              children: occurenceList.map((occur) {
            return ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text(
                occur + ', toute la journée',
                style: TextStyle(fontFamily: classicFont),
              ),
              onTap: () => {},
            );
          }).toList());
        } else {
          for (var item in e.occurrences) {
            //! Ici pour 'titre de l'evenement' vas dans le else alors qu'il ne devrait pas
            var formatterTime = DateFormat("HH'h'mm", 'fr_FR');
            var endDate = item.date.add(Duration(minutes: e.duration));
            if (formatterAllDay.format(item.date.toLocal()) ==
                formatterAllDay.format(endDate)) {
              dateEnd = formatterTime.format(endDate.toLocal());
              occurenceList
                  .add(formatter.format(item.date.toLocal()) + ' - ' + dateEnd);
            } else {
              dateEnd = formatter.format(endDate);
              occurenceList
                  .add(formatter.format(item.date.toLocal()) + ' - ' + dateEnd);
            }
          }
          return Column(
              children: occurenceList.map((occur) {
            return ListTile(
              leading: Icon(Icons.calendar_today),
              title: FittedBox(
                child: Text(
                  occur,
                  style: TextStyle(fontFamily: classicFont),
                ),
              ),
              onTap: () => {},
            );
          }).toList());
        }
      }
    }
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: bottomSheetBorderRadius),
      context: context,
      builder: (BuildContext bc) {
        return ListView(children: [
          Container(
            child: Wrap(
              children: <Widget>[
                _buildDate(),
              ],
            ),
          ),
        ]);
      },
    );
  }

  _loadHtmlFromString() async {
    String fileText = await rootBundle.loadString('assets/article.html');
    fileText = fileText.replaceFirst('%body%', e.html);
    _controller.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
