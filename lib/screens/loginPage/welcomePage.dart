import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BorderRadius roundedBottomRightBorder = BorderRadius.only(
      bottomRight: Radius.circular(50),
    );
    final BorderRadius roundedTopLeftBorder = BorderRadius.only(
      topLeft: Radius.circular(50),
    );

    final Color backgroundColorBlue = starCommandBlue;
    final Color backgroundColorWhite = whiteWhite;
    final String classicFont = "Nunito";

    //* Return a Scaffold widget because of the text we are including inside
    return Scaffold(
      body: Container(
        //* First container which taking all the screen space (responsive to all size)
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: backgroundColorWhite,
        //* Column because we want to display 2 distinct container (blue and white one)
        child: Column(
          children: [
            //* First container with the color blue
            Container(
              height: MediaQuery.of(context).size.height / 2.25,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: backgroundColorBlue,
                borderRadius: roundedBottomRightBorder,
              ),
              //* Column in order to have the object inside the container align
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //* Logo esaip inside a container
                  Container(
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 150,
                    ),
                  ),
                  //* Classic text inside a container
                  Container(
                    child: Text(
                      "Bienvenue sur\nAsso'esaip",
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: classicFont,
                        color: Colors.white
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            //* Expanded because we want that this widget take all the available space
            Expanded(
              //* 2 container stack on each other in order to have the rounded color the same as the upper container (blue)
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: backgroundColorBlue,
                //* Container with all the others object inside with the color white
                child: Container(
                  decoration: BoxDecoration(
                    color: backgroundColorWhite,
                    borderRadius: roundedTopLeftBorder,
                  ),
                  //* Column with the all the object align to each other
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //* Container with the trash text
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          child: Text(
                            "Découvre les clubs et assos de ton campus, leurs actus et les prochains événements.",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: classicFont,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      //* Container with the image of the key
                      Container(
                        child: Image.asset(
                          "assets/images/key.png",
                          height: 150,
                        ),
                      ),
                      //* Container with the button log in
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: RaisedButton(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: starCommandBlue,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            //* Container in order to have the button which takes all the available width
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                'Connexion',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: white,
                                  fontFamily: "Nunito",
                                  letterSpacing: 1.25,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/welcome/login');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
