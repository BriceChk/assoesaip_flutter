import 'package:assoesaip_flutter/models/eventOccurrence.dart';
import 'package:assoesaip_flutter/models/news.dart';
import 'package:assoesaip_flutter/models/project.dart';
import 'package:assoesaip_flutter/models/projectMember.dart';
import 'package:assoesaip_flutter/models/projectPage.dart';
import 'package:assoesaip_flutter/screens/project/projectMembersTab.dart';
import 'package:assoesaip_flutter/services/api.dart';
import 'package:assoesaip_flutter/shares/circularProgressPlaceholder.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:assoesaip_flutter/shares/customWebviewWidget.dart';
import 'package:assoesaip_flutter/shares/eventsOccurrencesList.dart';
import 'package:assoesaip_flutter/shares/newsList.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
  bool iconSelected = false;

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
    getProjectNextEventOccurrences(widget.p.id).then((value) {
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
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Se désabonner des notifications'),
                content: Text("Tu ne recevras plus de notification lors de la publication d'actus."),
                actions: [
                  FlatButton(
                      onPressed: () {
                        //TODO Call API désabonnement
                        Navigator.of(context).pop();
                        setState(() {
                          iconSelected = !iconSelected;
                        });
                      },
                      child: Text('Confirmer')
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Annuler')
                  ),
                ],
              );
            }
          );
        },
      );
    } else {
      return IconButton(
        icon: Icon(FontAwesomeIcons.bell),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("S'abonner aux notifications"),
                  content: Text("Tu recevras une notification lors de la publication d'actus (articles, événements ...)."),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          //TODO Call API abonnement
                          Navigator.of(context).pop();
                          setState(() {
                            iconSelected = !iconSelected;
                          });
                        },
                        child: Text('Confirmer')
                    ),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Annuler')
                    ),
                  ],
                );
              }
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    tabs = {
      'Accueil': project is Project
          ? CustomWebview(project.html)
          : CircularProgressPlaceholder(),
      'Membres': members is List<ProjectMember>
          ? ProjectMembersTab(members)
          : NewsListWidget.newsListPlaceholder(),
      'Actus': news is List<News>
          ? NewsListWidget(news)
          : NewsListWidget.newsListPlaceholder(),
      'Calendrier': events is List<EventOccurrence>
          ? EventsOccurrencesList(events)
          : NewsListWidget.newsListPlaceholder(),
    };

    if (pages is List<ProjectPage>) {
      pages.forEach((page) {
        tabs[page.name] = CustomWebview(page.html);
      });
    }

    return Scaffold(
      body: Container(
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
              actions: [_buildIcon()],
              centerTitle: true,
              pinned: true,
              floating: true,
              toolbarHeight: 60,
              expandedHeight: 200,
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
      ),
    );
  }

  Widget _headerFlexibleSpace() {
    return FlexibleSpaceBar(
      collapseMode: CollapseMode.pin,
      centerTitle: true,
      background: Container(
        padding: EdgeInsets.fromLTRB(15, 80, 15, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.p.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: headerTextColor,
                fontFamily: classicFont,
              ),
            ),
            SizedBox(height: 5),
            //! POUR LA CONSTUCTION DU WIDGET BIEN LAISSER LE SIZEDBOX de 5 A
            //! LA FIN
            //! SINON VOIR POUR UNE BARRE AVEC TOUS LES RESEAUX OU
            //! SEULEMENT CHACUN SON CONTAINER AVEC LE FOND (a voir)
            Container(
              height: 40,
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: project == null ? [] : _buildSocialNetworks(),
                ),
              ),
            ),
            SizedBox(height: 5)
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSocialNetworks() {
    List<Widget> list = List();

    if (project.email != '') {
      list.add(GestureDetector(
        onTap: () async {
          if (await canLaunch('mailto:' + project.email)) {
            await launch('mailto:' + project.email);
          } else {
            throw 'Could not launch mailto:' + project.email;
          }
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: powderBlue),
          child: Center(
            child: Icon(
              FontAwesomeIcons.solidEnvelope,
              color: navyBlue,
            ),
          ),
        ),
      ));
    }

    if (project.social != null) {
      var networkIcon = {
        'fb': FontAwesomeIcons.facebookF,
        'insta': FontAwesomeIcons.instagram,
        'yt': FontAwesomeIcons.youtube,
        'discord': FontAwesomeIcons.discord,
        'twt': FontAwesomeIcons.twitter,
        'snap': FontAwesomeIcons.snapchatGhost,
      };

      project.social.toJson().forEach((key, value) {
        if (value != null) {
          list.add(GestureDetector(
            onTap: () async {
              var link = '';

              switch (key) {
                case 'insta':
                  link = 'https://instagram.com/' + value;
                  break;
                case 'twt':
                  link = 'https://twitter.com/' + value;
                  break;
                case 'snap':
                  link = 'https://snapchat.com/add/' + value;
                  break;
                default:
                  link = value;
              }

              if (await canLaunch(link)) {
                await launch(link);
              } else {
                throw 'Could not launch ' + link;
              }
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: powderBlue),
              child: Center(
                child: Icon(
                  networkIcon[key],
                  color: navyBlue,
                ),
              ),
            ),
          ));
        }
      });
    }

    return list;
  }

  Widget _buildTabs() {
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
        height: 50,
        child: Center(
          child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: list),
              ]),
        ),
      ),
    );
  }
}
