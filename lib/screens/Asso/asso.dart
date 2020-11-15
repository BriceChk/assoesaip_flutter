import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

class Association extends StatelessWidget {
  final List<List<String>> associations = [
    [
      'assets/images/SuperBowlLogo.png',
      'BDE - Bureau des étudiants',
      'Le BDE est une équipe active et impliquée qui dynamise le quotidien de l\'ensemble des étudiants de l\'école en organisant et animant des activités culturelles et de loisirs.',
    ],
  ];

  static final List<String> menuAssoList = [
    "Accueil",
    "Actu",
    "Membres",
    "Partenariats",
  ];
  final menuAssoMap = menuAssoList.asMap();

  int assoIndex = 0;

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    //* Display the asso menu
                    children: _buildMenu(),
                  ),
                ),
              ),
            ),
          ),
        ),
        Text("Here some text"),
      ],
    );
  }

  //* function of the menu desgin
  Widget _news(bool isActive) {
    //* Padding for each text in the menu
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddinghorizontal - 10),
      //* Gesture Detector to know if the user tap of the menu
      child: GestureDetector(
          onTap: () {
            //! Problem here, retrieve the index maybe with :
            //! https://stackoverflow.com/questions/54990716/flutter-get-iteration-index-from-list-map
            //! J'avais réussie a avoir un truc mais ca me donnait pas l'index mais la valeur de celle-ci comme "accueil"
          },
          //* Display the right text
          child: Text(
            menuAssoMap[assoIndex],
            style: TextStyle(fontSize: 18),
          )),
    );
  }

  List<Widget> _buildMenu() {
    List<Widget> menuNumber = [];
    for (int i = 0; i < menuAssoList.length; i++) {
      if (assoIndex == i) {
        menuNumber.add(_news(true));
      } else {
        menuNumber.add(_news(false));
      }
      assoIndex++;
    }
    assoIndex = 0;
    return menuNumber;
  }
}
