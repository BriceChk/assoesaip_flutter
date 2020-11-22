import 'package:assoesaip_flutter/screens/Asso/AssoCategories/assoSubCategories.dart';
import 'package:assoesaip_flutter/screens/Asso/asso.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

class AssociationCategories extends StatefulWidget {
  @override
  _AssociationCategoriesState createState() => _AssociationCategoriesState();
}

class _AssociationCategoriesState extends State<AssociationCategories> {
  final List<List<String>> assoCategoriesList = [
    [
      "Vie étudiante",
      "La vie des étudiants sur les campus de l'esaip",
    ],
    [
      "Arts & culture",
      "Théâtre, musique, découvertes culturelles et événementiel",
    ],
    [
      "Sport",
      "Entraînement, championnats, tournois, événements",
    ],
    [
      "Jeux",
      "Jeux vidéos, de plateau et activités ludiques",
    ],
    [
      "Environnement",
      "Futurs ingénieurs et déjà responsables: des projets pour un développement durable",
    ],
    [
      "Humanitaire",
      "Missions humanitaires",
    ],
    [
      "Réseaux & partenariats",
      "Projets en lien avec les entreprises ou le réseau La Salle",
    ],
  ];

  @override
  Widget build(BuildContext context) {
    final assoCategoriesMap = assoCategoriesList.asMap();

    return ListView(
      children: [
        //* Container with the text page presentation
        Container(
          //* We are taking all the available space or size. Here the width of the screen
          width: MediaQuery.of(context).size.width,
          height: 150,
          color: blue_2,
          //* In order to have a padding horizontaly
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            //* Column in order to have 2 differents text widget one under the others
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Bienvenue !",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Découvre les clubs et associations qui font vivre l'esaip, leurs actualités et les prochains événement sur ton campus",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //* Display the asso menu
          children: assoCategoriesMap
              .map(
                (i, element) => MapEntry(
                  i,
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Container(
                      //! color: Colors.green,
                      height: 75,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        elevation: 0.5,
                        shadowColor: blue_0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: white,
                        child: InkWell(
                            splashColor: blue_2,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    element[0],
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    element[1],
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              print(element[0] + " tapped");
                              Navigator.of(context).pushNamed("Test");
                            }),
                      ),
                    ),
                  ),
                ),
              )
              .values
              .toList(),
        ),
      ],
    );
  }
}
