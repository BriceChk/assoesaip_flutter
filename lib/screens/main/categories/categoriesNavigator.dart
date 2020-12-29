import 'package:assoesaip_flutter/screens/main/categories/categoriesList.dart';
import 'package:assoesaip_flutter/screens/main/categories/category/categoryPage.dart';
import 'package:flutter/material.dart';


class ProjectsNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  _ProjectsNavigatorState createState() => _ProjectsNavigatorState();
}

class _ProjectsNavigatorState extends State<ProjectsNavigator> {
  Future<bool> didPopRoute() async {
    final NavigatorState navigator = widget.navigatorKey.currentState;
    assert(navigator != null);
    return await navigator.maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !await didPopRoute();
      },
      child: Navigator(
        key: widget.navigatorKey,
        initialRoute: '/categories',
        onGenerateRoute: (RouteSettings settings) {
          var routes = <String, WidgetBuilder> {
            '/categories': (context) => WillPopScope(child: CategoriesList(), onWillPop: () async => false),
            '/categories/category': (context) => Category(settings.arguments),
          };

          WidgetBuilder builder = routes[settings.name];
          return MaterialPageRoute(builder: (ctx) => builder(ctx));
        },
      ),
    );
  }
}
