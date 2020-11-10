import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import 'constant.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    Color selectedColor = blue_1;

    ShapeBorder bottomBarShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(25),
        topLeft: Radius.circular(25),
      ),
    );

    int _selectedItemPosition = 0;

    return SnakeNavigationBar.color(
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
    );
  }
}
