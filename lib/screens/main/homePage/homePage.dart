// HomePage when the user connect: AppBar + Carousel event + CustomScrollVertical vertical

import 'package:assoesaip_flutter/main.dart';
import 'package:assoesaip_flutter/models/article.dart';
import 'package:assoesaip_flutter/models/event.dart';
import 'package:assoesaip_flutter/models/news.dart';
import 'package:assoesaip_flutter/models/project.dart';
import 'package:assoesaip_flutter/models/searchResult.dart';
import 'package:assoesaip_flutter/screens/main/HomePage/starredNewsCarousel.dart';
import 'package:assoesaip_flutter/services/api.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:assoesaip_flutter/shares/newsList.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:requests/requests.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;

  final TextEditingController _typeAheadController = TextEditingController();

  String avatarUrl = 'https://asso.esaip.org/';

  List<News> news;
  List<News> starredNews;

  @override
  void initState() {
    super.initState();

    if (MyApp.user.avatarFileName == null) {
      avatarUrl += 'build/images/placeholder.png';
    } else {
      avatarUrl += 'images/profile-pics/' + MyApp.user.avatarFileName;
    }

    loadData();
  }

  void loadData() {
    getNews().then((value) {
      setState(() {
        news = value;
      });
    });
    getStarredNews().then((value) {
      setState(() {
        starredNews = value;
      });
    });
    //TODO Load events here!
  }

  Widget _builderSearchResult(News n) {
    return TypeAheadField(
      itemBuilder: (context, SearchResult suggestion) {
        IconData icon;
        if (suggestion.type == "Article") {
          icon = FontAwesomeIcons.newspaper;
        } else if (suggestion.type == "Événement") {
          icon = FontAwesomeIcons.calendarAlt;
        } else {
          icon = FontAwesomeIcons.userFriends;
        }
        return ListTile(
          leading:
              Container(child: Center(child: Icon(icon)), width: 5, height: 5),
          title: Text(
            suggestion.name,
            style: TextStyle(
              fontSize: 17,
              fontFamily: classicFont,
              color: titleColor,
            ),
          ),
          subtitle: Text(suggestion.type),
        );
      },
      suggestionsCallback: (pattern) async {
        return await getSearchResults(pattern);
      },
      onSuggestionSelected: (SearchResult suggestion) {
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
        _typeAheadController.clear();
      },
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
          borderRadius: BorderRadius.circular(10), color: whiteWhite),
      textFieldConfiguration: TextFieldConfiguration(
        controller: _typeAheadController,
        decoration: InputDecoration.collapsed(
          hintText: "Rechercher un club, une actu ...",
        ),
        style: TextStyle(
          fontFamily: classicFont,
        ),
      ),
      noItemsFoundBuilder: (context) {
        return ListTile(
          leading: Icon(FontAwesomeIcons.ban),
          title: Text(
            "Aucun résultat",
            style: TextStyle(fontFamily: classicFont, fontSize: 17),
          ),
        );
      },
      hideOnLoading: true,
      hideSuggestionsOnKeyboardHide: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    News n;
    super.build(context);
    return Container(
      color: backgroundColor,
      child: CustomScrollView(
        //! I don't know why but apparently that the things i was missing
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(top: 10),
            sliver: SliverFloatingBar(
              elevation: 2,
              backgroundColor: backgroundColor,
              leading: Container(
                height: double.infinity,
                width: MediaQuery.of(context).size.width - 110,
                child: Center(child: _builderSearchResult(n)),
              ),
              //* Menu + profile picture as button so see the menu
              trailing: Container(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: PopupMenuButton<MenuItem>(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Container(
                      width: 45,
                      height: 45,
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
                            'asso.esaip.org:443');
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
            ),
          ),
          starredNews is List<News>
              ? StarredNewsCarouselWidget(starredNews)
              : StarredNewsCarouselWidget.carouselPlaceholder(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  color: backgroundColor,
                  width: MediaQuery.of(context).size.width,
                  //* Container of the white widget with the rounded corner
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //Want to have space between the carousel and the top of the rounded container
                      Padding(
                        padding: EdgeInsets.only(top: 5, left: 10),
                        child: Text(
                          "Actualités",
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: classicFont,
                          ),
                        ),
                      ),
                      //* Sizedbox in order to have a apsace between the rounded and the first news
                      SizedBox(
                        height: 10,
                      ),
                      //! Container of each news
                      news is List<News>
                          ? NewsListWidget(news)
                          : NewsListWidget.newsListPlaceholder()
                    ],
                  ),
                ),
                SizedBox(height: 100),
              ],
            ),
          )
        ],
      ),
    );
  }
}
