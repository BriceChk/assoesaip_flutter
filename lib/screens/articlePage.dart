import 'package:assoesaip_flutter/models/article.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

class ArticlePage extends StatefulWidget {
  ArticlePage(this.n);

  final Article n;

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final double titleSize = 27.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voir l'article"),
        centerTitle: true,
        backgroundColor: starCommandBlue,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            constraints: BoxConstraints(minHeight: 10),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.n.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: titleSize,
                      color: titleColor,
                      fontFamily: classicFont),
                ),
                SizedBox(height: 10),
                Text(
                  widget.n.abstract,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontFamily: classicFont, fontSize: 14),
                ),
                SizedBox(height: 10),
                Text(
                  "n.project.name.toString()",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontFamily: classicFont, fontSize: 12),
                ),
                Text(
                  "n.dateCreated.toString()",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontFamily: classicFont, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
