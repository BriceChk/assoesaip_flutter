import 'dart:async';

import 'package:assoesaip_flutter/models/user.dart';
import 'package:assoesaip_flutter/screens/main/mainNavigation.dart';
import 'package:assoesaip_flutter/services/api.dart';
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
          title: Text("Connexion à Asso'esaip"),
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
              User user = await getUser();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => MainNavigation(user))
              );
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
