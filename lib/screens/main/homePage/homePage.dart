// HomePage when the user connect: AppBar + Carousel event + CustomScrollVertical vertical

import 'package:assoesaip_flutter/models/news.dart';
import 'package:assoesaip_flutter/models/user.dart';
import 'package:assoesaip_flutter/screens/main/HomePage/starredNewsCarousel.dart';
import 'package:assoesaip_flutter/screens/main/HomePage/newsList.dart';
import 'package:assoesaip_flutter/services/api.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  final User user;

  HomePage(this.user);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String avatarUrl = 'https://asso-esaip.bricechk.fr/';

  List<News> news;

  @override
  void initState() {
    super.initState();

    if (widget.user.avatarFileName == null) {
      avatarUrl += 'build/images/placeholder.png';
    } else {
      avatarUrl += 'images/profile-pics/' + widget.user.avatarFileName;
    }

    getNews().then((value) {
      setState(() {
        news = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
              trailing: Container(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: PopupMenuButton<MenuItem>(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: avatarUrl,
                      fadeInDuration: Duration(milliseconds: 150),
                    ),
                  ),
                  onSelected: (MenuItem result) {
                    setState(() {});
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<MenuItem>>[
                    PopupMenuItem<MenuItem>(
                      value: MenuItem.profil,
                      child: Text('Profil'),
                    ),
                    PopupMenuItem<MenuItem>(
                      value: MenuItem.actualise,
                      //TODO Faire l'actualisation sur le ontap (rebuild la page voir si ca marche)
                      child: GestureDetector(
                        child: Text('Actualiser'),
                        onTap: () {
                          setState(() {});
                        },
                      ),
                    ),
                    PopupMenuItem<MenuItem>(
                      value: MenuItem.deconnexion,
                      //TODO Faire la déconnexion
                      child: GestureDetector(
                        child: Text('Déconnexion'),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          StarredNewsCarouselWidget(),
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
