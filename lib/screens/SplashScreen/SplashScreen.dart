// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  openSharePreference() async {
    final prefs = await SharedPreferences.getInstance();
    var isRegistered = prefs.getString('isRegistered') ?? 'notRegistered';
    var isProfilePhotoUpdated =
        prefs.getString('isProfileUpdated') ?? 'profileNotUpdated';
    var isPaymentSuccess = prefs.getString('isPayment') ?? 'failure';

    if (isRegistered == 'registered' && isPaymentSuccess != 'success') {
      setState(() {
        Navigator.pushNamedAndRemoveUntil(
            context, '/paymentGateway', (Route<dynamic> route) => false);
      });
    } else if (isRegistered == 'registered' &&
        isPaymentSuccess == 'success' &&
        isProfilePhotoUpdated == 'profileNotUpdated') {
      setState(() {
        Navigator.pushNamedAndRemoveUntil(
            context, '/profileimage1', (Route<dynamic> route) => false);
      });
    } else if (isRegistered == 'registered' &&
        isPaymentSuccess == 'success' &&
        isProfilePhotoUpdated == 'isProfileUpdated') {
      setState(() {
        Navigator.pushNamedAndRemoveUntil(
            context, '/home', (Route<dynamic> route) => false);
      });
    } else {
      setState(() {
        Navigator.pushNamedAndRemoveUntil(
            context, '/signin', (Route<dynamic> route) => false);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => openSharePreference());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/banner.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.black38),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Center(
                child: Text(
                  'Alamelu Mangai \nMatrimony',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'AkagiPro',
                      fontSize: 35),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
