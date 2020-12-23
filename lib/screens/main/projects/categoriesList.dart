import 'package:assoesaip_flutter/models/projectCategory.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';
import 'package:assoesaip_flutter/services/api.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

final Color fontColor = Colors.black;

class CategoriesList extends StatefulWidget {
  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
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
    //* Using the CustomScroolView in order to have the bouncingScrollPhysic
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        //* We wrap our header inside the sliverAppBar with somme properties
        SliverAppBar(
          automaticallyImplyLeading: true,
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
            "Découvre les clubs et associations ton campus !",
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 16,
              color: headerTextColor,
              fontFamily: classicFont,
            ),
          ),
        ),
      )
    );
  }

  Widget _buildCategoryList() {
    if (categs is List<ProjectCategory>) {
      return Column(
        children: categs.map((c) => _buildCategoryCard(c)).toList(),
      );
    } else {
      return _categoryListPlaceholder();
    }
  }

  Widget _categoryListPlaceholder() {
    List<Widget> list = List();

    for (var i = 0; i < 10; i++) {
      list.add(Shimmer.fromColors(
        baseColor: cardColor,
        highlightColor: Colors.grey[200],
        child: Container(
            padding: EdgeInsets.only(top: 5, right: 10, left: 10),
            //! boxConstraints like this we can set a min height to the card and combine with flexible the height can be override
            constraints: BoxConstraints(
              minHeight: 90,
            ),
            //width: MediaQuery.of(context).size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 7.5,
                  vertical: 5,
                ),
                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [],
                      ),
                    ),
                  ],
                ),
              ),
            )
        ),
      ));
    }

    return Column(
      children: list,
    );
  }

  Widget _buildCategoryCard(ProjectCategory c) {
    String imgUrl = 'https://asso-esaip.bricechk.fr/images/category-logos/' + c.logoFileName;

    return Container(
      padding: EdgeInsets.only(top: 5, right: 10, left: 10),
      //! boxConstraints like this we can set a min height to the card and combine with flexible the height can be override
      constraints: BoxConstraints(
        minHeight: 90,
      ),
      //width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 0.5,
        shadowColor: shadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: cardColor,
        //* InkWell like this we can integrate the ontap function
        child: InkWell(
            borderRadius: BorderRadius.circular(10),
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
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: imgUrl,
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 150),
                    ),
                  ),
                  SizedBox(width: 5),
                  //! Wrap in flexible like this we can have text in multiline
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
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
              Navigator.of(context).pushNamed("Category", arguments: c);
            }),
      ),
    );
  }
}