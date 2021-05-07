// HomePage when the user connect: AppBar + Carousel event + CustomScrollVertical vertical

import 'package:assoesaip_flutter/main.dart';
import 'package:assoesaip_flutter/models/article.dart';
import 'package:assoesaip_flutter/models/event.dart';
import 'package:assoesaip_flutter/models/news.dart';
import 'package:assoesaip_flutter/models/project.dart';
import 'package:assoesaip_flutter/models/searchResult.dart';
import 'package:assoesaip_flutter/screens/main/HomePage/starredNewsCarousel.dart';
import 'package:assoesaip_flutter/services/api.dart';
import 'package:assoesaip_flutter/shares/constants.dart';
import 'package:assoesaip_flutter/shares/lifecycleEventHandler.dart';
import 'package:assoesaip_flutter/shares/newsListWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:requests/requests.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

class HomePage extends StatefulWidget {
  final ScrollController controller;
  HomePage(this.controller);

  @override
  _HomePageState createState() => _HomePageState();
}

enum MenuItem { logout, refresh, profile }

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;

  FloatingSearchBarController _searchBarController = new FloatingSearchBarController();

  String avatarUrl = 'https://$AE_HOST/';

  List<News> news = [];
  List<News> starredNews = [];
  
  List<SearchResult> searchResults = [];
  bool isSearchLoading = false;

  @override
  void initState() {
    super.initState();

    if (MyApp.user!.avatarFileName == null) {
      avatarUrl += 'build/images/placeholder.png';
    } else {
      avatarUrl += 'images/profile-pics/' + MyApp.user!.avatarFileName!;
    }

    WidgetsBinding.instance!.addObserver(
        LifecycleEventHandler(resumeCallBack: () async => setState(() {
          loadData();
        }))
    );

    loadData();
  }

  void loadData() {
    getNews().then((value) {
      setState(() {
        if (value == null) {
          //TODO Error
        } else {
          news = value;
        }
      });
    });
    getStarredNews().then((value) {
      setState(() {
        if (value == null) {
          //TODO Error
        } else {
          starredNews = value;
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        CustomScrollView(
          controller: widget.controller,
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: MediaQuery.of(context).padding.top + 55,),
            ),

            starredNews.isNotEmpty
                ? StarredNewsCarouselWidget(starredNews)
                : StarredNewsCarouselWidget.carouselPlaceholder(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //Want to have space between the carousel and the top of the rounded container
                      Padding(
                        padding: EdgeInsets.only(top: 5, left: 10),
                        child: Text(
                          "Toutes les actus",
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: FONT_NUNITO,
                          ),
                        ),
                      ),
                      news.isNotEmpty
                          ? NewsListWidget(news)
                          : NewsListWidget.newsListPlaceholder()
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
                ],
              ),
            )
          ],
        ),
        buildFloatingSearchBar()
      ],
    );
  }

  Widget buildFloatingSearchBar() {
    return FloatingSearchBar(
      hint: 'Rechercher un club, une actu ...',
      controller: _searchBarController,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 400),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: 0.0,
      openAxisAlignment: 0.0,
      width: 600,
      automaticallyImplyBackButton: false,
      borderRadius: BorderRadius.circular(12),
      backdropColor: Colors.transparent,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // TODO Call your model, bloc, controller here.
        setState(() {
          this.isSearchLoading = true;
        });
        getSearchResults(query).then((value) {
          setState(() {
            this.isSearchLoading = false;
            if (value == null) {
              //TODO Error
              return;
            }
            this.searchResults = value;
          });
        });
      },
      progress: isSearchLoading,
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: PopupMenuButton<MenuItem>(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(80),
              child: Container(
                width: 40,
                height: 40,
                child: CachedNetworkImage(
                  imageUrl: avatarUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onSelected: (MenuItem result) {
              switch (result) {
              //* Case when we hit "deconnexion" we log out
                case MenuItem.logout:
                  final cookieManager = WebviewCookieManager();
                  cookieManager.clearCookies();
                  Requests.clearStoredCookies(
                      '$AE_HOST:443');
                  Navigator.pushReplacementNamed(context, '/welcome');
                  break;
              //* Case when we hit "profile" we pushing to the page profile
                case MenuItem.profile:
                  Navigator.pushNamed(context, '/profile');
                  break;
              //* Case when we hit "Actualisé" we're refreshing the whole page for news update
                case MenuItem.refresh:
                  loadData();
                  break;
              }
            },
            tooltip: 'Menu',
            itemBuilder: (BuildContext context) =>
            //* We have the menu display here
            <PopupMenuEntry<MenuItem>>[
              PopupMenuItem<MenuItem>(
                value: MenuItem.profile,
                child: Text('Profil'),
              ),
              PopupMenuItem<MenuItem>(
                value: MenuItem.refresh,
                child: Text('Actualiser'),
              ),
              PopupMenuItem<MenuItem>(
                value: MenuItem.logout,
                child: Text('Déconnexion'),
              ),
            ],
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return Material(
          elevation: 4,
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  var suggestion = searchResults[index];

                  IconData icon;
                  if (suggestion.type == "Article") {
                    icon = FontAwesomeIcons.newspaper;
                  } else if (suggestion.type == "Événement") {
                    icon = FontAwesomeIcons.calendarAlt;
                  } else {
                    icon = FontAwesomeIcons.userFriends;
                  }

                  return ListTile(
                    leading: Icon(icon, size: 30),
                    title: Text(
                      suggestion.name!,
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: FONT_NUNITO,
                        color: COLOR_NAVY_BLUE,
                      ),
                    ),
                    subtitle: Text(suggestion.type!),
                    onTap: () {
                      _searchBarController.clear();
                      _searchBarController.close();
                      searchResults.clear();
                      if (suggestion.type == "Article") {
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed('/article', arguments: Article(id: suggestion.id));
                      } else if (suggestion.type == "Événement") {
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed('/event', arguments: Event(id: suggestion.id));
                      } else {
                        Navigator.of(context, rootNavigator: true).pushNamed(
                          '/project',
                          arguments: Project(
                              id: suggestion.id,
                              name: suggestion.name,
                              description: suggestion.description),
                        );
                      }
                    },
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black26,
                  height: 0,
                ),
                itemCount: searchResults.length
            ),
          ),
        );
      },
    );
  }
}
