import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

class Association extends StatelessWidget {
  final List<List<String>> associations = [
    [
      'assets/images/HomePage/event_1.jpg',
      'BDE - Bureau des étudiants',
      'Le BDE est une équipe active et impliquée qui dynamise le quotidien de l\'ensemble des étudiants de l\'école en organisant et animant des activités culturelles et de loisirs.',
    ],
  ];

  final List<String> menu_asso = [
    'Accueil',
    'Actu',
    'Membres',
    'Partenariats',
    'La Cafet\'',
  ];

  final double padding_horizontal = 15;
  final double font_size_asso = 18;

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //* ListView because we want to scroll through the information about each association
      body: ListView(
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
                  padding: EdgeInsets.symmetric(horizontal: padding_horizontal),
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
                  padding: EdgeInsets.symmetric(horizontal: padding_horizontal),
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
                    color: white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: 50,
                //! Specific size: it's the padding*2 that we need to indicate otherwise overflow !!!
                width: MediaQuery.of(context).size.width - 70,
                //* Slider on the axis horizontal
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  //* Pading of each side of the container
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: padding_horizontal - 5),
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
        ],
      ),
    );
  }

  //* function of the menu desgin
  Widget _news(bool isActive) {
    //* Padding for each text in the menu
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding_horizontal - 10),
      //* Gesture Detector to know if the user tap of the menu
      child: GestureDetector(
        onTap: () {},
        //* Display the right text
        child: Text(
          menu_asso[currentIndex],
          style: TextStyle(
            fontSize: font_size_asso,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildMenu() {
    List<Widget> menuNumber = [];
    for (int i = 0; i < menu_asso.length; i++) {
      if (currentIndex == i) {
        menuNumber.add(_news(true));
      } else {
        menuNumber.add(_news(false));
      }
      currentIndex++;
    }
    return menuNumber;
  }
}
