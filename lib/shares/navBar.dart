import 'package:assoesaip_flutter/screens/Asso/AssoCategories/assoBuilder.dart';
import 'package:assoesaip_flutter/screens/HomePage/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'constant.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => new _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  //TODO_ variable
  int _pageIndex = 0;
  PageController _pageController;

  //TODO_ Page of the App
  List<Widget> tabPages = [
    HomePage(),
    Text("Calendrier"),
    AssoBuilder(),
    //Association(),
    Text("Cafet"),
  ];

  //TODO_ Colors
  Color selectedColor = blue_0;
  Color unselectedColor = blue_0;
  Color circleSelectedColor = blue_2;
  Color scaffoldBackgroundColor = white;
  Color navBarColor = blue_3.withOpacity(0.2);

  ShapeBorder bottomBarShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(25),
      topLeft: Radius.circular(25),
    ),
  );

  final bottomShape = BorderRadius.only(
    topRight: Radius.circular(25),
    topLeft: Radius.circular(25),
  );

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: bottomShape,
        ),
        child: SnakeNavigationBar.color(
          //* Here we have all the option of the navBar
          behaviour: SnakeBarBehaviour.pinned,
          snakeShape: SnakeShape.circle,
          shape: bottomBarShape,
          snakeViewColor: selectedColor,
          selectedItemColor: SnakeShape.circle == SnakeShape.indicator
              ? selectedColor
              : circleSelectedColor,
          unselectedItemColor: unselectedColor,
          backgroundColor: navBarColor,

          ///configuration for SnakeNavigationBar.gradient
          //snakeViewGradient: selectedGradient,
          //selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
          //unselectedItemGradient: unselectedGradient,

          showUnselectedLabels: true,

          currentIndex: _pageIndex,
          onTap: onTabTapped,

          //* Here we have the different icons for each pages
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_rounded),
              label: 'Calendrier',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'Clubs & assos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fastfood),
              label: 'Cafet\'',
            ),
          ],
        ),
      ),
      //* Here we have the changes of the page with the called function
      body: PageView(
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(index,
        duration: const Duration(milliseconds: 1), curve: Curves.easeInOut);
  }
}
