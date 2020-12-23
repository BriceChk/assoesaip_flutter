import 'package:assoesaip_flutter/models/projectCategory.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

import 'categoryBody.dart';

class Category extends StatelessWidget {
  final RoundedRectangleBorder roundedBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(25),
    ),
  );
  @override
  Widget build(BuildContext context) {
    ProjectCategory categ = ModalRoute.of(context).settings.arguments;
    return Container(
      color: backgroundColor,
      //* CustomScrollView in order to have the bouncingScrollPhysic
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          //* SliverAppBar in order to have the same as the page before
          SliverAppBar(
            title: FittedBox(
              child: Text(
                categ.name,
                style: TextStyle(
                  fontSize: 30,
                  color: headerTextColor,
                  fontFamily: classicFont,
                ),
              ),
            ),
            leading: GestureDetector(
              child: Icon(
                Icons.arrow_back,
                color: headerTextColor,
              ),
              //* Pushing back to the AssociationCategories
              onTap: () {
                Navigator.of(context)
                    .popUntil(ModalRoute.withName("CategoriesList"));
              },
            ),
            pinned: true,
            floating: true,
            toolbarHeight: 60,
            expandedHeight: 130,
            backgroundColor: headerColor,
            flexibleSpace: _headerFlexibleSpace(categ),
          ),
          //* All the other Widget
          SliverList(
            delegate: SliverChildListDelegate(
              [
                //* Widget with all the name of the categories of the association
                CategoryBody(categ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerFlexibleSpace(ProjectCategory c) {
    return FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        centerTitle: true,
        background: Container(
          padding: EdgeInsets.fromLTRB(15, 60, 15, 0),
          child: Center(
            child: Text(
              c.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: headerTextColor,
                fontFamily: classicFont,
              ),
            ),
          ),
        )
    );
  }
}
