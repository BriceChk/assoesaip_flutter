import 'package:assoesaip_flutter/models/projectMember.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

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

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: members.map((e) => _buildMemberCard(e)).toList()
      ),
    );
  }

  Widget _buildMemberCard(ProjectMember p) {
    String avatarUrl = 'https://asso-esaip.bricechk.fr/';
    if (p.user.avatarFileName == null) {
      avatarUrl += 'build/images/placeholder.png';
    } else {
      avatarUrl += 'images/profile-pics/' + p.user.avatarFileName;
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.5),
      child: Container(
        width: double.infinity,
        height: 100,
        child: Card(
          color: white,
          shape: roundedCorner,
          child: Row(
            children: [
              Container(
                height: double.infinity,
                width: 90,
                decoration: BoxDecoration(
                  //* have the same rounded corner as the big container
                  borderRadius: roundedImage,
                  image: DecorationImage(
                    image: NetworkImage(avatarUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.user.firstName + ' ' + p.user.lastName,
                    style: TextStyle(
                      fontFamily: classicFont,
                      fontSize: nameSize,
                    ),
                  ),
                  Text(
                    p.role,
                    style: TextStyle(
                      fontFamily: classicFont,
                      fontSize: roleSize,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
