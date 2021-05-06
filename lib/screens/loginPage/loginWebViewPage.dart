import 'dart:async';

import 'package:assoesaip_flutter/main.dart';
import 'package:assoesaip_flutter/screens/main/mainNavigation.dart';
import 'package:assoesaip_flutter/services/api.dart';
import 'package:assoesaip_flutter/shares/constants.dart';
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
              color: Colors.white,
              fontFamily: FONT_NUNITO,
            ),
          ),
          backgroundColor: COLOR_AE_BLUE,
        ),
        body: WebView(
          navigationDelegate: (NavigationRequest request) async {
            if (request.url == 'https://$AE_HOST/' || request.url == 'https://$AE_HOST/profil') {
              // When we get to the home screen of the website, store the session cookie and go to the main screen app
              final cookies = await cookieManager.getCookies('https://$AE_HOST/');
              Map<String, String> map = Map();
              for (var c in cookies) {
                if (c.name == "PHPSESSID" || c.name == "REMEMBERME") {
                  map[c.name] = c.value;
                  break;
                }
              }

              Requests.setStoredCookies('$AE_HOST:443', map);
              getUser().then((value) {
                MyApp.user = value;
                MyApp.getAndSaveToken().then((value) {
                  if (MyApp.user!.campus == "" || MyApp.user!.promo == "") {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => ProfilePage(firstLogin: true))
                    );
                  } else {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => MainNavigation())
                    );
                  }
                });
              });

              return NavigationDecision.prevent;
            } else {
              return NavigationDecision.navigate;
            }
          },
          initialUrl: "https://$AE_HOST/login",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
  }
}
