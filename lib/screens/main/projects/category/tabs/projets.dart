import 'file:///C:/Users/brice/Desktop/assoesaip_flutter/lib/screens/main/projects/categoriesList.dart';
import 'package:assoesaip_flutter/screens/main/projects/project/project.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

class Projets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<List<String>> assoList = [
      [
        "BDS - Bureau des sports",
        "Le BDS c'est une équipe motivée et engagée qui encadre et accompagne toutes les activités sportives au sein de l'école.",
      ],
      [
        "SlyCAP'",
        "Organisation d'événements sportifs ayant pour but de donner accès aux sports nautiques à des personnes en situation de handicap et de sensibiliser le public.",
      ]
    ];

    final List<List<String>> clubList = [
      [
        "BDS - Bureau des sports",
        "Asso'coeur",
        "Réaliser un tournoi de football entre écoles facultés d'Angers à but humanitaire.",
      ],
      [
        "BDS - Bureau des sports",
        "Sport's Way",
        "Un évènement ludique pour découvrir les sports émergents angevins !",
      ],
      [
        "BDS - Bureau des sports",
        "Tournois Floorball 2020",
        "Test",
      ],
      [
        "SlyCAP'",
        "Test in sly",
        "Ceci est la description du test",
      ]
    ];

    final RoundedRectangleBorder roundedCorner = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    );

    final assoMap = assoList.asMap();
    final clubMap = clubList.asMap();
    final cardColor = white;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        child: Column(
          children: assoMap
              .map(
                (j, element) => MapEntry(
                  j,
                  //* Here we're building each card with each name of the specific association
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Container(
                          constraints: BoxConstraints(minHeight: 80),
                          width: double.infinity,
                          child: Card(
                            shape: roundedCorner,
                            color: cardColor,
                            margin: EdgeInsets.all(0),
                            child: InkWell(
                              onTap: () {
                                print(element[0]);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Project()));
                              },
                              borderRadius: BorderRadius.circular(10),
                              splashColor: splashColor,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Text(
                                      element[0],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: classicFont,
                                        color: titleColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Text(
                                      element[1],
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: classicFont,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: clubMap
                            .map(
                              (i, element) => MapEntry(
                                i,
                                //* Here we're building each card with each name of the specific association
                                element[0] == assoList[j][0]
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            right: 15, left: 15, bottom: 10),
                                        child: Container(
                                          constraints:
                                              BoxConstraints(minHeight: 80),
                                          width: double.infinity,
                                          child: Card(
                                            shape: roundedCorner,
                                            margin: EdgeInsets.all(0),
                                            color: Colors.grey[200],
                                            child: InkWell(
                                              onTap: () {
                                                print(element[1]);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            Project()));
                                              },
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              splashColor: splashColor,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      element[1],
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontFamily: classicFont,
                                                        color: titleColor,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      element[2],
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: classicFont,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ),
                            )
                            .values
                            .toList(),
                      )
                    ],
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
