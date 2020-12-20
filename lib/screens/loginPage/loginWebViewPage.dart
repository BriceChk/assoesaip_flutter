import 'file:///C:/Users/brice/Desktop/assoesaip_flutter/lib/screens/main/mainNavigation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';

class LoginWebViewPage extends StatelessWidget {

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Connexion à Asso'esaip"),
        ),
        body: WebView(
          navigationDelegate: (NavigationRequest request) {
            if (request.url == 'https://asso-esaip.bricechk.fr/') {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => MainNavigation()));
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
