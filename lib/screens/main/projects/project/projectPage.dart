import 'package:assoesaip_flutter/screens/main/projects/project/projectBody.dart';
import 'package:assoesaip_flutter/screens/main/projects/project/projectHeader.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

class ProjectPage extends StatefulWidget {
  static final List<List<String>> menuAssoList = [
    ["Accueil", "Selected"],
    ["Actu", "Unselected"],
    ["Membres", "Unselected"],
    ["Partenariats", "Unselected"],
  ];

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final menuAssoMap = ProjectPage.menuAssoList.asMap();

  final double paddinghorizontal = 15;
  final RoundedRectangleBorder roundedBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(25),
    ),
  );
  @override
  Widget build(BuildContext context) {
    //! Wrap in container with the color white because of the "extendbody: true" in navbar.
    return Container(
      color: whiteWhite,
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            shape: roundedBorder,
            toolbarHeight: 200,
            actions: [
              ProjectHeader(),
            ],
          ),
          //* All the other Widget
          SliverList(
            delegate: SliverChildListDelegate(
              [
                //* Widget with all the name of the categories of the association
                ProjectBody(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
