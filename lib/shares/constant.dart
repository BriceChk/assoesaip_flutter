//ici on met toutes les variables qui sont utiliser dans plusieurs fichier/dossier
//dans le dossier on met aussi la navigation si elle est utiliser dans plusieurs pages etc.

import 'package:flutter/material.dart';

const navyBlue = Color(0xff03045E); //* Font in white
const darkCornflowerBlue = Color(0xff023E8A); //* Font in white
const starCommandBlue = Color(0xff0077B6); //* Font in white
const blueGreen = Color(0xff0096C7); //* Font in white
const esaipBlue = Color(0xff009bc2);
const ceruleanCrayola = Color(0xff00B4D8); //* Font in white
const skyBlueCrayola1 = Color(0xff48CAE4); //* Font in black
const skyBlueCrayola2 = Color(0xff90E0EF); //* Font in black
const blizzardBlue = Color(0xffADE8F4); //* Font in black
const powderBlue = Color(0xffCAF0F8); //* Font in black
const white = Color(0xfff5f3f4); //* Font in black
const whiteWhite = Colors.white;

//* Font
final String classicFont = "Nunito";

//* Color
final Color backgroundColor = whiteWhite;
final Color cardColor = white;
final Color titleColor = navyBlue;
final Color titleCarouselColor = powderBlue;
final Color menuColorSelected = powderBlue;
final Color shadowColor = navyBlue;
final Color splashColor = skyBlueCrayola1;
final Color greyfontColor = Colors.grey[700];

final Color headerColor = starCommandBlue;
final Color headerTextColor = Colors.white;
final BorderRadius headerBorder = BorderRadius.only(
  bottomLeft: Radius.circular(0),
  bottomRight: Radius.circular(0),
);
final BorderRadius cardsBorderRadius = BorderRadius.circular(15);

int assoIndex = 0;

String assoNameString = '';
String assoDescriptionString = '';
int menuIndexSelected = 0;
int menuAssoIndexSelected = 0;

enum MenuItem { logout, refresh, profile }

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