import 'package:connevents/widgets/connevent-appbar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InAppBrowserPage extends StatelessWidget {
 final String link;
  const InAppBrowserPage({Key? key,this.link=""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ConneventAppBar(),
      body: WebView(
         initialUrl: link,
         javascriptMode: JavascriptMode.unrestricted,
                        ),
    );
  }
}
