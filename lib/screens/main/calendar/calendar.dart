import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

final String classicFont = "Nunito";
final Color fontColor = Colors.white;

final BorderRadius headerBorder = BorderRadius.only(
  bottomLeft: Radius.circular(25),
  bottomRight: Radius.circular(25),
);

final RoundedRectangleBorder roundedBorder = RoundedRectangleBorder(
  borderRadius: headerBorder,
);

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          shape: roundedBorder,
          centerTitle: true,
          actions: [
            CalendarHeader(),
          ],
          toolbarHeight: 130,
          pinned: true,
          backgroundColor: skyBlueCrayola1,
        )
      ],
    );
  }
}

class CalendarHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: esaipBlue,
        borderRadius: headerBorder,
      ),

      //* In order to have a padding horizontaly
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        //* Column in order to have 2 differents text widget one under the others
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Calendrier",
              style: TextStyle(
                fontSize: 30,
                color: fontColor,
                fontFamily: classicFont,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}