import 'package:assoesaip_flutter/main.dart';
import 'package:assoesaip_flutter/models/projectCategory.dart';
import 'package:assoesaip_flutter/screens/main/cafet/cafet.dart';
import 'package:assoesaip_flutter/screens/main/calendar/calendar.dart';
import 'package:assoesaip_flutter/screens/main/homePage/homePage.dart';
import 'package:assoesaip_flutter/screens/main/categories/categoriesNavigator.dart';
import 'package:assoesaip_flutter/shares/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class MainNavigation extends StatefulWidget {
  final int tabIndex;
  final ProjectCategory category;

  MainNavigation({this.tabIndex = 0, this.category});

  @override
  _MainNavigationState createState() => new _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  //TODO_ variable
  int _selectedIndex;
  PageController _pageController;

  //TODO_ Page of the App
  List<Widget> tabPages = [];

  //TODO_ Colors
  Color navBarColor = COLOR_AE_BLUE;
  Color selectedCircleColor = Colors.white;
  Color unselectedIconColor = Colors.white;
  Color selectedIconColor = COLOR_AE_BLUE;

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

  // Scroll controllers
  final ScrollController _homeController = ScrollController();
  final ScrollController _calendarController = ScrollController();
  final ScrollController _cafetController = ScrollController();

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.tabIndex;
    _pageController = PageController(initialPage: _selectedIndex);

    tabPages.add(HomePage(_homeController));
    tabPages.add(CalendarWidget(_calendarController));
    tabPages.add(ProjectsNavigator());
    if (MyApp.user.campus == "Angers") {
      tabPages.add(CafetWidget(_cafetController));
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
          color: Colors.white,
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
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              if (this._selectedIndex == index) {
                var controller = index == 0 ? _homeController : index == 1 ? _calendarController : _cafetController;
                controller.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
              } else {
                this._selectedIndex = index;
                _pageController.jumpToPage(index);
              }
            });
          },
          items: buildNavigationBarItems(),
        ),
      ),
      //* Here we have the changes of the page with the called function
      body: PageView(
        children: tabPages,
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

    if (MyApp.user.campus == 'Angers') {
      items.add(BottomNavigationBarItem(
        icon: Icon(Icons.fastfood),
        label: 'Cafet\'',
      ));
    }

    return items;
  }
}
