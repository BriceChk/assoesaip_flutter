import 'package:assoesaip_flutter/models/cafetItem.dart';
import 'package:assoesaip_flutter/models/cafetProperties.dart';
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

  CafetProperties cafetProperties;
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

    var date = DateTime.now();
    var now = DateTime.now();
    var testString = date.toString().split(' ')[0] + ' 12:45:00.000000';
    var testDate = DateTime.parse(testString);
    day = DateFormat('EEEE', 'fr_FR').format(date);

    if (date.isAfter(testDate)) {
      date = date.add(Duration(days: 1));
    }

    getCafetProperties().then((value) {
      setState(() {
        cafetProperties = value;
        while (itemsMap[CafetItemType.REPAS].length == 0) {
          var weekDayNumber = date.weekday.toString();
          itemsMap[CafetItemType.REPAS].clear();
          itemsMap[CafetItemType.BOISSON].clear();
          itemsMap[CafetItemType.DESSERT].clear();

          cafetProperties.items.forEach((i) {
            if (i.day.contains(weekDayNumber)) {
              itemsMap[i.type].add(i);
            }
          });
          if (itemsMap[CafetItemType.REPAS].length == 0) {
            date = date.add(Duration(days: 1));
            if (date.difference(now).inDays > 7) {
              break;
            }
          }
        }
        day = DateFormat('EEEE', 'fr_FR').format(date);
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    var body;

    if (itemsMap[CafetItemType.REPAS].isEmpty) {
      body = [
        Padding(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  "assets/images/no_data.png",
                  fit: BoxFit.contain,
                ),
                height: 200,
              ),
              SizedBox(height: 25),
              Text(
                "Aucun repas n'est prévu à la Cafet'",
                style: TextStyle(fontSize: 18, fontFamily: classicFont),
              ),
            ],
          ),
        )
      ];
    } else {
      body = [
        Padding(
          padding: EdgeInsets.only(top: 5, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Menu de " + day,
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: classicFont,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                height: 1,
                color: Colors.grey[200],
              ),
            ],
          ),
        ),

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
        SizedBox(height: 100),
      ];
    }

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
          actions: [
            Container(
              decoration: BoxDecoration(
                borderRadius: cardsBorderRadius,
                color: cafetProperties is CafetProperties ? (cafetProperties.isOpen ? Colors.green : Colors.red) : starCommandBlue,
              ),
              margin: EdgeInsets.fromLTRB(0, 15, 10, 15),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Center(child: Text(cafetProperties is CafetProperties ? (cafetProperties.isOpen ? 'Ouverte' : 'Fermée') : '')),
            )
          ],
          toolbarHeight: 60,
          expandedHeight: 150,
          floating: true,
          pinned: true,
          backgroundColor: headerColor,
        ),
        //* We wrap the rest of the page inside the SliverList: like this everything scrool vertically except the header
        SliverList(
          delegate: SliverChildListDelegate(
            body,
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
              cafetProperties is CafetProperties ? cafetProperties.message : '',
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
    if (!(cafetProperties is CafetProperties)) return NewsListWidget.newsListPlaceholder(count: 3);

    var widgets = itemsMap.map((e) {
      String imageUrl = 'https://asso.esaip.org/';
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
