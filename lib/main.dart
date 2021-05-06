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
import 'package:assoesaip_flutter/shares/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  static User? user;
  static FcmToken? fcmToken;
  static final navigatorKey = new GlobalKey<NavigatorState>();
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> getAndSaveToken() async {
    var token = await (FirebaseMessaging.instance.getToken());
    assert(token != null);
    var t = FcmToken.fromTokenString(token!);
    var value = await saveToken(t);
    MyApp.fcmToken = value;
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String _initialRoute = '';

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr_FR');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }

      //TODO better implementation
      buildNotification(jsonEncode(message.data));
    });

    /*RemoteMessage initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage?.data['notify'] == '1') {
      // Maybe need to wait :
      /*
       * Timer.periodic(
          Duration(milliseconds: 500),
          (timer) {
          if (MyApp.navigatorKey.currentState == null) return;
          // The notification is received when the app is terminated.
          // The app starts, navigate to the desired page!
          handleNotificationNavigation(jsonEncode(data));
          timer.cancel();
          }
          );
       */
      handleNotificationNavigation(jsonEncode(initialMessage.data));
    }*/

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['notify'] == '1') {
        handleNotificationNavigation(jsonEncode(message.data));
      }
    });

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
      if (MyApp.user != null) {
        MyApp.getAndSaveToken().then((value) {
          setState(() {
            //TODO Try to do nothing?
          });
        });
      }
    });

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('notif_icon');
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
    var data = jsonDecode(json);
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

  Future selectNotification(String? payload) async {
    if (payload != null) {
      handleNotificationNavigation(payload);
    }
  }

  Future<void> handleNotificationNavigation(String payload) async {
    var data = jsonDecode(payload);
    var route = '/main/home';
    var obj;
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

    await MyApp.navigatorKey.currentState!.pushNamed(route, arguments: obj);
  }

  @override
  Widget build(BuildContext context) {
    // If we have to show the profile page on first login, wait for the fcmToken to be ready
    if (_initialRoute == '' || (_initialRoute == '/profile' && MyApp.fcmToken == null)) {
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

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: COLOR_AE_BLUE,
      statusBarColor: COLOR_AE_BLUE
    ));

    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: COLOR_AE_BLUE,
        primaryColorBrightness: Brightness.light,
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
        )
      ),
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
          '/project': (context) => ProjectPageWidget(arguments as Project?),
          '/profile': (context) => ProfilePage(),
          '/article': (context) => ArticlePage(arguments as Article?),
          '/event': (context) => EventPage(arguments as Event?),
        };

        WidgetBuilder? builder = routes[settings.name!];
        return MaterialPageRoute(builder: (ctx) => builder!(ctx));
      },
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}