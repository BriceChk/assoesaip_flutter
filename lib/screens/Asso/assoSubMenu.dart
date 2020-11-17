import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

class AssoSubMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return assoIndex == 0
        ? Text("Accueil")
        : assoIndex == 1
            ? Text("Actu")
            : assoIndex == 2
                ? Text("Membres")
                : assoIndex == 3
                    ? Text("Partenariats")
                    : Text("Accueil");
  }
}
