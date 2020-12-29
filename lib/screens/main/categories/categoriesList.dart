import 'package:assoesaip_flutter/models/projectCategory.dart';
import 'package:assoesaip_flutter/services/api.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:assoesaip_flutter/shares/newsList.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

final Color fontColor = Colors.black;

class CategoriesList extends StatefulWidget {
  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> with AutomaticKeepAliveClientMixin<CategoriesList> {
  @override
  bool get wantKeepAlive => true;

  List<ProjectCategory> categs;

  @override
  void initState() {
    super.initState();

    getProjectCategories().then((value) {
      setState(() {
        categs = value;
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
            "Parcourir les projets",
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
              SizedBox(height: 5),
              //* Widget with all the name of the categories of the association
              _buildCategoryList(),
              //* Sizedbox of height 60 because otherwise the last one is under the navbar
              SizedBox(height: 70),
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
              "Découvre les clubs et associations ton campus !",
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

  Widget _buildCategoryList() {
    if (categs is List<ProjectCategory>) {
      return Container(
        color: Colors.white,
        child: Column(
          children: categs.map((c) => _buildCategoryCard(c)).toList(),
        ),
      );
    } else {
      return NewsListWidget.newsListPlaceholder();
    }
  }

  Widget _buildCategoryCard(ProjectCategory c) {
    String imgUrl = 'https://asso-esaip.bricechk.fr/images/category-logos/' +
        c.logoFileName;

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
          child: InkWell(
              borderRadius: BorderRadius.circular(15),
              splashColor: splashColor,
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
                          imageUrl: imgUrl,
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
                          Text(
                            c.name,
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: classicFont,
                                color: titleColor),
                          ),
                          //* Description of the card
                          Text(
                            c.description,
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
              onTap: () {
                Navigator.of(context)
                    .pushNamed("/categories/category", arguments: c);
              }),
        ),
      ),
    );
  }
}