import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:assoesaip_flutter/shares/navBar.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BorderRadius roundedBorder1 = BorderRadius.only(
      bottomRight: Radius.circular(75),
    );
    final BorderRadius roundedBorder2 = BorderRadius.only(
      topLeft: Radius.circular(75),
    );

    final Color backgroundColorBlue = skyBlueCrayola1.withOpacity(0.9);
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
                borderRadius: roundedBorder1,
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
                    borderRadius: roundedBorder2,
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
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed leo.",
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
                          color: navyBlue,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            //* Container in order to have the button which takes all the available width
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                'Connectez-vous',
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NavigationBar()),
                            );
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
