import 'package:assoesaip_flutter/models/fcmToken.dart';
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

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

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
        print("onMessage: $message");
        //_showItemDialog(message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        //_navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        //_navigateToItemDetail(message);
      },
    );

    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      var t = FcmToken.fromTokenString(token);
      saveToken(t).then((value) {
        MyApp.fcmToken = value;
      });
    });
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
    // Handle data message
    final dynamic data = message['data'];
    print(data);
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}
