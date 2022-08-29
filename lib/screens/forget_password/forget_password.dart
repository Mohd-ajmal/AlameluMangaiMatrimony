import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

bool isProgress = true;

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  void dispose() {
    isProgress = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late WebViewController _controller;
    return Scaffold(
      body: Stack(
        children: [
          WebView(
              initialUrl:
                  "https://alamelumangaimatrimony.com/user-password-reset",
              onWebViewCreated: (controller) {
                _controller = controller;
              },
              javascriptMode: JavascriptMode.unrestricted,
              gestureNavigationEnabled: true,
              onPageFinished: (url) => setState(() {
                    isProgress = false;
                  }),
              onPageStarted: (url) {
                log(url);
                if (url == ("https://alamelumangaimatrimony.com/")) {
                  setState(() {
                    Navigator.pop(context);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please check your E-mail")));
                }
              }),
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
