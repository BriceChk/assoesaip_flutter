import 'package:assoesaip_flutter/models/user.dart';
import 'package:assoesaip_flutter/screens/main/cafet/cafet.dart';
import 'package:assoesaip_flutter/screens/main/calendar/calendar.dart';
import 'package:assoesaip_flutter/screens/main/homePage/homePage.dart';
import 'package:assoesaip_flutter/screens/main/projects/projectsNavigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import '../../shares/constant.dart';

class MainNavigation extends StatefulWidget {
  final User user;

  MainNavigation(this.user);

  @override
  _MainNavigationState createState() => new _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  //TODO_ variable
  int _pageIndex = 0;
  PageController _pageController;

  //TODO_ Page of the App
  List<Widget> tabPages = [];

  //TODO_ Colors
  Color navBarColor = starCommandBlue;
  Color selectedCircleColor = Colors.white;
  Color unselectedIconColor = Colors.white;
  Color selectedIconColor = starCommandBlue;

  Color scaffoldBackgroundColor = white;

  ShapeBorder bottomBarShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(25),
      topLeft: Radius.circular(25),
    ),
  );

  final bottomBarBorder = BorderRadius.only(
    topRight: Radius.circular(25),
    topLeft: Radius.circular(25),
  );

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);

    tabPages.add(HomePage(widget.user));
    tabPages.add(CalendarWidget());
    tabPages.add(ProjectsNavigator());
    if (widget.user.campus == "Angers") {
      tabPages.add(CafetWidget());
    }
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
          borderRadius: bottomBarBorder,
        ),
        child: SnakeNavigationBar.color(
          //* Here we have all the option of the navBar
          behaviour: SnakeBarBehaviour.pinned,
          snakeShape: SnakeShape.circle,
          shape: bottomBarShape,
          snakeViewColor: selectedCircleColor,
          selectedItemColor: selectedIconColor,
          unselectedItemColor: unselectedIconColor,
          backgroundColor: navBarColor,
          showUnselectedLabels: true,
          currentIndex: _pageIndex,
          onTap: onTabTapped,
          items: buildNavigationBarItems(),
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

  List<BottomNavigationBarItem> buildNavigationBarItems() {
    List<BottomNavigationBarItem> items = [
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
        label: 'Assos',
      ),
    ];

    if (widget.user.campus == 'Angers') {
      items.add(BottomNavigationBarItem(
        icon: Icon(Icons.fastfood),
        label: 'Cafet\'',
      ));
    }

    return items;
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
