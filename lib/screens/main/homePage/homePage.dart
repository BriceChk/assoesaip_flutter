// HomePage when the user connect: AppBar + Carousel event + CustomScrollVertical vertical

import 'package:assoesaip_flutter/models/user.dart';
import 'package:assoesaip_flutter/screens/main/HomePage/starredNewsCarousel.dart';
import 'package:assoesaip_flutter/screens/main/HomePage/newsList.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final User user;

  HomePage(this.user);

  @override
  _HomePageState createState() => _HomePageState(user);
}

class _HomePageState extends State<HomePage> {
  final User user;
  String avatarUrl = 'https://asso-esaip.bricechk.fr/';

  @override
  void initState() {
    super.initState();

    if (user.avatarFileName == null) {
      avatarUrl += 'build/images/placeholder.png';
    } else {
      avatarUrl += 'images/profile-pics/' + user.avatarFileName;
    }
  }

  _HomePageState(this.user);

  @override
  Widget build(BuildContext context) {
    final String classicFont = "Nunito";
    final Color backgroundColor = whiteWhite;

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
              trailing: CircleAvatar(
                backgroundImage: NetworkImage(avatarUrl),
              ),
            ),
          ),
          //* SliverAppBar to have the animation
          //* Others widget from the page here only the news (for now)
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
                      NewsListWidget()
                    ],
                  ),
                ),
                SizedBox(height: 60),
              ],
            ),
          )
        ],
      ),
    );
  }
}
