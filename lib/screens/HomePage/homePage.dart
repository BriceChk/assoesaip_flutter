// HomePage when the user connect: AppBar + Carousel event + ListView vertical

import 'package:assoesaip_flutter/screens/HomePage/carousel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Carousel(),
          ],
        ),
      ),
    );
  }
}
