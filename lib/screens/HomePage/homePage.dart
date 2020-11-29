// HomePage when the user connect: AppBar + Carousel event + CustomScrollVertical vertical

import 'package:assoesaip_flutter/screens/HomePage/carousel.dart';
import 'package:assoesaip_flutter/screens/HomePage/news.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final String classicFont = "Nunito";
    final Color backgroundColor = white;

    return Container(
      color: backgroundColor,
      child: CustomScrollView(
        //! I don't know why but apparently that the things i was missing
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(top: 10),
            sliver: SliverFloatingBar(
              elevation: 2,
              backgroundColor: white,
              leading: Container(
                height: double.infinity,
                width: MediaQuery.of(context).size.width - 110,
                child: Center(
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                      hintText: "Rechercher dans les actualités...",
                    ),
                    style: TextStyle(
                      fontFamily: classicFont,
                    ),
                  ),
                ),
              ),
              trailing: CircleAvatar(
                child: Text(
                  "CB",
                  style: TextStyle(
                    fontFamily: classicFont,
                  ),
                ),
              ),
            ),
          ),
          //* SliverAppBar to have the animation
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: white,
            //* Height of the picture (carousel)
            expandedHeight: 320,
            stretch: true,
            //* Stretch mode remove or add some features
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: CarouselWidget(),
            ),
          ),
          //* Others widget from the page here only the news (for now)
          SliverList(
            delegate: SliverChildListDelegate(
              [
                NewsWidget(),
                SizedBox(height: 55),
              ],
            ),
          )
        ],
      ),
    );
  }
}
