import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

bool isProgress = true;

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    late WebViewController _controller;
    return Scaffold(
      body: Stack(
        children: [
          WebView(
            initialUrl:
                "https://alamelumangaimatrimony.com/mobile/privacy-policy",
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
