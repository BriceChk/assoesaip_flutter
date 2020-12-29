import 'package:assoesaip_flutter/models/project.dart';
import 'package:assoesaip_flutter/screens/project/projectPageWidget.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

class ProjectsListTab extends StatefulWidget {
  final List<Project> projects;

  ProjectsListTab(this.projects);

  @override
  _ProjectsListTabState createState() => _ProjectsListTabState();
}

class _ProjectsListTabState extends State<ProjectsListTab> {
  final RoundedRectangleBorder roundedCorner = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        child: Column(
            children: widget.projects.map((e) => _buildAssoWidget(e)).toList()),
      ),
    );
  }

  Widget _buildAssoWidget(Project p) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 15),
          child: Container(
            constraints: BoxConstraints(minHeight: 80),
            width: double.infinity,
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
              child: Material(
                borderRadius: cardsBorderRadius,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) => ProjectPageWidget(p)));
                  },
                  borderRadius: BorderRadius.circular(15),
                  splashColor: splashColor,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(
                          p.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: classicFont,
                            color: titleColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(
                          p.description,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: classicFont,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Column(
            children: p.childrenProjects
                .map((club) => _buildClubWidget(club))
                .toList())
      ],
    );
  }

  Widget _buildClubWidget(Project p) {
    return Padding(
      padding: EdgeInsets.only(right: 15, left: 15, bottom: 15),
      child: Container(
        constraints: BoxConstraints(minHeight: 80),
        width: double.infinity,
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
              onTap: () {
                Navigator.pushNamed(context, '/project', arguments: p);
              },
              borderRadius: BorderRadius.circular(15),
              splashColor: splashColor,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Text(
                      p.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: classicFont,
                        color: titleColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      p.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: classicFont,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
