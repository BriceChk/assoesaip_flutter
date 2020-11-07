// HomePage when the user connect: AppBar + Carousel event + ListView vertical

import 'package:assoesaip_flutter/screens/HomePage/carousel.dart';
import 'package:assoesaip_flutter/screens/HomePage/news.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* Here container tp wrap the column in order to have the size of the listView here the size of the screen
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        //* stack with the carousel and the other things: the news mainly
        //* I use here stack cause we want 2 things carousel and news superpose
        child: ListView(
          children: <Widget>[
            CarouselWidget(),
            //* Positionned because we want the news to be align just under the carousel indicator
            Transform.translate(
              offset: Offset(0, -40),
              child: NewsWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
