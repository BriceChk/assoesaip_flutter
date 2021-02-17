import 'package:assoesaip_flutter/main.dart';
import 'package:assoesaip_flutter/services/api.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final bool firstLogin;

  ProfilePage({this.firstLogin = false});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double titleSize = 27.5;
  final double nameFontSize = 20;
  final BorderRadius profilePictureRadius = BorderRadius.circular(10);
  final BorderRadius buttonBorderRadius = BorderRadius.circular(10);
  String promoValue = MyApp.user.promo == '' ? 'ING1' : MyApp.user.promo;
  String campusValue = MyApp.user.campus == '' ? 'Angers' : MyApp.user.campus;
  bool notificationsEnabled = MyApp.fcmToken.notificationsEnabled;

  @override
  Widget build(BuildContext context) {
    String avatarUrl = 'https://asso.esaip.org/';

    if (MyApp.user.avatarFileName == null) {
      avatarUrl += 'build/images/placeholder.png';
    } else {
      avatarUrl += 'images/profile-pics/' + MyApp.user.avatarFileName;
    }
    return Scaffold(
      backgroundColor: whiteWhite,
      appBar: AppBar(
        title: Text(
          "Profil",
          style: TextStyle(
            fontSize: 30,
            color: headerTextColor,
            fontFamily: classicFont,
          ),
        ),
        centerTitle: true,
        backgroundColor: starCommandBlue,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: IntrinsicHeight(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 125,
                  height: 125,
                  child: ClipRRect(
                    borderRadius: profilePictureRadius,
                    child: CachedNetworkImage(
                      imageUrl: avatarUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  MyApp.user.firstName + ' ' + MyApp.user.lastName,
                  style: TextStyle(
                      fontFamily: classicFont, fontSize: nameFontSize),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Campus : ",
                          style: TextStyle(
                              fontFamily: classicFont,
                              fontSize: nameFontSize - 3),
                        ),
                        SizedBox(height: 25),
                        Text(
                          "Promotion : ",
                          style: TextStyle(
                              fontFamily: classicFont,
                              fontSize: nameFontSize - 3),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 125,
                          child: DropdownButton<String>(
                            value: campusValue,
                            isExpanded: true,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: starCommandBlue),
                            onChanged: (String newValue) {
                              setState(() {
                                campusValue = newValue;
                              });
                            },
                            items: <String>['Angers', 'Aix']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          width: 125,
                          child: DropdownButton<String>(
                            value: promoValue,
                            isExpanded: true,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: starCommandBlue),
                            onChanged: (String newValue) {
                              setState(() {
                                promoValue = newValue;
                              });
                            },
                            items: <String>[
                              'ING1',
                              'ING2',
                              'IR3',
                              'IR4',
                              'IR5',
                              'SEP3',
                              'SEP4',
                              'SEP5',
                              'IRA3',
                              'IRA4',
                              'IRA5',
                              'SEPA3',
                              'SEPA4',
                              'SEPA5',
                              'BACH1',
                              'BACH2',
                              'BACH3',
                              'CPI',
                              'Personnel esaip',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25),
                //TODO Relier les notifications à chaque Users
                MergeSemantics(
                  child: ListTile(
                    title: Text(
                      'Notifications',
                      style: TextStyle(
                          fontFamily: classicFont, fontSize: nameFontSize - 3),
                    ),
                    trailing: CupertinoSwitch(
                      activeColor: starCommandBlue,
                      value: notificationsEnabled,
                      onChanged: (bool value) {
                        setState(() {
                          notificationsEnabled = value;
                        });
                      },
                    ),
                    onTap: () {
                      setState(() {
                        notificationsEnabled = !notificationsEnabled;
                      });
                    },
                  ),
                ),
                Builder(
                  builder: (context) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: FlatButton(
                      onPressed: () {
                        MyApp.user.campus = campusValue;
                        MyApp.user.promo = promoValue;
                        MyApp.fcmToken.notificationsEnabled =
                            notificationsEnabled;
                        saveToken(MyApp.fcmToken);
                        updateProfile(MyApp.user).then((value) {
                          if (widget.firstLogin) {
                            Navigator.pushReplacementNamed(
                                context, '/main/home');
                          }
                          var sb;
                          if (value == null) {
                            sb = SnackBar(
                                content: Text('Une erreur est survenue'));
                          } else {
                            sb = SnackBar(
                                content: Text(
                                    'Les modifications ont été enregistrées !'));
                          }
                          Scaffold.of(context).showSnackBar(sb);
                        });
                      },
                      child: FittedBox(
                        child: Text(
                          "Enregistrer",
                          style: TextStyle(
                              fontFamily: classicFont,
                              color: white,
                              fontSize: nameFontSize - 3),
                        ),
                      ),
                      color: starCommandBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: buttonBorderRadius),
                    ),
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
