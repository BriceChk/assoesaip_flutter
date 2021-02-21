import 'package:assoesaip_flutter/shares/constants.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          color: COLOR_AE_BLUE,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 100,
                fit: BoxFit.fitHeight,
              ),
              SizedBox(height: 30,),
              Text(
                'Chargement en cours',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'Nunito'
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
