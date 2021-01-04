import 'dart:convert';

import 'package:assoesaip_flutter/models/article.dart';
import 'package:assoesaip_flutter/services/api.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class ArticlePage extends StatefulWidget {
  ArticlePage(this.n);

  final Article n;

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final double titleSize = 27.5;

  Article a;
  WebViewPlusController _controller;
  double _height = 1;

  num _stackToView = 1;

  final BorderRadius buttonBorderRadius = BorderRadius.circular(10);

  @override
  void initState() {
    super.initState();
    getArticle(widget.n.id).then((value) {
      setState(() {
        a = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Voir l'article",
          style: TextStyle(
            fontSize: 30,
            color: headerTextColor,
            fontFamily: classicFont,
          ),
        ),
        centerTitle: true,
        backgroundColor: starCommandBlue,
      ),
      body: a is Article
          ? _buildArticleWidget()
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

  Widget _buildArticleWidget() {
    DateFormat formatter = DateFormat("dd/MM/yyyy · HH'h'mm", 'fr_FR');
    String date = formatter.format(a.datePublished.toLocal());

    return IndexedStack(index: _stackToView, children: [
      Scaffold(
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
                    a.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: titleSize,
                        color: titleColor,
                        fontFamily: classicFont),
                  ),
                  SizedBox(height: 10),
                  Text(
                    a.abstract,
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
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/project',
                                arguments: a.project);
                          },
                          child: FittedBox(
                            child: Text(
                              a.project.name,
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
                            if (await canLaunch(
                                'mailto:' + a.author.username)) {
                              await launch('mailto:' + a.author.username);
                            } else {
                              throw 'Could not launch mailto:' +
                                  a.author.username;
                            }
                          },
                          child: FittedBox(
                            child: Text(
                              a.author.firstName + ' ' + a.author.lastName,
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
    fileText = fileText.replaceFirst('%body%', a.html);
    _controller.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
