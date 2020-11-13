// HomePage when the user connect: AppBar + Carousel event + CustomScrollVertical vertical

import 'package:assoesaip_flutter/screens/HomePage/carousel.dart';
import 'package:assoesaip_flutter/screens/HomePage/news.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      //! I don't know why but apparently that the things i was missing
      physics: BouncingScrollPhysics(),
      slivers: [
        //* SliverAppBar to have the animation
        SliverAppBar(
          backgroundColor: white,
          //* Height of the picture (carousel)
          expandedHeight: 370,
          stretch: true,
          //* Stretch mode remove or add some features
          flexibleSpace: FlexibleSpaceBar(stretchModes: [
            StretchMode.zoomBackground,
            StretchMode.blurBackground,
          ], background: CarouselWidget()),
        ),
        //* Others widget from the page here only the news (for now)
        SliverList(
          delegate: SliverChildListDelegate(
            [
              NewsWidget(),
            ],
          ),
        )
      ],
    );
  }
}
