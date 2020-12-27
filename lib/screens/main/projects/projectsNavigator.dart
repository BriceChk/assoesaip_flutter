import 'package:assoesaip_flutter/screens/main/projects/categoriesList.dart';
import 'package:assoesaip_flutter/screens/main/projects/category/categoryPage.dart';
import 'package:assoesaip_flutter/screens/main/projects/project/projectPageWidget.dart';
import 'package:flutter/material.dart';


class ProjectsNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/categories',
      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder> {
          '/categories': (context) => CategoriesList(),
          '/categories/category': (context) => Category(settings.arguments),
          '/categories/category/project': (context) => ProjectPageWidget(settings.arguments),
        };

        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
    );
  }
}
