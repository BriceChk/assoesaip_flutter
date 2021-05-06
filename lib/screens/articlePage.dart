
import 'package:assoesaip_flutter/models/article.dart';
import 'package:assoesaip_flutter/services/api.dart';
import 'package:assoesaip_flutter/shares/constants.dart';
import 'package:assoesaip_flutter/shares/customWebviewWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlePage extends StatefulWidget {
  ArticlePage(this.n);

  final Article? n;

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final double titleSize = 27.5;

  Article? a;
  final BorderRadius buttonBorderRadius = BorderRadius.circular(10);

  @override
  void initState() {
    super.initState();
    getArticle(widget.n!.id).then((value) {
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
            color: Colors.white,
            fontFamily: FONT_NUNITO,
          ),
        ),
        centerTitle: true,
        backgroundColor: COLOR_AE_BLUE,
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
    String date = formatter.format(a!.datePublished!.toLocal());

    return Scaffold(
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
                  a!.title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: titleSize,
                      color: COLOR_NAVY_BLUE,
                      fontFamily: FONT_NUNITO),
                ),
                SizedBox(height: 10),
                Text(
                  a!.abstract!,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontFamily: FONT_NUNITO, fontSize: 14),
                ),
                SizedBox(height: 10),
                Text(
                  'Article publié le ' + date,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontFamily: FONT_NUNITO, fontSize: 12),
                ),
                SizedBox(height: 15),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/project',
                              arguments: a!.project);
                        },
                        child: FittedBox(
                          child: Text(
                            a!.project!.name!,
                            style: TextStyle(
                                fontFamily: FONT_NUNITO, color: Colors.white),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: COLOR_AE_BLUE,
                          shape: RoundedRectangleBorder(
                              borderRadius: buttonBorderRadius),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          if (await canLaunch(
                              'mailto:' + a!.author!.username!)) {
                            await launch('mailto:' + a!.author!.username!);
                          } else {
                            throw 'Could not launch mailto:' +
                                a!.author!.username!;
                          }
                        },
                        child: FittedBox(
                          child: Text(
                            a!.author!.firstName! + ' ' + a!.author!.lastName!,
                            style: TextStyle(
                                fontFamily: FONT_NUNITO, color: Colors.white),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: COLOR_AE_BLUE,
                          shape: RoundedRectangleBorder(
                              borderRadius: buttonBorderRadius),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CustomWebview(a!.html)
        ],
      ),
    );
  }
}
