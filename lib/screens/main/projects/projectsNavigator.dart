import 'package:flutter/material.dart';

import 'categoriesList.dart';
import 'category/category.dart';

class ProjectsNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'CategoriesList',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case 'CategoriesList':
            return MaterialPageRoute(
                builder: (context) => CategoriesList(),
                settings: settings);
            break;
          case 'Category':
            return MaterialPageRoute(
                builder: (context) => Category(), settings: settings);
            break;

          default:
            throw Exception("Invalid route");
        }
      },
    );
  }
}
