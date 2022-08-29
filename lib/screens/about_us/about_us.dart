import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

bool isProgress = true;

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    late WebViewController _controller;
    return Scaffold(
      body: Stack(
        children: [
          WebView(
            initialUrl: "https://alamelumangaimatrimony.com/mobile/about",
            onWebViewCreated: (controller) {
              _controller = controller;
            },
            javascriptMode: JavascriptMode.unrestricted,
            gestureNavigationEnabled: true,
            onPageFinished: (url) => setState(() {
              isProgress = false;
            }),
          ),
          isProgress
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(),
        ],
      ),
    );
  }
}
