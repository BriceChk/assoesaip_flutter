import 'package:assoesaip_flutter/screens/main/projects/categoriesList.dart';
import 'package:assoesaip_flutter/screens/main/projects/category/category.dart';
import 'package:flutter/material.dart';


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
