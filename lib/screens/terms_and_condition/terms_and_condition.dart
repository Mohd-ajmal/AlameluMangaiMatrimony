import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({Key? key}) : super(key: key);

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

bool isProgress = true;

class _TermsAndConditionState extends State<TermsAndCondition> {
  @override
  Widget build(BuildContext context) {
    late WebViewController _controller;
    return Scaffold(
      body: Stack(
        children: [
          WebView(
            initialUrl:
                "https://alamelumangaimatrimony.com/mobile/terms-and-conditions",
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
