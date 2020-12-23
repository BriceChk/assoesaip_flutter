import 'package:assoesaip_flutter/models/projectCategory.dart';
import 'package:assoesaip_flutter/screens/main/projects/category/tabs/categoryNewsTab.dart';
import 'package:assoesaip_flutter/screens/main/projects/category/tabs/categoryCalendarTab.dart';
import 'package:assoesaip_flutter/screens/main/projects/category/tabs/projectsListTab.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final Map<String, Widget> tabs = {
    "Clubs & assos": ProjectsListTab(),
    "Actus": CategoryNewsTab(),
    "Calendar": CategoryCalendarTab(),
  };

  String selected;

  @override
  void initState() {
    super.initState();
    selected = tabs.keys.first;
  }

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
                Column(children: [
                  //* Widget with all the name of the categories of the association
                  _buildCategoryTabs(),
                  tabs[selected],
                  //* Sizedbox of height 60 because otherwise the last one is under the navbar
                  SizedBox(height: 60),
                ])
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

  Widget _buildCategoryTabs() {
    List<Widget> list = List();

    tabs.keys.forEach((tab) {
      Widget w = Container(
        decoration: BoxDecoration(
            color: selected == tab ? menuColorSelected : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 5, horizontal: 10),
          child: Text(
            tab,
            style: TextStyle(
              fontSize: 18,
              fontFamily: classicFont,
            ),
          ),
        ),
      );

      if (selected == tab) {
        list.add(w);
      } else {
        list.add(GestureDetector(
          child: w,
          onTap: () {
            setState(() {
              selected = tab;
            });
          },
        ));
      }
    });

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: list
        ),
      ),
    );
  }
}
