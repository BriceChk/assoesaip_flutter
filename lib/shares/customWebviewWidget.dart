import 'dart:convert';

import 'package:assoesaip_flutter/shares/circularProgressPlaceholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class CustomWebview extends StatefulWidget {
  final String html;

  CustomWebview(this.html);

  @override
  _CustomWebviewState createState() => _CustomWebviewState();
}

class _CustomWebviewState extends State<CustomWebview> {
  WebViewPlusController _controller;
  double _height = 1;

  num _stackToView = 1;

  @override
  Widget build(BuildContext context) {

    if (_controller is WebViewPlusController) {
      _loadHtmlFromString();
    }

    return IndexedStack(
        index: _stackToView,
        children: [

          SizedBox(
            height: _height,
            child: WebViewPlus(
              onWebViewCreated: (controller) {
                this._controller = controller;
                _loadHtmlFromString();
              },
              onPageFinished: (url) {
                _controller.getHeight().then((double height) {
                  setState(() {
                    _height = height;
                    _stackToView = 0;
                  });
                });
              },
              javascriptMode: JavascriptMode.unrestricted,
              navigationDelegate: (action) async {
                if (await canLaunch(action.url)) {
                  await launch(action.url);
                } else {
                  throw 'Could not launch ' + action.url;
                }
                return NavigationDecision.prevent;
              },
            ),
          ),
          CircularProgressPlaceholder(),
        ]
    );
  }

  _loadHtmlFromString() async {
    String fileText = await rootBundle.loadString('assets/webview_template.html');

    // Load the Nunito font
    final fontFile = await rootBundle.load('assets/fonts/Nunito/Nunito-Regular.ttf');
    final buffer = fontFile.buffer;
    final fontUri = Uri.dataFromBytes(buffer.asUint8List(fontFile.offsetInBytes, fontFile.lengthInBytes), mimeType: 'font/opentype');
    final fontCss = '@font-face { font-family: customFont; src: url($fontUri); } * { font-family: customFont; }';

    fileText = '<style>$fontCss</style>' + fileText.replaceFirst('%body%', widget.html);
    _controller.loadUrl( Uri.dataFromString(
        fileText,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8')
    ).toString());
  }
}
