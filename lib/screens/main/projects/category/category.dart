import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

import 'categoryBody.dart';
import 'categoryHeader.dart';

class Category extends StatelessWidget {
  final RoundedRectangleBorder roundedBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(25),
    ),
  );
  @override
  Widget build(BuildContext context) {
    //* Container of the page
    return Container(
      color: backgroundColor,
      //* CustomScrollView in order to have the bouncingScrollPhysic
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          //* SliverAppBar in order to have the same as the page before
          SliverAppBar(
            //* Shape of the AppBar with the roundedBorder
            shape: roundedBorder,
            //* Here we have the HeaderWidget
            actions: [
              CategoryHeader(),
            ],
            toolbarHeight: 130,
            pinned: true,
            backgroundColor: ceruleanCrayola,
          ),
          //* All the other Widget
          SliverList(
            delegate: SliverChildListDelegate(
              [
                //* Widget with all the name of the categories of the association
                CategoryBody(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
