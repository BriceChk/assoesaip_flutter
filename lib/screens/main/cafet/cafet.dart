import 'package:assoesaip_flutter/models/cafetItem.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:assoesaip_flutter/services/api.dart';
import 'package:assoesaip_flutter/shares/newsList.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class CafetWidget extends StatefulWidget {
  @override
  _CafetWidgetState createState() => _CafetWidgetState();
}

class _CafetWidgetState extends State<CafetWidget> with AutomaticKeepAliveClientMixin<CafetWidget> {
  @override
  bool get wantKeepAlive => true;

  List<CafetItem> items;
  Map<CafetItemType, List<CafetItem>> itemsMap = {
    CafetItemType.REPAS: List(),
    CafetItemType.BOISSON: List(),
    CafetItemType.DESSERT: List(),
  };

  String day;

  final RoundedRectangleBorder roundedBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(25),
    ),
  );

  @override
  void initState() {
    super.initState();

    var now = DateTime.now();
    var testString = now.toString().split(' ')[0] + ' 12:45:00.000000';
    var testDate = DateTime.parse(testString);
    if (now.isAfter(testDate)) {
      now = now.add(Duration(days: 1));
    }
    day = DateFormat('EEEE', 'fr_FR').format(now);

    getCafetItems().then((value) {
      setState(() {
        items = value;
        items.forEach((i) {
          if (i.day == day || i.day == 'lundi,mardi,mercredi,vendredi') {
            itemsMap[i.type].add(i);
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //* Using the CustomScroolView in order to have the bouncingScrollPhysic
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        //* We wrap our header inside the sliverAppBar with somme properties
        SliverAppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "La Cafet'",
            style: TextStyle(
              fontSize: 30,
              color: headerTextColor,
              fontFamily: classicFont,
            ),
          ),
          flexibleSpace: _headerFlexibleSpace(),
          toolbarHeight: 60,
          expandedHeight: 100,
          floating: true,
          pinned: true,
          backgroundColor: headerColor,
        ),
        //* We wrap the rest of the page inside the SliverList: like this everything scrool vertically except the header
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: EdgeInsets.only(top: 5, left: 10),
                child: Text(
                  "Repas",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: classicFont,
                  ),
                ),
              ),
              _buildItemList(itemsMap[CafetItemType.REPAS]),
              Padding(
                padding: EdgeInsets.only(top: 5, left: 10),
                child: Text(
                  "Boissons",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: classicFont,
                  ),
                ),
              ),
              _buildItemList(itemsMap[CafetItemType.BOISSON]),
              Padding(
                padding: EdgeInsets.only(top: 5, left: 10),
                child: Text(
                  "Desserts",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: classicFont,
                  ),
                ),
              ),
              _buildItemList(itemsMap[CafetItemType.DESSERT]),
              //* Sizedbox of height 60 because otherwise the last one is under the navbar
              SizedBox(height: 60),
            ],
          ),
        ),
      ],
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
              "Au menu de $day, il y a ...",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                color: headerTextColor,
                fontFamily: classicFont,
              ),
            ),
          ),
        ));
  }

  Widget _buildItemList(List<CafetItem> itemsMap) {
    if (!(items is List)) return NewsListWidget.newsListPlaceholder(count: 3);

    var widgets = itemsMap.map((e) {
      String imageUrl = 'https://asso-esaip.bricechk.fr/';
      if (e.imageFileName == null) {
        imageUrl += 'build/images/project-placeholder.png';
      } else {
        imageUrl += 'images/cafet-images/' + e.imageFileName;
      }

      return Container(
        padding: EdgeInsets.only(top: 6, right: 10, left: 10, bottom: 6),
        //! boxConstraints like this we can set a min height to the card and combine with flexible the height can be override
        constraints: BoxConstraints(
          minHeight: 100,
        ),
        //width: MediaQuery.of(context).size.width,
        child: Container(
          decoration: BoxDecoration(
            color: whiteWhite,
            borderRadius: cardsBorderRadius,
            boxShadow: <BoxShadow>[
              new BoxShadow(
                color: Colors.grey[400],
                blurRadius: 3.0,
                offset: new Offset(0.0, 0.0),
              ),
            ],
          ),
          //* Material then InkWell in order to have the ripple effect + ontap function
          child: Material(
            borderRadius: cardsBorderRadius,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 7.5,
                vertical: 5,
              ),
              child: Row(
                children: [
                  Container(
                      width: 75,
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        width: 75,
                        height: 75,
                        fit: BoxFit.contain,
                      )),
                  SizedBox(width: 5),
                  //! Wrap in flexible like this we can have text in multiline
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //* Title of card
                        FittedBox(
                          child: Text(
                            e.name + ' · ' + format(e.price) + '€',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: classicFont,
                                color: titleColor),
                          ),
                        ),
                        //* Description of the card
                        Text(
                          e.description,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: classicFont,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();

    return Column(
      children: widgets,
    );
  }

  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }
}
