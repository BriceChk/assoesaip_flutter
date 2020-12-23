import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

import 'tabs/actu.dart';
import 'tabs/calendrier.dart';
import 'tabs/projets.dart';

class CategoryBody extends StatefulWidget {
  @override
  _CategoryBodyState createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  final Map<String, Widget> tabs = {
    "Clubs & assos": ProjectsList(),
    "Actus": CategoryNews(),
    "Calendar": CategoryCalendar(),
  };

  String selected;

  @override
  void initState() {
    super.initState();
    selected = tabs.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      //* Widget with all the name of the categories of the association
      _buildCategoryTabs(),
      tabs[selected],
      //* Sizedbox of height 60 because otherwise the last one is under the navbar
      SizedBox(height: 60),
    ]);
  }

  Widget _buildCategoryTabs() {
    List<Widget> list = List();

    tabs.keys.forEach((tab) {
      Widget w = Container(
        decoration: BoxDecoration(
            color: selected == tab ? menuColorSelected : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 5, horizontal: 10),
          child: Text(
            tab,
            style: TextStyle(
              fontSize: 18,
              fontFamily: classicFont,
            ),
          ),
        ),
      );

      if (selected == tab) {
        list.add(w);
      } else {
        list.add(GestureDetector(
          child: w,
          onTap: () {
            setState(() {
              selected = tab;
            });
          },
        ));
      }
    });

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: list
        ),
      ),
    );
  }
}