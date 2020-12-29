// HomePage when the user connect: AppBar + Carousel event + CustomScrollVertical vertical

import 'package:assoesaip_flutter/main.dart';
import 'package:assoesaip_flutter/models/news.dart';
import 'package:assoesaip_flutter/screens/main/HomePage/starredNewsCarousel.dart';
import 'package:assoesaip_flutter/services/api.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:assoesaip_flutter/shares/newsList.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
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

  String avatarUrl = 'https://asso-esaip.bricechk.fr/';

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
  }

  @override
  Widget build(BuildContext context) {
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
                child: Center(
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                      hintText: "Rechercher un club, une actu ...",
                    ),
                    style: TextStyle(
                      fontFamily: classicFont,
                    ),
                  ),
                ),
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
                            'asso-esaip.bricechk.fr:443');
                        Navigator.pushReplacementNamed(context, '/welcome');
                        break;
                      //* Case when we hit "profile" we pushing to the page profile
                      case MenuItem.profile:
                        //TODO Go to profile page
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
                SizedBox(height: 70),
              ],
            ),
          )
        ],
      ),
    );
  }
}
