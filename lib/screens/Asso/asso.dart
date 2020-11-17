import 'package:assoesaip_flutter/screens/Asso/assoSubMenu.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

class Association extends StatefulWidget {
  static final List<List<String>> menuAssoList = [
    ["Accueil", "1"],
    ["Actu", "0"],
    ["Membres", "0"],
    ["Partenariats", "0"],
  ];

  @override
  _AssociationState createState() => _AssociationState();
}

class _AssociationState extends State<Association> {
  final List<List<String>> associations = [
    [
      'assets/images/SuperBowlLogo.png',
      'BDE - Bureau des étudiants',
      'Le BDE est une équipe active et impliquée qui dynamise le quotidien de l\'ensemble des étudiants de l\'école en organisant et animant des activités culturelles et de loisirs.',
    ],
  ];

  final menuAssoMap = Association.menuAssoList.asMap();

  final double paddinghorizontal = 15;

  @override
  Widget build(BuildContext context) {
    //! Wrap in container with the color white because of the "extendbody: true" in navbar.
    return ListView(
      children: <Widget>[
        //* We want the rounded border on the bottom so we wrap it in a container
        Container(
          decoration: BoxDecoration(
            color: blue_2,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          //* Here we want all the basics information about the association
          child: Column(
            children: [
              //* Container witht the picture or logo of the association
              Container(
                height: 100,
                width: 100,
                //TODO_color: Colors.black,
                child: Image.asset(
                  associations[0][0],
                ),
              ),
              SizedBox(height: 10),
              //* Name of the association
              Padding(
                padding: EdgeInsets.symmetric(horizontal: paddinghorizontal),
                child: Container(
                  //TODO_color: Colors.amber,
                  child: Text(
                    associations[0][1],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              //* Small introduction in text of the association
              Padding(
                padding: EdgeInsets.symmetric(horizontal: paddinghorizontal),
                child: Container(
                  //TODO_color: Colors.yellow,
                  child: Text(
                    associations[0][2],
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
        //* Offset because we want the overlay of the menu on the container
        Transform.translate(
            offset: Offset(0, -20),
            //* Padding of each side of the menu
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              //* Wrap the menu in a container for the color, roundedborder and the size of it
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: 50,
                //! Specific size: it's the padding*2 that we need to indicate otherwise overflow !!!
                width: MediaQuery.of(context).size.width - 70,
                //* Slider on the axis horizontal
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  //* Pading of each side of the container
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: paddinghorizontal - 5),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      //* Display the asso menu
                      children: menuAssoMap
                          .map((i, element) => MapEntry(
                              i,
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  child: GestureDetector(
                                    child: element[1] == "1"
                                        ? Text(
                                            element[0],
                                            style: TextStyle(
                                                fontSize: 18, color: blue_3),
                                          )
                                        : Text(
                                            element[0],
                                            style: TextStyle(fontSize: 18),
                                          ),
                                    onTap: () {
                                      setState(() {
                                        menuAssoMap[assoIndex][1] = "0";
                                        assoIndex = i;
                                        element[1] = "1";
                                      });
                                    },
                                  ),
                                ),
                              )))
                          .values
                          .toList(),
                    ),
                  ),
                ),
              ),
            )),
        AssoSubMenu(),
      ],
    );
  }
}
