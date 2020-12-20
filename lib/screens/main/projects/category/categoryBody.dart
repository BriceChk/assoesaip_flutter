import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

import 'tabs/actu.dart';
import 'tabs/projets.dart';
import 'tabs/calendrier.dart';

final String classicFont = "Nunito";
final Color backgroundColor = whiteWhite;
final Color menuColorSelected = powderBlue;

class CategoryBody extends StatefulWidget {
  @override
  _CategoryBodyState createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  final GlobalKey<_MenuSubCategoriesAssociationsState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final List<Widget> test = [
      Projets(),
      Actu(),
      Calendrier(),
    ];

    return Column(children: [
      //* Widget with all the name of the categories of the association
      MenuSubCategoriesAssociations(
        key: _key,
        function: refreshmethod,
      ),
      menuIndexSelected == 0
          ? test[0]
          : menuIndexSelected == 1
              ? test[1]
              : test[2],
      //* Sizedbox of height 60 because otherwise the last one is under the navbar
      SizedBox(height: 60),
    ]);
  }

  refreshmethod() {
    setState(() {});
  }
}

class MenuSubCategoriesAssociations extends StatefulWidget {
  final Function function;

  MenuSubCategoriesAssociations({Key key, this.function}) : super(key: key);

  @override
  _MenuSubCategoriesAssociationsState createState() =>
      _MenuSubCategoriesAssociationsState();
}

class _MenuSubCategoriesAssociationsState
    extends State<MenuSubCategoriesAssociations> {
  final List<List<String>> menuList = [
    ["Projets", "Selected"],
    ["Actu", "Unselected"],
    ["Calendrier", "Unselected"]
  ];

  @override
  Widget build(BuildContext context) {
    final menuMap = menuList.asMap();

    final BorderRadius menuBorder = BorderRadius.all(Radius.circular(10));

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: menuMap
              .map(
                (i, element) => MapEntry(
                  i,
                  element[1] == "Unselected"
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 5, horizontal: 7.5),
                          child: GestureDetector(
                            onTap: () {
                              widget.function();
                              setState(() {
                                menuList[menuIndexSelected][1] = "Unselected";
                                element[1] = "Selected";
                                menuIndexSelected = i;
                              });
                            },
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Text(
                                  element[0],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: classicFont,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 5, horizontal: 7.5),
                          child: Container(
                            decoration: BoxDecoration(
                                color: menuColorSelected,
                                borderRadius: menuBorder),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Text(
                                element[0],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: classicFont,
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              )
              .values
              .toList(),
        ),
      ),
    );
  }
}
