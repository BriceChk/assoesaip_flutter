// HomePage when the user connect: AppBar + Carousel event + CustomScrollVertical vertical

import 'package:assoesaip_flutter/screens/HomePage/carousel.dart';
import 'package:assoesaip_flutter/screens/HomePage/news.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:assoesaip_flutter/shares/navBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color selectedColor = blue_1;
  ShapeBorder bottomBarShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(25),
      topLeft: Radius.circular(25),
    ),
  );

  int _selectedItemPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: CustomScrollView(
        //! I don't know why but apparently that the things i was missing
        physics: BouncingScrollPhysics(),
        slivers: [
          //* SliverAppBar to have the animation
          SliverAppBar(
            backgroundColor: white,
            //* Height of the picture (carousel)
            expandedHeight: 275,
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
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.pinned,
        snakeShape: SnakeShape.circle,
        shape: bottomBarShape,

        ///configuration for SnakeNavigationBar.color
        snakeViewColor: selectedColor,
        selectedItemColor:
            SnakeShape.circle == SnakeShape.indicator ? selectedColor : null,
        unselectedItemColor: blue_1,

        ///configuration for SnakeNavigationBar.gradient
        //snakeViewGradient: selectedGradient,
        //selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
        //unselectedItemGradient: unselectedGradient,

        showUnselectedLabels: true,

        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() => _selectedItemPosition = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendrier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Club & Asso',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Cafet\'',
          ),
        ],
      ),
    );
  }
}
