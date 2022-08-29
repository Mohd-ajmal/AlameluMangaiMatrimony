import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RefundPolicy extends StatefulWidget {
  const RefundPolicy({Key? key}) : super(key: key);

  @override
  State<RefundPolicy> createState() => _RefundPolicyState();
}

bool isProgress = true;

class _RefundPolicyState extends State<RefundPolicy> {
  @override
  Widget build(BuildContext context) {
    late WebViewController _controller;
    return Scaffold(
      body: Stack(
        children: [
          WebView(
            initialUrl:
                "https://alamelumangaimatrimony.com/mobile/refund-policy",
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
