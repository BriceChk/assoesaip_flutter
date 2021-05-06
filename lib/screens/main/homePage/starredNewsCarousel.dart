import 'package:assoesaip_flutter/models/news.dart';
import 'package:assoesaip_flutter/shares/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class StarredNewsCarouselWidget extends StatelessWidget {
  final List<News> news;


  StarredNewsCarouselWidget(this.news);

  @override
  Widget build(BuildContext context) {
    if (news.length == 0) {
      return SliverPadding(padding: EdgeInsets.zero);
    }

    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      //* Height of the picture (carousel)
      expandedHeight: 330,
      stretch: true,
      //* Stretch mode remove or add some features
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
        ],
        background: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                "À la une",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: FONT_NUNITO,
                ),
              ),
            ),
            CarouselSlider.builder(
                //* All the option of the carousel see the pubdev page
                options: CarouselOptions(
                  height: 275,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: news.length == 1 ? false : true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {},
                ),
                itemCount: news.length,
                itemBuilder: (BuildContext context, int currentIndex, int realIdx) =>
                    _buildCarouselItem(news[currentIndex], context)),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselItem(News n, BuildContext context) {
    String imageUrl = 'https://$AE_HOST/';
    if (n.project!.logoFileName == null) {
      imageUrl += 'build/images/project-placeholder.png';
    } else {
      imageUrl += 'images/project-logos/' + n.project!.logoFileName!;
    }

    // The title is the Article title or the Event title ...
    String title = n.article != null ? n.article!.title! : n.event!.title!;
    String content = n.article != null ? n.article!.abstract! : n.event!.abstract!;

    DateFormat formatter = DateFormat("dd MMMM yyyy · HH'h'mm", 'fr_FR');
    String date = formatter.format(n.datePublished!.toLocal());

    Widget card = Card(
      elevation: 2,
      color: COLOR_AE_BLUE,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: COLOR_AE_BLUE, width: 1)),
      child: Padding(
        padding: EdgeInsets.only(top: 15, bottom: 10, right: 15, left: 15),
        child: Stack(children: [
          Center(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  COLOR_AE_BLUE.withOpacity(0.1), BlendMode.dstATop),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
                height: 150,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: FONT_NUNITO,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    content,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: FONT_NUNITO,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    n.project!.name!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontFamily: FONT_NUNITO,
                    ),
                  ),
                  SizedBox(height: 2),
                  //* Date of the news
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontFamily: FONT_NUNITO,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );

    if (n.article != null) {
      return GestureDetector(
        child: Container(child: card),
        onTap: () {
          Navigator.of(context, rootNavigator: true)
              .pushNamed('/article', arguments: n.article);
        },
      );
    }

    return GestureDetector(
      child: Container(child: card),
      onTap: () {
        Navigator.of(context, rootNavigator: true)
            .pushNamed('/event', arguments: n.event);
      },
    );
  }

  static Widget carouselPlaceholder() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      //* Height of the picture (carousel)
      expandedHeight: 310,
      stretch: true,
      //* Stretch mode remove or add some features
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
        ],
        background: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                "À la une",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: FONT_NUNITO,
                ),
              ),
            ),
            CarouselSlider.builder(
                //* All the option of the carousel see the pubdev page
                options: CarouselOptions(
                  height: 275,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  enlargeCenterPage: true,
                ),
                itemCount: 1,
                itemBuilder: (BuildContext context, int currentIndex, int realIdx) {
                  return Shimmer.fromColors(
                    baseColor: COLOR_SHIMMER_WHITE,
                    highlightColor: Colors.grey[200]!,
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(color: COLOR_AE_BLUE, width: 1)),
                      child: Container(width: 500),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
