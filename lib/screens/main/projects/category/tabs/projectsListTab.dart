import 'package:assoesaip_flutter/models/project.dart';
import 'package:assoesaip_flutter/screens/main/projects/project/projectPage.dart';
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
          children: widget.projects.map((e) => _buildAssoWidget(e)).toList()
        ),
      ),
    );
  }

  Widget _buildAssoWidget(Project project) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Container(
            constraints: BoxConstraints(minHeight: 80),
            width: double.infinity,
            child: Card(
              shape: roundedCorner,
              color: cardColor,
              margin: EdgeInsets.all(0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ProjectPage()));
                },
                borderRadius: BorderRadius.circular(10),
                splashColor: splashColor,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Text(
                        project.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: classicFont,
                          color: titleColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Text(
                        project.description,
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
        Column(
            children: project.childrenProjects.map((club) => _buildClubWidget(club)).toList()
        )
      ],
    );
  }

  Widget _buildClubWidget(Project p) {
    return Padding(
      padding: EdgeInsets.only(
          right: 15, left: 15, bottom: 10),
      child: Container(
        constraints:
        BoxConstraints(minHeight: 80),
        width: double.infinity,
        child: Card(
          shape: roundedCorner,
          margin: EdgeInsets.all(0),
          color: cardColor,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext
                      context) =>
                          ProjectPage()));
            },
            borderRadius:
            BorderRadius.circular(10),
            splashColor: splashColor,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10),
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
                    textAlign:
                    TextAlign.justify,
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
    );
  }
}
