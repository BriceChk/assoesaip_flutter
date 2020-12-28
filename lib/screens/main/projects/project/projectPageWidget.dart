import 'package:assoesaip_flutter/models/eventOccurrence.dart';
import 'package:assoesaip_flutter/models/news.dart';
import 'package:assoesaip_flutter/models/project.dart';
import 'package:assoesaip_flutter/models/projectMember.dart';
import 'package:assoesaip_flutter/models/projectPage.dart';
import 'package:assoesaip_flutter/screens/main/projects/project/tabs/projectMembersTab.dart';
import 'package:assoesaip_flutter/services/api.dart';
import 'package:assoesaip_flutter/shares/circularProgressPlaceholder.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:assoesaip_flutter/shares/customWebviewWidget.dart';
import 'package:assoesaip_flutter/shares/eventsOccurrencesList.dart';
import 'package:assoesaip_flutter/shares/newsList.dart';
import 'package:flutter/material.dart';

class ProjectPageWidget extends StatefulWidget {
  final Project p;

  ProjectPageWidget(this.p);

  @override
  _ProjectPageWidgetState createState() => _ProjectPageWidgetState();
}

class _ProjectPageWidgetState extends State<ProjectPageWidget> {
  final double paddinghorizontal = 15;
  final RoundedRectangleBorder roundedBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(25),
    ),
  );

  Project project;
  List<News> news;
  List<ProjectPage> pages;
  List<ProjectMember> members;
  List<EventOccurrence> events;

  Map<String, Widget> tabs;
  String selected;

  @override
  void initState() {
    super.initState();
    selected = 'Accueil';
    getProject(widget.p.id).then((value) {
      setState(() {
        project = value;
      });
    });
    getProjectPages(widget.p.id).then((value) {
      setState(() {
        pages = value;
      });
    });
    getProjectMembers(widget.p.id).then((value) {
      setState(() {
        members = value;
      });
    });
    getProjectNews(widget.p.id).then((value) {
      setState(() {
        news = value;
      });
    });
    events = List();
    //TODO Get project events
  }

  @override
  Widget build(BuildContext context) {
    tabs = {
      'Accueil': project is Project ? CustomWebview(project.html) : CircularProgressPlaceholder(),
      'Membres': members is List<ProjectMember> ? ProjectMembersTab(members) : NewsListWidget.newsListPlaceholder(),
      'Actus': news is List<News> ? NewsListWidget(news) : NewsListWidget.newsListPlaceholder(),
      'Calendrier': events is List<EventOccurrence> ? EventsOccurrencesList(events) : NewsListWidget.newsListPlaceholder(),
    };

    if (pages is List<ProjectPage>) {
      pages.forEach((page) {
        tabs[page.name] = CustomWebview(page.html);
      });
    }

    return Container(
      color: whiteWhite,
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            title: FittedBox(
              child: Text(
                widget.p.name,
                style: TextStyle(
                  fontSize: 30,
                  color: headerTextColor,
                  fontFamily: classicFont,
                ),
              ),
            ),
            centerTitle: true,
            pinned: true,
            floating: true,
            toolbarHeight: 60,
            expandedHeight: 160,
            backgroundColor: headerColor,
            flexibleSpace: _headerFlexibleSpace(),
          ),
          //* All the other Widget
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  children: [
                    _buildTabs(),
                    tabs[selected],
                    SizedBox(height: 70),
                  ],
                )
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
              widget.p.description,
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

  Widget _buildTabs() {
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
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: list
              ),
            ]
        ),
      ),
    );
  }
}
