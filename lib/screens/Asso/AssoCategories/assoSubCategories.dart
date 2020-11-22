import 'package:assoesaip_flutter/screens/HomePage/news.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: Text("Test"),
          centerTitle: true,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
          color: white,
          alignment: Alignment.center,
          child: ListView(children: [NewsWidget()]),
        ),
      ),
    );
  }
}
