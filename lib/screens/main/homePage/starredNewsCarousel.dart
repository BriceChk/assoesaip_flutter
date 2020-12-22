import 'package:assoesaip_flutter/models/news.dart';
import 'package:assoesaip_flutter/services/api.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StarredNewsCarouselWidget extends StatefulWidget {
  @override
  _StarredNewsCarouselWidgetState createState() =>
      _StarredNewsCarouselWidgetState();
}

class _StarredNewsCarouselWidgetState extends State<StarredNewsCarouselWidget> {
  List<News> news;

  final String classicFont = "Nunito";
  final Color backgroundColor = whiteWhite;
  final Color titleColor = esaipBlue;
  final Color fontColor = Colors.black;

  @override
  void initState() {
    super.initState();
    getStarredNews().then((value){
      setState(() {
        news = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (news is List<News>) {
      return _buildCarouselWidget();
    }  else if (news == null) {
      return SliverPadding(padding: EdgeInsets.zero);
    } else {
      return SliverPadding(padding: EdgeInsets.zero);
    }
  }

  Widget _buildCarouselWidget() {
    if (news.length == 0) {
      return SliverPadding(padding: EdgeInsets.zero);
    }

    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: whiteWhite,
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
                  fontFamily: classicFont,
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
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {

                  },
                ),
                itemCount: news.length,
                itemBuilder: (BuildContext context, int currentIndex) => _buildCarouselItem(news[currentIndex])
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselItem(News n) {
    String imageUrl = 'https://asso-esaip.bricechk.fr/images/';
    if (n.project.logoFileName == null) {

    } else {
      imageUrl += 'project-logos/' + n.project.logoFileName;
    }

    // The title is the Article title or the Event title ...
    String title = n.article != null ? n.article.title : n.event.title;
    String content = n.article != null ? n.article.abstract : n.event.abstract;

    DateFormat formatter = DateFormat('dd MMMM yyyy', 'fr_FR');
    String date = formatter.format(n.datePublished);

    return Card(
      elevation: 2,
      color: white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: esaipBlue, width: 1)
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(white.withOpacity(0.1), BlendMode.dstATop),
                image: NetworkImage(imageUrl, scale: 10),
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
              )
          ),
          child: Column(
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
                        color: titleColor,
                        fontFamily: classicFont,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  //! See the overflow of the text right here
                  Text(
                    content,
                    style: TextStyle(
                      fontSize: 16,
                      color: fontColor,
                      fontFamily: classicFont,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    n.project.name,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: classicFont,
                    ),
                  ),
                  SizedBox(height: 2),
                  //* Date of the news
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: classicFont,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
