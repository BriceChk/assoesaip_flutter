import 'dart:async';

import 'package:assoesaip_flutter/main.dart';
import 'package:assoesaip_flutter/screens/main/mainNavigation.dart';
import 'package:assoesaip_flutter/services/api.dart';
import 'package:assoesaip_flutter/shares/constant.dart';
import 'package:assoesaip_flutter/screens/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:requests/requests.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';


class LoginWebViewPage extends StatelessWidget {

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  final cookieManager = WebviewCookieManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Connexion",
            style: TextStyle(
              fontSize: 30,
              color: headerTextColor,
              fontFamily: classicFont,
            ),
          ),
          backgroundColor: starCommandBlue,
        ),
        body: WebView(
          navigationDelegate: (NavigationRequest request) async {
            if (request.url == 'https://asso-esaip.bricechk.fr/') {
              // When we get to the home screen of the website, store the session cookie and go to the main screen app
              final cookies = await cookieManager.getCookies('https://asso-esaip.bricechk.fr/');
              Map<String, String> map = Map();
              for (var c in cookies) {
                if (c.name == "PHPSESSID") {
                  map[c.name] = c.value;
                  break;
                }
              }
              Requests.setStoredCookies('asso-esaip.bricechk.fr:443', map);
              MyApp.user = await getUser();
              await MyApp.getAndSaveToken();
              if (MyApp.user.campus == "" || MyApp.user.promo == "") {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => ProfilePage())
                );
              } else {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => MainNavigation())
                );
              }
              return NavigationDecision.prevent;
            } else {
              return NavigationDecision.navigate;
            }
          },
          initialUrl: "https://asso-esaip.bricechk.fr/login",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
  }
}
