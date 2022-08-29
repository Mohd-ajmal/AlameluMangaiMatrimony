// ignore_for_file: file_names, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:matrimony/screens/Personel&PartnerPreferenceScreen/Personel&ParnerPreference.dart';
import 'package:matrimony/screens/ProfileScreen/shorlistScreen/ShorlistScreen.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';
import 'package:matrimony/screens/about_us/about_us.dart';
import 'package:matrimony/screens/privacy_policy/privacy_policy.dart';
import 'package:matrimony/screens/refund_policy/refund_policy.dart';
import 'package:matrimony/screens/terms_and_condition/terms_and_condition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

DateTime? currentBackPressTime;

class _ProfileScreenState extends State<ProfileScreen> {
  final box = Boxes.getTransaction();

  String token = '';
  String userName = '';
  int userId = 0;

  @override
  Widget build(BuildContext context) {
    if (box.isOpen) {
      final transaction = box.values.toList().cast<UserModelHive>();
      token = transaction.last.token;
      userName = transaction.last.username;
      userId = transaction.last.userId;
    }
    //final transaction = box.values.toList().cast<UserModelHive>();

    return WillPopScope(
      onWillPop: onWillPop,
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   height: 100.0,
                  //   width: 100.0,
                  //   decoration: BoxDecoration(
                  //     image: const DecorationImage(
                  //       fit: BoxFit.cover,
                  //       image: AssetImage('assets/images/SummaModel.jpeg'),
                  //     ),
                  //     borderRadius: BorderRadius.circular(7.0),
                  //   ),
                  // ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        const SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          "userId - $userId",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                          'Purchased user',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   child: const Text('Upgrade Plan'),
                        //   style: ElevatedButton.styleFrom(
                        //       primary: Colors.green[800]),
                        // ),
                      ], // UserProfile Photo
                    ),
                  ),
                ], // ProfileRowWidget
              ),
            ),
            const SizedBox(height: 10),
            profileBottomWidgets(
                icon: const Icon(
                  Icons.person_outline,
                  size: 30.0,
                ),
                name: 'My Profile',
                context: context),
            // profileBottomWidgets(
            //     icon: const Icon(
            //       Icons.star_outline,
            //       size: 30.0,
            //     ),
            //     name: 'Shortlisted',
            //     context: context),
            profileBottomWidgets(
                icon: const Icon(
                  Icons.privacy_tip_outlined,
                  size: 30.0,
                ),
                name: 'Privacy Policy',
                context: context),
            profileBottomWidgets(
                icon: const Icon(
                  Icons.document_scanner_outlined,
                  size: 30.0,
                ),
                name: 'About Us',
                context: context),
            profileBottomWidgets(
                icon: const Icon(
                  Icons.notes_outlined,
                  size: 30.0,
                ),
                name: 'Terms & Condition',
                context: context),
            profileBottomWidgets(
                icon: const Icon(
                  Icons.money,
                  size: 30.0,
                ),
                name: 'Refund Policy',
                context: context),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please wait'),
                  ),
                );
                postUserData(context: context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout_outlined,
                          color: Colors.green[800],
                          size: 30.0,
                        ),
                        const SizedBox(
                          width: 25.0,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[800]),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 15.0,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileBottomWidgets(
      {required Icon icon,
      required String name,
      required BuildContext context}) {
    return Material(
      child: InkWell(
        onTap: () {
          if (name == 'My Profile') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PersonelAndPartnerPreference(),
              ),
            );
          } else if (name == 'Privacy Policy') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PrivacyPolicy(),
              ),
            );
          } else if (name == 'Terms & Condition') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TermsAndCondition(),
              ),
            );
          } else if (name == 'Shortlisted') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ShortlistScreen(),
              ),
            );
          } else if (name == 'About Us') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AboutUs(),
              ),
            );
          } else if (name == 'Refund Policy') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RefundPolicy(),
              ),
            );
          } else if (name == 'Logout') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ShortlistScreen(),
              ),
            );
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                children: [
                  icon,
                  const SizedBox(
                    width: 25.0,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 15.0,
              ),
            )
          ],
        ),
      ),
    );
  }

  postUserData({required context}) async {
    final response = await http.post(
      Uri.parse('https://alamelumangaimatrimony.com/api/v1/users/logout-user'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    //print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 204) {
      box.deleteFromDisk();
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      setState(() {
        Navigator.pushNamedAndRemoveUntil(
            context, '/', (Route<dynamic> route) => false);
      });

      //print(responseString);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong, please try again'),
        ),
      );
      //print(response.statusCode);
    }
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Press back again to exit",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }
}
