import 'package:assoesaip_flutter/models/news.dart';
import 'package:assoesaip_flutter/models/project.dart';
import 'package:assoesaip_flutter/models/projectCategory.dart';
import 'package:assoesaip_flutter/screens/main/homePage/newsList.dart';
import 'package:assoesaip_flutter/screens/main/projects/category/tabs/categoryCalendarTab.dart';
import 'package:assoesaip_flutter/screens/main/projects/category/tabs/projectsListTab.dart';
import 'package:assoesaip_flutter/services/api.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  final ProjectCategory categ;

  Category(this.categ);

  @override
  _CategoryState createState() => _CategoryState(this.categ);
}

class _CategoryState extends State<Category> {
  Map<String, Widget> tabs;

  String selected;
  ProjectCategory categ;
  _CategoryState(this.categ);

  List<Project> projects;
  List<News> news;

  @override
  void initState() {
    super.initState();
    selected = 'Clubs & assos';
    getCategoryProjects(categ.id).then((value) {
      setState(() {
        projects = value;
      });
    });
    getCategoryNews(categ.id).then((value) {
      setState(() {
        news = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    tabs = {
      "Clubs & assos": projects is List<Project> ? ProjectsListTab(projects) : NewsListWidget.newsListPlaceholder(),
      "Actus": news is List<News> ? NewsListWidget(news) : NewsListWidget.newsListPlaceholder(),
      "Calendrier": CategoryCalendarTab(),
    };
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
            centerTitle: true,
            leading: GestureDetector(
              child: Icon(
                Icons.arrow_back,
                color: headerTextColor,
              ),
              //* Pushing back to the AssociationCategories
              onTap: () {
                Navigator.of(context).pop();
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
                  SizedBox(height: 70),
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
