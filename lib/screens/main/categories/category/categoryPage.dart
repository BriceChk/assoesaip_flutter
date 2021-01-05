import 'package:assoesaip_flutter/models/eventOccurrence.dart';
import 'package:assoesaip_flutter/models/news.dart';
import 'package:assoesaip_flutter/models/project.dart';
import 'package:assoesaip_flutter/models/projectCategory.dart';
import 'package:assoesaip_flutter/screens/main/categories/category/projectsListTab.dart';
import 'package:assoesaip_flutter/services/api.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:assoesaip_flutter/shares/eventsOccurrencesList.dart';
import 'package:assoesaip_flutter/shares/newsList.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category extends StatefulWidget {
  final ProjectCategory categ;

  Category(this.categ);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  Map<String, Widget> tabs;

  String selected;
  bool iconSelected = false;

  List<Project> projects;
  List<News> news;
  List<EventOccurrence> events;

  @override
  void initState() {
    super.initState();
    selected = 'Clubs & assos';
    getCategoryProjects(widget.categ.id).then((value) {
      setState(() {
        projects = value;
      });
    });
    getCategoryNews(widget.categ.id).then((value) {
      setState(() {
        news = value;
      });
    });
    getCategoryNextEventOccurrences(widget.categ.id).then((value) {
      setState(() {
        events = value;
      });
    });
  }

  Widget _buildIcon() {
    if (iconSelected) {
      return IconButton(
        icon: Icon(FontAwesomeIcons.solidBell, color: Colors.yellow),
        onPressed: () {
          setState(() {
            iconSelected = !iconSelected;
          });
        },
      );
    } else {
      return IconButton(
        icon: Icon(FontAwesomeIcons.bell),
        onPressed: () {
          setState(() {
            iconSelected = !iconSelected;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    tabs = {
      "Clubs & assos": projects is List<Project>
          ? ProjectsListTab(projects)
          : NewsListWidget.newsListPlaceholder(),
      "Actus": news is List<News>
          ? NewsListWidget(news)
          : NewsListWidget.newsListPlaceholder(),
      "Calendrier": events is List<EventOccurrence>
          ? EventsOccurrencesList(events)
          : NewsListWidget.newsListPlaceholder(),
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
                widget.categ.name,
                style: TextStyle(
                  fontSize: 30,
                  color: headerTextColor,
                  fontFamily: classicFont,
                ),
              ),
            ),
            actions: [_buildIcon()],
            centerTitle: true,
            pinned: true,
            floating: true,
            toolbarHeight: 60,
            expandedHeight: 130,
            backgroundColor: headerColor,
            flexibleSpace: _headerFlexibleSpace(widget.categ),
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
        ));
  }

  Widget _buildCategoryTabs() {
    List<Widget> list = List();

    tabs.keys.forEach((tab) {
      Widget w = Container(
        decoration: BoxDecoration(
            color: selected == tab ? menuColorSelected : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: list),
      ),
    );
  }
}
