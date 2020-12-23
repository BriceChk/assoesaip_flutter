import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:flutter/material.dart';

class ProjectMembersTab extends StatelessWidget {
  final double nameSize = 18;
  final double roleSize = 16;

  final List<List<String>> memberlist = [
    ["assets/images/moi.jpg", "CHKIR Brice", "Président"],
    ["assets/images/moi.jpg", "BENASSE Mickaël", "Trésorier"],
    ["assets/images/moi.jpg", "COLLET Joffrey", "Fuck joff"],
    ["assets/images/moi.jpg", "CHKIR Brice", "Président"],
    ["assets/images/moi.jpg", "BENASSE Mickaël", "Trésorier"],
  ];

  @override
  Widget build(BuildContext context) {
    final membersMap = memberlist.asMap();
    final RoundedRectangleBorder roundedCorner = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    );
    final BorderRadius roundedImage = BorderRadius.circular(10);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: membersMap
            .map(
              (i, element) => MapEntry(
                i,
                Padding(
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
                                image: AssetImage(element[0]),
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
                                element[1],
                                style: TextStyle(
                                  fontFamily: classicFont,
                                  fontSize: nameSize,
                                ),
                              ),
                              Text(
                                element[2],
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
                ),
              ),
            )
            .values
            .toList(),
      ),
    );
  }
}
