import 'package:assoesaip_flutter/screens/main/projects/categoriesList.dart';
import 'package:assoesaip_flutter/screens/main/projects/category/category.dart';
import 'package:flutter/material.dart';


class ProjectsNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'CategoriesList',
      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder> {
          'CategoriesList': (context) => CategoriesList(),
          'Category': (context) => Category(settings.arguments),
        };

        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
    );
  }
}
