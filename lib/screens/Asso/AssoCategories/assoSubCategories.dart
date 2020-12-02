import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

final String classicFont = "Nunito";
final Color backgroundColor = whiteWhite;
final Color hearderColor = skyBlueCrayola1;
final Color menuColorSelected = powderBlue;

class Test extends StatelessWidget {
  final RoundedRectangleBorder roundedBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(25),
    ),
  );
  @override
  Widget build(BuildContext context) {
    //* Container of the page
    return Container(
      color: backgroundColor,
      //* CustomScrollView in order to have the bouncingScrollPhysic
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          //* SliverAppBar in order to have the same as the page before
          SliverAppBar(
            //* Shape of the AppBar with the roundedBorder
            shape: roundedBorder,
            //* Here we have the HeaderWidget
            actions: [
              Header(),
            ],
            toolbarHeight: 130,
            pinned: true,
            backgroundColor: ceruleanCrayola,
          ),
          //* All the other Widget
          SliverList(
            delegate: SliverChildListDelegate(
              [
                //* Widget with all the name of the categories of the association
                BodyAssoSubCategories(),
                SizedBox(height: 55)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  final BorderRadius borderHeader = BorderRadius.only(
    bottomLeft: Radius.circular(25),
    bottomRight: Radius.circular(25),
  );

  @override
  Widget build(BuildContext context) {
    final Color fontColor = Colors.black;
    //* Container which wrapping the hearder of the app
    return Container(
      //* Taking all the width available
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: hearderColor,
        borderRadius: borderHeader,
      ),

      //* In order to have a padding horizontaly
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        //* Column in order to have 2 differents text widget one under the others
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //* Row because we cant the arrow and the name of the specific association
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //* GestureDetector in order to detect if the user tap on it
                GestureDetector(
                  child: Icon(
                    Icons.arrow_back,
                    color: navyBlue,
                  ),
                  //* Pushing back to the AssociationCategories
                  onTap: () {
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName("AssociationCategories"));
                  },
                ),
                SizedBox(width: 15),
                //* Flexible like this we can have a long text and multiline text
                Flexible(
                  //* Column which is combined with the flexible for the multiline
                  child: Column(
                    children: [
                      //* Name of the association
                      Text(
                        assoNameString,
                        style: TextStyle(
                            fontSize: 25,
                            color: fontColor,
                            fontFamily: classicFont),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            //* Description of the association
            Container(
              child: Text(
                assoDescriptionString,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  color: fontColor,
                  fontFamily: classicFont,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BodyAssoSubCategories extends StatefulWidget {
  @override
  _BodyAssoSubCategoriesState createState() => _BodyAssoSubCategoriesState();
}

class _BodyAssoSubCategoriesState extends State<BodyAssoSubCategories> {
  final GlobalKey<_MenuSubCategoriesAssociationsState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final List<Widget> test = [
      Container(child: Text("Projets")),
      Container(child: Text("Actu")),
      Container(child: Text("Calendrier"))
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
