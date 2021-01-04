import 'dart:async';
import 'dart:convert';

import 'package:assoesaip_flutter/models/article.dart';
import 'package:assoesaip_flutter/models/event.dart';
import 'package:assoesaip_flutter/models/fcmToken.dart';
import 'package:assoesaip_flutter/models/project.dart';
import 'package:assoesaip_flutter/models/user.dart';
import 'package:assoesaip_flutter/screens/LoginPage/welcomePage.dart';
import 'package:assoesaip_flutter/screens/articlePage.dart';
import 'package:assoesaip_flutter/screens/eventsPage.dart';
import 'package:assoesaip_flutter/screens/loginPage/loadingScreen.dart';
import 'package:assoesaip_flutter/screens/loginPage/loginWebViewPage.dart';
import 'package:assoesaip_flutter/screens/main/mainNavigation.dart';
import 'package:assoesaip_flutter/screens/profilePage.dart';
import 'package:assoesaip_flutter/screens/project/projectPageWidget.dart';
import 'package:assoesaip_flutter/services/api.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  static User user;
  static FcmToken fcmToken;
  static final navigatorKey = new GlobalKey<NavigatorState>();
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  String _initialRoute = '';

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr_FR');

    getUser().then((value) {
      setState(() {
        MyApp.user = value;
        if (value == null) {
          _initialRoute = '/welcome';
        } else if (value.campus == "" || value.promo == "") {
          _initialRoute = '/profile';
        } else {
          _initialRoute = '/main/home';
        }
      });
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        // The notification is received when the app is running in the foreground.
        // Display a custom notification!
        var data = message['data'] ?? message;
        if (data['notify'] == '1') {
          buildNotification(jsonEncode(data));
        }
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        // A time loop to give time to the app to initialize the navigator
        // Otherwise the screen will not load ¯\_(ツ)_/¯
        var data = message['data'] ?? message;
        Timer.periodic(
          Duration(milliseconds: 500),
            (timer) {
              if (MyApp.navigatorKey.currentState == null) return;
              // The notification is received when the app is terminated.
              // The app starts, navigate to the desired page!
              handleNotificationNavigation(jsonEncode(data));
              timer.cancel();
            }
        );
      },
      onResume: (Map<String, dynamic> message) async {
        // The notification is received when the app is running in the background.
        // The app resumes, navigate to the desired page!
        var data = message['data'] ?? message;
        handleNotificationNavigation(jsonEncode(data));
      },
    );

    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      var t = FcmToken.fromTokenString(token);
      saveToken(t).then((value) {
        MyApp.fcmToken = value;
      });
    });

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('launcher_icon');
    final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    MyApp.flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: selectNotification
    );
  }

  void buildNotification(String json) {
    print('Build la notif');
    var data = jsonDecode(json);
    print(data);
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
        'all', 'Toutes les notifications', "Toutes les notifications de l'application.",
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
        styleInformation: BigTextStyleInformation(''),
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    MyApp.flutterLocalNotificationsPlugin.show(int.parse(data['id']), data['title'], data['abstract'], platformChannelSpecifics, payload: jsonEncode(data));
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      print('local payload');
      handleNotificationNavigation(payload);
    }
  }

  Future<void> handleNotificationNavigation(String payload) async {
    print('Handling notification... payload: ' + payload);
    var data = jsonDecode(payload);
    print('decoded data: $data');
    var route = '/main/home';
    var obj;
    print('type: ' + data['type']);
    if (data['type'] == 'article') {
      route = '/article';
      obj = Article(id: int.parse(data['id']));
    } else if (data['type'] == 'event') {
      route = '/event';
      obj = Event(id: int.parse(data['id']));
    } else if (data['type'] == 'project') {
      route = '/project';
      obj = Project(id: int.parse(data['id']), name: data['name'], description: data['description']);
    }
    print('route: $route');
    print('obj type: ' + obj.runtimeType.toString());

    await MyApp.navigatorKey.currentState.pushNamed(route, arguments: obj);
  }

  @override
  Widget build(BuildContext context) {
    if (_initialRoute == '') {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoadingScreen(),
      );
    }

    Widget home;
    switch (_initialRoute) {
      case '/welcome': home = WelcomePage(); break;
      case '/profile': home = ProfilePage(firstLogin: true); break;
      default: home = MainNavigation(tabIndex: 0);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: home,
      navigatorKey: MyApp.navigatorKey,
      onGenerateRoute: (settings) {
        final arguments = settings.arguments;
        var routes = {
          '/main/home': (context) => MainNavigation(tabIndex: 0),
          '/main/calendar': (context) => MainNavigation(tabIndex: 1),
          '/main/categories': (context) => MainNavigation(tabIndex: 2),
          '/main/cafet': (context) => MainNavigation(tabIndex: 3),
          '/welcome': (context) => WelcomePage(),
          '/welcome/login': (context) => LoginWebViewPage(),
          '/loading': (context) => LoadingScreen(),
          '/project': (context) => ProjectPageWidget(arguments),
          '/profile': (context) => ProfilePage(),
          '/article': (context) => ArticlePage(arguments),
          '/event': (context) => EventPage(arguments),
        };

        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
    );
  }
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // This is executed when there is only data and no notification payload.
    var data = message['data'] ?? message;
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}