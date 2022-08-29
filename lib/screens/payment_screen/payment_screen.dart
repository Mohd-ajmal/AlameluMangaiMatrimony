import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentGateway1 extends StatefulWidget {
  const PaymentGateway1({Key? key}) : super(key: key);

  @override
  State<PaymentGateway1> createState() => _PaymentGatewayState();
}

// variables
int userId = 0;
late String token;
bool isProgress = true;
late BuildContext _context;

final box = Boxes.getTransaction();

class _PaymentGatewayState extends State<PaymentGateway1> {
  @override
  void initState() {
    super.initState();
    final transaction = box.values.toList().cast<UserModelHive>();
    userId = transaction.last.userId;
    token = transaction.last.token;
  }

  // ignore: unused_field
  late WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            WebView(
              initialUrl:
                  "https://alamelumangaimatrimony.com/login?authId=$userId",
              onWebViewCreated: (controller) {
                _controller = controller;
              },
              javascriptMode: JavascriptMode.unrestricted,
              gestureNavigationEnabled: true,
              onPageStarted: (data) async {
                //print("WebView is onPageStarted $data");
                if (data.contains(
                    "https://alamelumangaimatrimony.com/user/payU-money/paid-success")) {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString('isPayment', 'success');
                  setState(() {
                    Navigator.pushNamedAndRemoveUntil(context, '/profileimage1',
                        (Route<dynamic> route) => false);
                  });
                }
                if (data.contains(
                    "https://alamelumangaimatrimony.com/user/payU-money/failed")) {
                  setState(() {
                    _controller.loadUrl(
                        "https://alamelumangaimatrimony.com/login?authId=$userId");
                  });
                }
              },
              onPageFinished: (url) => setState(() {
                isProgress = false;
                log("WebView is onPageStarted" + url);
              }),
            ),
            isProgress
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(),
          ],
        ),
      ),
    );
  }
}
