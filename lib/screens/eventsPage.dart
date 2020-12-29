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
    DateFormat formatter = DateFormat("dd/MM/yyyy · HH'h'mm", 'fr_FR');
    String date = formatter.format(e.datePublished.toLocal());

    return IndexedStack(index: _stackToView, children: [
      Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: starCommandBlue,
          child: Icon(Icons.calendar_today),
          onPressed: () {
            showModalBottomSheet(
                shape: RoundedRectangleBorder(borderRadius: cardsBorderRadius),
                context: context,
                builder: (BuildContext bc) {
                  return Container(
                    child: Wrap(
                      children: <Widget>[
                        ListTile(
                            leading: Icon(Icons.calendar_today),
                            title: Text(e.dateStart.toString()),
                            onTap: () => {}),
                      ],
                    ),
                  );
                });
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
                    e.project.name,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontFamily: classicFont, fontSize: 12),
                  ),
                  Text(
                    date,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontFamily: classicFont, fontSize: 12),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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

  _loadHtmlFromString() async {
    String fileText = await rootBundle.loadString('assets/article.html');
    fileText = fileText.replaceFirst('%body%', e.html);
    _controller.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
