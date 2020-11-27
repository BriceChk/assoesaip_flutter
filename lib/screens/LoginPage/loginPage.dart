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

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: white,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.25,
              width: MediaQuery.of(context).size.width,
              decoration:
                  BoxDecoration(color: blue_2, borderRadius: roundedBorder1),
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 150,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    child: Text(
                      "Bienvenue sur\nAsso'esaip",
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: blue_2,
                child: Container(
                  decoration:
                      BoxDecoration(color: white, borderRadius: roundedBorder2),
                  child: Column(
                    children: [
                      SizedBox(height: 25),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed leo.",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: Image.asset(
                          "assets/images/key.png",
                          height: 150,
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: RaisedButton(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: blue_0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                'Connectez vous',
                                style: TextStyle(fontSize: 20, color: white),
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
