// HomePage when the user connect: AppBar + Carousel event + CustomScrollVertical vertical

import 'package:assoesaip_flutter/screens/HomePage/carousel.dart';
import 'package:assoesaip_flutter/screens/HomePage/news.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        //* Here container tp wrap the column in order to have the size of the listView here the size of the screen
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          //* CustomScrollView because we cant the silver app and we need to scrool through the page
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                //* Height cause it's mandatory for if we want to dusplay something
                expandedHeight: 275,
                //! Strech doesn't work why ????
                stretch: true,
                //* Here we display the thing we want to display: for that wrap in FlexibleSpaceBar
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: CarouselWidget(),
                  //! Differents mode of strech when it would work XDDD
                  /*stretchModes: [
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                  ],*/
                ),
              ),
              //* SliverList because we want to show the rest of the page (news)
              SliverList(
                delegate: SliverChildListDelegate(
                  [NewsWidget()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
