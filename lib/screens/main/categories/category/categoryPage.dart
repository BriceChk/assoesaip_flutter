import 'package:assoesaip_flutter/models/eventOccurrence.dart';
import 'package:assoesaip_flutter/models/news.dart';
import 'package:assoesaip_flutter/models/project.dart';
import 'package:assoesaip_flutter/models/projectCategory.dart';
import 'package:assoesaip_flutter/screens/main/categories/category/projectsListTab.dart';
import 'package:assoesaip_flutter/services/api.dart';
import 'package:assoesaip_flutter/shares/constants.dart';
import 'package:assoesaip_flutter/shares/eventsOccurrencesListWidget.dart';
import 'package:assoesaip_flutter/shares/newsListWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category extends StatefulWidget {
  final ProjectCategory? categ;

  Category(this.categ);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  late Map<String, Widget> tabs;

  String? selected;
  bool iconSelected = false;

  List<Project> projects = [];
  List<News> news = [];
  List<EventOccurrence> events = [];

  @override
  void initState() {
    super.initState();
    selected = 'Clubs & assos';
    getCategoryProjects(widget.categ!.id).then((value) {
      setState(() {
        if (value == null) {
          //TODO Error
        } else {
          projects = value;
        }
      });
    });
    getCategoryNews(widget.categ!.id).then((value) {
      setState(() {
        if (value == null) {
          //TODO Error
        } else {
          news = value;
        }
      });
    });
    getCategoryNextEventOccurrences(widget.categ!.id).then((value) {
      setState(() {
        if (value == null) {
          //TODO Error
        } else {
          events = value;
        }
      });
    });
  }

  Widget _buildIcon() {
      return IconButton(
        icon: Icon(FontAwesomeIcons.bell),
        onPressed: () {
          notNowDialog(context);
          return;
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Notifications'),
                  content: Text("Tu peux choisir de t'abonner ou te désabonner aux notifications de tous les projets de cette catégorie en même temps. Pour choisir au cas par cas, clique sur un projet !"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          //TODO Call API abonnement
                          Navigator.of(context).pop();
                        },
                        child: Text("M'abonner à toutes les notifications")
                    ),
                    TextButton(
                        onPressed: () {
                          //TODO Call API désabonnement
                          Navigator.of(context).pop();
                        },
                        child: Text("Me désabonner de toutes les notifications")
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Annuler")
                    ),
                  ],
                );
              }
          );
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    tabs = {
      "Clubs & assos": projects.isNotEmpty
          ? ProjectsListTab(projects)
          : NewsListWidget.newsListPlaceholder(),
      "Actus": news.isNotEmpty
          ? NewsListWidget(news)
          : NewsListWidget.newsListPlaceholder(),
      "Calendrier": events.isNotEmpty
          ? EventsOccurrencesList(events)
          : NewsListWidget.newsListPlaceholder(),
    };
    return Container(
      color: Colors.white,
      //* CustomScrollView in order to have the bouncingScrollPhysic
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          //* SliverAppBar in order to have the same as the page before
          SliverAppBar(
            title: FittedBox(
              child: Text(
                widget.categ!.name!,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontFamily: FONT_NUNITO,
                ),
              ),
            ),
            actions: [_buildIcon()],
            centerTitle: true,
            pinned: true,
            floating: true,
            toolbarHeight: 60,
            expandedHeight: 130,
            backgroundColor: COLOR_AE_BLUE,
            flexibleSpace: _headerFlexibleSpace(widget.categ!),
          ),
          //* All the other Widget
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(children: [
                  //* Widget with all the name of the categories of the association
                  _buildCategoryTabs(),
                  tabs[selected!]!,
                  //* Sizedbox of height 60 because otherwise the last one is under the navbar
                  SizedBox(height: 100),
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
              c.description!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: FONT_NUNITO,
              ),
            ),
          ),
        ));
  }

  Widget _buildCategoryTabs() {
    List<Widget> list = [];

    tabs.keys.forEach((tab) {
      Widget w = Container(
        decoration: BoxDecoration(
            color: selected == tab ? COLOR_POWDER_BLUE : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            tab,
            style: TextStyle(
              fontSize: 18,
              fontFamily: FONT_NUNITO,
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
