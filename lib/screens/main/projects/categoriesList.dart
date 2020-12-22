import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

final Color fontColor = Colors.black;

final BorderRadius borderHeader = BorderRadius.only(
  bottomLeft: Radius.circular(25),
  bottomRight: Radius.circular(25),
);

class CategoriesList extends StatefulWidget {
  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
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
          backgroundColor: hearderColor,
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
    return Container(
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
            Text(
              "Parcourir les projets",
              style: TextStyle(
                fontSize: 30,
                color: fontColor,
                fontFamily: classicFont,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Découvre les clubs et associations de ton campus !",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                color: fontColor,
                fontFamily: classicFont,
              ),
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
      "assets/images/AssoCategories/Student.png"
    ],
    [
      "Arts & culture",
      "Théâtre, musique, découvertes culturelles et événementiel",
      "assets/images/AssoCategories/Art.png"
    ],
    [
      "Sport",
      "Entraînement, championnats, tournois, événements",
      "assets/images/AssoCategories/Sport.png"
    ],
    [
      "Jeux",
      "Jeux vidéos, de plateau et activités ludiques",
      "assets/images/AssoCategories/Game.png"
    ],
    [
      "Environnement",
      "Futurs ingénieurs et déjà responsables: des projets pour un développement durable",
      "assets/images/AssoCategories/Environment.png"
    ],
    [
      "Humanitaire",
      "Missions humanitaires",
      "assets/images/AssoCategories/Humanitarian.png"
    ],
    [
      "Réseaux & partenariats & un gros test",
      "Projets en lien avec les entreprises ou le réseau La Salle",
      "assets/images/AssoCategories/Network.png"
    ],
    [
      "Vie étudiante",
      "La vie des étudiants sur les campus de l'esaip",
      "assets/images/AssoCategories/Student.png"
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
                        onTap: () {
                          assoNameString = element[0];
                          assoDescriptionString = element[1];
                          //* Pushing through the new page with a specific name
                          //TODO_ print(element[0] + " tapped");
                          Navigator.of(context).pushNamed("Category");
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
