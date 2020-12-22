import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

class CategoryHeader extends StatelessWidget {
  final BorderRadius borderHeader = BorderRadius.only(
    bottomLeft: Radius.circular(25),
    bottomRight: Radius.circular(25),
  );

  @override
  Widget build(BuildContext context) {
    final Color fontColor = Colors.black;
    //* Container which wrapping the hearder of the app
    return Container(
      //* Taking all the width available
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: hearderColor,
        borderRadius: borderHeader,
      ),
      //* In order to have a padding horizontaly
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        //* Column in order to have 2 differents text widget one under the others
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //* Row because we cant the arrow and the name of the specific association
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //* GestureDetector in order to detect if the user tap on it
                GestureDetector(
                  child: Icon(
                    Icons.arrow_back,
                    color: navyBlue,
                  ),
                  //* Pushing back to the AssociationCategories
                  onTap: () {
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName("CategoriesList"));
                  },
                ),
                SizedBox(width: 15),
                //* Flexible like this we can have a long text and multiline text
                Flexible(
                  //* Column which is combined with the flexible for the multiline
                  child: Column(
                    children: [
                      //* Name of the association
                      Text(
                        assoNameString,
                        style: TextStyle(
                            fontSize: 25,
                            color: fontColor,
                            fontFamily: classicFont),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            //* Description of the association
            Container(
              child: Text(
                assoDescriptionString,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  color: fontColor,
                  fontFamily: classicFont,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
