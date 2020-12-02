import 'package:flutter/material.dart';

import 'assoCategories.dart';
import 'SubCategories/assoSubCategories.dart';

class AssoBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'AssociationCategories',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case 'AssociationCategories':
            return MaterialPageRoute(
                builder: (context) => AssociationCategories(),
                settings: settings);
            break;
          case 'Test':
            return MaterialPageRoute(
                builder: (context) => AssoSubCategories(), settings: settings);
            break;

          default:
            throw Exception("Invalid route");
        }
      },
    );
  }
}
