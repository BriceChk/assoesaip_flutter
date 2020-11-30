import 'package:assoesaip_flutter/screens/HomePage/news.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

final String classicFont = "Nunito";
final Color backgroundColor = whiteWhite;
final Color hearderColor = skyBlueCrayola1;

class Test extends StatelessWidget {
  final RoundedRectangleBorder roundedBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(25),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            shape: roundedBorder,
            centerTitle: true,
            actions: [
              Header(),
            ],
            toolbarHeight: 130,
            pinned: true,
            backgroundColor: ceruleanCrayola,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 5,
                ),
                //* Widget with all the name of the categories of the association
                NewsWidget(),
                SizedBox(height: 55)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  final BorderRadius borderHeader = BorderRadius.only(
    bottomLeft: Radius.circular(25),
    bottomRight: Radius.circular(25),
  );

  @override
  Widget build(BuildContext context) {
    final Color fontColor = Colors.black;
    return Container(
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
            Row(
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.arrow_back,
                    color: navyBlue,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                //! BE CAREFUL OF THE ALIGNEMENT OF THE TITLE (NOT SURE OF MY CALCULATION)
                Padding(
                  padding: EdgeInsets.only(
                    left: (MediaQuery.of(context).size.width / 2) - 110,
                  ),
                  child: Text(
                    "Bienvenue !",
                    style: TextStyle(
                        fontSize: 30,
                        color: fontColor,
                        fontFamily: classicFont),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Découvre les clubs et associations qui font vivre l'esaip, leurs actualités et les prochains événement sur ton campus.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                color: fontColor,
                fontFamily: classicFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
