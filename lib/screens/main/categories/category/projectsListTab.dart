import 'package:assoesaip_flutter/models/project.dart';
import 'package:assoesaip_flutter/shares/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProjectsListTab extends StatefulWidget {
  final List<Project>? projects;

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
            children: widget.projects!.map((e) {
              if (e.type == 'Association')
                return _buildAssoWidget(e);
              return _buildClubWidget(e);
            }).toList()),
      ),
    );
  }

  Widget _buildAssoWidget(Project p) {
    String imageUrl = 'https://$AE_HOST/';
    if (p.logoFileName == null) {
      imageUrl += 'build/images/project-placeholder.png';
    } else {
      imageUrl += 'images/project-logos/' + p.logoFileName!;
    }

    // Sort children projects
    p.childrenProjects!.sort((a, b) => a.name!.compareTo(b.name!));

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 15),
          child: Container(
            constraints: BoxConstraints(minHeight: 80),
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(BORDER_RADIUS_CARD),
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                    color: Colors.grey[400]!,
                    blurRadius: 3.0,
                    offset: new Offset(0.0, 0.0),
                  ),
                ],
              ),
              child: Material(
                borderRadius: BorderRadius.circular(BORDER_RADIUS_CARD),
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(
                        '/project',
                        arguments: p);
                  },
                  borderRadius: BorderRadius.circular(15),
                  splashColor: COLOR_AE_BLUE,
                  //! Faire les images en fonction de la hauteur de la cards
                  //! Pour les clubs et Asso
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Center(
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  fit: BoxFit.contain,
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                            ),
                            Text(
                              p.name!,
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: FONT_NUNITO,
                                color: COLOR_NAVY_BLUE,
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Text(
                          p.description!,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: FONT_NUNITO,
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
            children: p.childrenProjects!
                .map((club) => _buildClubWidget(club))
                .toList())
      ],
    );
  }

  Widget _buildClubWidget(Project p) {
    String imageUrl = 'https://$AE_HOST/';
    if (p.logoFileName == null) {
      imageUrl += 'build/images/project-placeholder.png';
    } else {
      imageUrl += 'images/project-logos/' + p.logoFileName!;
    }
    return Padding(
      padding: EdgeInsets.only(right: 15, left: 15, bottom: 15),
      child: Container(
        constraints: BoxConstraints(minHeight: 80),
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(BORDER_RADIUS_CARD),
            boxShadow: <BoxShadow>[
              new BoxShadow(
                color: Colors.grey[400]!,
                blurRadius: 3.0,
                offset: new Offset(0.0, 0.0),
              ),
            ],
          ),
          child: Material(
            borderRadius: BorderRadius.circular(BORDER_RADIUS_CARD),
            color: Colors.white,
            child: InkWell(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pushNamed(
                    '/project',
                    arguments: p);
              },
              borderRadius: BorderRadius.circular(15),
              splashColor: COLOR_AE_BLUE,
              //! Faire les images en fonction de la hauteur de la cards
              //! Pour les clubs et Asso
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Center(
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.contain,
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ),
                        Text(
                          p.name!,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: FONT_NUNITO,
                            color: COLOR_NAVY_BLUE,
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Text(
                      p.description!,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: FONT_NUNITO,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
