import 'package:assoesaip_flutter/screens/Asso/AssoCategories/SubCategories/Menu/actu.dart';
import 'package:assoesaip_flutter/screens/Asso/SpecificAsso/Menu/member.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

import 'Menu/accueil.dart';
import 'Menu/partenariat.dart';

final String classicFont = "Nunito";
final Color backgroundColor = whiteWhite;
final Color menuColorSelected = powderBlue;

class BodyAsso extends StatefulWidget {
  @override
  _BodyAssoState createState() => _BodyAssoState();
}

class _BodyAssoState extends State<BodyAsso> {
  final GlobalKey<_MenuSubCategoriesAssociationsState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final List<Widget> test = [
      Accueil(),
      Actu(),
      Members(),
      Partenariats(),
    ];
    return Column(children: [
      //* Widget with all the name of the categories of the association
      MenuSubCategoriesAssociations(
        key: _key,
        function: refreshmethod,
      ),
      menuAssoIndexSelected == 0
          ? test[0]
          : menuAssoIndexSelected == 1
              ? test[1]
              : menuAssoIndexSelected == 2
                  ? test[2]
                  : test[3],
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
    ["Accueil", "Selected"],
    ["Actu", "Unselected"],
    ["Membres", "Unselected"],
    ["Partenariats", "Unselected"]
  ];
  @override
  Widget build(BuildContext context) {
    final menuMap = menuList.asMap();

    final BorderRadius menuBorder = BorderRadius.all(Radius.circular(10));

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Row(
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
                                    menuList[menuAssoIndexSelected][1] =
                                        "Unselected";
                                    element[1] = "Selected";
                                    menuAssoIndexSelected = i;
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
          ],
        ),
      ),
    );
  }
}
