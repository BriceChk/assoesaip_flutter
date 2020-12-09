import 'package:flutter/material.dart';

class Members extends StatelessWidget {
  final List<List<String>> memberlist = [
    ["assets/mages/moi.jpg", "CHKIR Brice", "Président"],
    ["assets/mages/moi.jpg", "BENASSE Mickaël", "Trésorier"],
    ["assets/mages/moi.jpg", "COLLET Joffrey", "Fuck joff"]
  ];

  @override
  Widget build(BuildContext context) {
    final membersMap = memberlist.asMap();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: membersMap
                  .map(
                    (i, element) => MapEntry(
                      i,
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Card(
                          child: Text(element[1]),
                        ),
                      ),
                    ),
                  )
                  .values
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
