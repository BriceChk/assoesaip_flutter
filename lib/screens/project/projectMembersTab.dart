import 'package:assoesaip_flutter/models/projectMember.dart';
import 'package:assoesaip_flutter/shares/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectMembersTab extends StatelessWidget {
  final double nameSize = 18;
  final double roleSize = 16;

  final List<ProjectMember>? members;

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
    List<Widget> list = [];
    list.add(Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
        child: Text(
          'Appuie sur une personne pour la contacter par mail !',
          style: TextStyle(fontStyle: FontStyle.italic),
        )));
    list.addAll(members!.map((e) => _buildMemberCard(e)).toList());

    return list;
  }

  Widget _buildMemberCard(ProjectMember p) {
    String avatarUrl = 'https://$AE_HOST/';
    if (p.user!.avatarFileName == null) {
      avatarUrl += 'build/images/placeholder.png';
    } else {
      avatarUrl += 'images/profile-pics/' + p.user!.avatarFileName!;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(15),
      splashColor: COLOR_AE_BLUE,
      onTap: () async {
        final Uri params = Uri(
          scheme: 'mailto',
          path: p.user!.username
        );
        String url = params.toString();
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
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
                        image: CachedNetworkImageProvider(avatarUrl)),
                  ),
                ),
                SizedBox(width: 15),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.user!.firstName! + ' ' + p.user!.lastName!,
                        style: TextStyle(
                            fontFamily: FONT_NUNITO,
                            fontSize: nameSize,
                            color: COLOR_NAVY_BLUE),
                      ),
                      Text(
                        p.role! + ' - ' + p.user!.promo!,
                        style: TextStyle(
                          fontFamily: FONT_NUNITO,
                          fontSize: roleSize,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        p.introduction!,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontFamily: FONT_NUNITO
                        ),
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
