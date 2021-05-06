import 'package:flutter/material.dart';

// Colors
const COLOR_NAVY_BLUE = Color(0xff03045E);
const COLOR_AE_BLUE = Color(0xff0077B6);
const COLOR_POWDER_BLUE = Color(0xffcaf0f8);
const COLOR_SHIMMER_WHITE = Color(0xfff5f3f4);
const COLOR_GREY_TEXT = Color(0xff616161); // grey[700]

// Fonts
const String FONT_NUNITO = "Nunito";

// Misc
const AE_HOST = "asso.esaip.org";
const BORDER_RADIUS_CARD = 15.0;

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}


void notNowDialog(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notifications'),
          content: Text("L'abonnement aux notifications arrivera dans une prochaine mise à jour. En attendant, tu peux les activer ou désactiver globalement sur la page profil, en haut à droite de l'accueil."),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Ok")
            ),
          ],
        );
      }
  );
}