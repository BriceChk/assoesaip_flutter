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
            title: Text(
              "Nom de la catégorie",
              style: TextStyle(
                fontSize: 30,
                color: headerTextColor,
                fontFamily: classicFont,
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
            flexibleSpace: _headerFlexibleSpace(),
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

  Widget _headerFlexibleSpace() {
    return FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        centerTitle: true,
        background: Container(
          padding: EdgeInsets.fromLTRB(15, 60, 15, 0),
          child: Center(
            child: Text(
              "Futurs ingénieurs et déjà responsables : des projets pour un développement durable",
              textAlign: TextAlign.justify,
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
