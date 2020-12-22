import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final String classicFont = "Nunito";
final Color cardColor = white;
final Color shadowColor = navyBlue;
final Color fontColor = Colors.white;
final Color titleColor = navyBlue;
final Color splashColor = skyBlueCrayola1;

class CafetWidget extends StatefulWidget {
  @override
  _CafetWidgetState createState() => _CafetWidgetState();
}

class _CafetWidgetState extends State<CafetWidget> {
  final RoundedRectangleBorder roundedBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(25),
    ),
  );

  @override
  Widget build(BuildContext context) {
    //* Using the CustomScroolView in order to have the bouncingScrollPhysic
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        //* We wrap our header inside the sliverAppBar with somme properties
        SliverAppBar(
          shape: roundedBorder,
          centerTitle: true,
          actions: [
            Header(),
          ],
          toolbarHeight: 130,
          pinned: true,
          backgroundColor: headerColor,
        ),
        //* We wrap the rest of the page inside the SliverList: like this everything scrool vertically except the header
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SizedBox(
                height: 5,
              ),
              //* Widget with all cards for meals, drinks and desserts
              TextField(
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Liste des repas'),
              ),
              Repas(),
              TextField(
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Liste des boissons'),
              ),
              Boisson(),
              TextField(
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Liste des desserts'),
              ),
              Dessert(),
              //* Sizedbox of height 60 because otherwise the last one is under the navbar
              SizedBox(height: 60),
            ],
          ),
        ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formatDate = DateFormat('EEEE', 'fr_FR').format(DateTime.now());
    //TODO Si passé 13h, afficher le menu du lendemain

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: headerColor,
        borderRadius: headerBorder,
      ),

      //* In order to have a padding horizontaly
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        //* Column in order to have 2 differents text widget one under the others
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Menu de " + '$formatDate',
              style: TextStyle(
                fontSize: 30,
                color: headerTextColor,
                fontFamily: classicFont,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class Repas extends StatelessWidget {
  final List<List<String>> repasList = [
    [
      "Repas 1",
      "Composant 1, Composant 2, ....",
      "assets/images/Cafet/Repas/repas1.jpeg"
    ],
    [
      "Repas 2",
      "Composant 1, Composant 2, ....",
      "assets/images/Cafet/Repas/repas2.jpg"
    ],
    [
      "Repas 3",
      "Composant 1, Composant 2, ....",
      "assets/images/Cafet/Repas/repas3.jpg"
    ],
    [
      "Repas 4",
      "Composant 1, Composant 2, ....",
      "assets/images/Cafet/Repas/repas4.jpg"
    ],
    [
      "Repas 5",
      "Composant 1, Composant 2, ....",
      "assets/images/Cafet/Repas/repas5.jpg"
    ],
    [
      "Repas 6",
      "Composant 1, Composant 2, ....",
      "assets/images/Cafet/Repas/repas6.jpg"
    ],
  ];

  @override
  Widget build(BuildContext context) {
    final repasMap = repasList.asMap();
    return Column(
      //* Display the cafet menu
      children: repasMap
          .map(
            (i, element) => MapEntry(
              i,
              //* Here we're building each card with each name of the specific meal
              Padding(
                padding: EdgeInsets.only(top: 5, right: 10, left: 10),
                child: Container(
                  //! boxConstraints like this we can set a min height to the card and combine with flexible the height can be override
                  constraints: BoxConstraints(
                    minHeight: 90,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 0.5,
                    shadowColor: shadowColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: cardColor,
                    //* InkWell like this we can integrate the ontap function
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      splashColor: splashColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.5,
                          vertical: 5,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 75,
                              child: Image.asset(element[2]),
                            ),
                            SizedBox(width: 5),
                            //! Wrap in flexible like this we can have text in multiline
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  //* Title of card
                                  Text(
                                    element[0],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: classicFont,
                                        color: titleColor),
                                  ),
                                  //* Description of the card
                                  Text(
                                    element[1],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: classicFont,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
          .values
          .toList(),
    );
  }
}

class Boisson extends StatelessWidget {
  final List<List<String>> boissonsList = [
    ["Coca", "assets/images/Cafet/Boissons/coca.png"],
    ["Fanta", "assets/images/Cafet/Boissons/fanta.jpg"],
    ["S.Pellegrino", "assets/images/Cafet/Boissons/SanPe.png"],
    ["Sprite", "assets/images/Cafet/Boissons/Sprite.png"],
  ];

  @override
  Widget build(BuildContext context) {
    final boissonsMap = boissonsList.asMap();
    return Column(
      //* Display the drinks menu
      children: boissonsMap
          .map(
            (i, element) => MapEntry(
              i,
              //* Here we're building each card with each name of the specific drink
              Padding(
                padding: EdgeInsets.only(top: 5, right: 10, left: 10),
                child: Container(
                  //! boxConstraints like this we can set a min height to the card and combine with flexible the height can be override
                  constraints: BoxConstraints(
                    minHeight: 90,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 0.5,
                    shadowColor: shadowColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: cardColor,
                    //* InkWell like this we can integrate the ontap function
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      splashColor: splashColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.5,
                          vertical: 5,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 75,
                              child: Image.asset(element[1]),
                            ),
                            SizedBox(width: 5),
                            //! Wrap in flexible like this we can have text in multiline
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  //* Title of card
                                  Text(
                                    element[0],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: classicFont,
                                        color: titleColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
          .values
          .toList(),
    );
  }
}

class Dessert extends StatelessWidget {
  final List<List<String>> dessertsList = [
    ["Fincancier x3", "assets/images/Cafet/Desserts/dessert1.jpg"],
    ["Cookies x2", "assets/images/Cafet/Desserts/dessert2.jpg"],
    ["Brownie", "assets/images/Cafet/Desserts/dessert3.jpg"],
  ];

  @override
  Widget build(BuildContext context) {
    final dessertsMap = dessertsList.asMap();
    return Column(
      //* Display the desserts menu
      children: dessertsMap
          .map(
            (i, element) => MapEntry(
              i,
              //* Here we're building each card with each name of the specific dessert
              Padding(
                padding: EdgeInsets.only(top: 5, right: 10, left: 10),
                child: Container(
                  //! boxConstraints like this we can set a min height to the card and combine with flexible the height can be override
                  constraints: BoxConstraints(
                    minHeight: 90,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 0.5,
                    shadowColor: shadowColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: cardColor,
                    //* InkWell like this we can integrate the ontap function
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      splashColor: splashColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.5,
                          vertical: 5,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 75,
                              child: Image.asset(element[1]),
                            ),
                            SizedBox(width: 5),
                            //! Wrap in flexible like this we can have text in multiline
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  //* Title of card
                                  Text(
                                    element[0],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: classicFont,
                                        color: titleColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
          .values
          .toList(),
    );
  }
}
