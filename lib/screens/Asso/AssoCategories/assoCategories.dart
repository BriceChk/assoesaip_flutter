import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

class AssociationCategories extends StatefulWidget {
  @override
  _AssociationCategoriesState createState() => _AssociationCategoriesState();
}

class _AssociationCategoriesState extends State<AssociationCategories> {
  @override
  Widget build(BuildContext context) {
    //* Using the CustomScroolView in order to have the bouncingScrollPhysic
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        //* We wrap our header inside the sliverAppBar with somme properties
        SliverAppBar(
          centerTitle: true,
          actions: [
            Header(),
          ],
          toolbarHeight: 130,
          pinned: true,
          backgroundColor: blue_2,
        ),
        //* We wrap the rest of the page inside the SliverList: like this everything scrool vertically except the header
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SizedBox(
                height: 5,
              ),
              //* Widget with all the name of the categories of the association
              AssociationBuilder(),
              //* Sizedbox of height 60 because otherwise the last one is under the navbar
              SizedBox(
                height: 60,
              ),
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
    return Container(
      width: MediaQuery.of(context).size.width,
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
              "Découvre les clubs et associations qui font vivre l'esaip, leurs actualités et les prochains événement sur ton campus.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class AssociationBuilder extends StatelessWidget {
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
    [
      "Vie étudiante",
      "La vie des étudiants sur les campus de l'esaip",
    ],
  ];
  @override
  Widget build(BuildContext context) {
    final assoCategoriesMap = assoCategoriesList.asMap();
    return Column(
      //* Display the asso menu
      children: assoCategoriesMap
          .map(
            (i, element) => MapEntry(
              i,
              //* Here we're building each card with each name of the specific association
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
                    //* InkWell like this we can integrate the ontap function
                    child: InkWell(
                        splashColor: blue_2,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          //* Pushing through the new page with a specific name
                          //TODO_ print(element[0] + " tapped");
                          Navigator.of(context).pushNamed("Test");
                        }),
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
