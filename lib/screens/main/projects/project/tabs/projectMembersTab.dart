import 'package:assoesaip_flutter/models/projectMember.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectMembersTab extends StatelessWidget {
  final double nameSize = 18;
  final double roleSize = 16;

  final List<ProjectMember> members;

  ProjectMembersTab(this.members);

  final RoundedRectangleBorder roundedCorner = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  );
  final BorderRadius roundedImage = BorderRadius.circular(10);

  @override
  Widget build(BuildContext context) {
    return Column(children: _buildList());
  }

  List<Widget> _buildList() {
    List<Widget> list = List();
    list.add(Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
        child: Text(
          'Appuie sur une personne pour la contacter par mail !',
          style: TextStyle(fontStyle: FontStyle.italic),
        )));
    list.addAll(members.map((e) => _buildMemberCard(e)).toList());

    return list;
  }

  Widget _buildMemberCard(ProjectMember p) {
    String avatarUrl = 'https://asso-esaip.bricechk.fr/';
    if (p.user.avatarFileName == null) {
      avatarUrl += 'build/images/placeholder.png';
    } else {
      avatarUrl += 'images/profile-pics/' + p.user.avatarFileName;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(15),
      splashColor: splashColor,
      onTap: () async {
        if (await canLaunch('mailto:' + p.user.username)) {
          await launch('mailto:' + p.user.username);
        } else {
          throw 'Could not launch mailto:' + p.user.username;
        }
      },
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
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    //* have the same rounded corner as the big container
                    borderRadius: BorderRadius.circular(80),
                    image: DecorationImage(
                      image: NetworkImage(avatarUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.user.firstName + ' ' + p.user.lastName,
                        style: TextStyle(
                            fontFamily: classicFont,
                            fontSize: nameSize,
                            color: navyBlue),
                      ),
                      Text(
                        p.role,
                        style: TextStyle(
                          fontFamily: classicFont,
                          fontSize: roleSize,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        p.introduction,
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
