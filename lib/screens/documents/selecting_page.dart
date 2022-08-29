import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:matrimony/model/BasicInfoUser.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';
import 'package:matrimony/screens/documents/aadhar_upload.dart';
import 'package:matrimony/screens/documents/college_tc_upload.dart';
import 'package:matrimony/screens/documents/medical_certificate.dart';
import 'package:matrimony/screens/documents/tenth_certificate.dart';
import 'package:matrimony/screens/documents/twelth_upload.dart';

class SelectingPage extends StatefulWidget {
  const SelectingPage({Key? key}) : super(key: key);

  @override
  State<SelectingPage> createState() => _SelectingPageState();
}

late BasicInfoUserModel _basicInfoUser;

late String userId;
late String token;

String aadhar = "0";
String tenthCertificate = "0";
String twelthCertificate = "0";
String collegeTc = "0";
String medicalCertificate = "0";

// Hive
final box = Boxes.getTransaction();

class _SelectingPageState extends State<SelectingPage> {
  @override
  void initState() {
    super.initState();
    final transaction = box.values.toList().cast<UserModelHive>();
    userId = transaction.last.userId.toString();
    token = transaction.last.token;
    getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                if (tenthCertificate == "1") {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("You already Uploaded 10th certificate")));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TenthUpload()));
                }
              },
              child: Card(
                child: ListTile(
                  title: const Text("1. 10th certificate"),
                  subtitle: Text(
                    tenthCertificate == "0" ? "Not uploaded" : "Uploaded",
                    style: TextStyle(
                        color: tenthCertificate == "0"
                            ? Colors.red
                            : Colors.green),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                if (twelthCertificate == "1") {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("You already Uploaded 12th certificate")));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TwelthUpload()));
                }
              },
              child: Card(
                child: ListTile(
                  title: const Text("2. 12th certificate"),
                  subtitle: Text(
                    twelthCertificate == "0" ? "Not uploaded" : "Uploaded",
                    style: TextStyle(
                        color: twelthCertificate == "0"
                            ? Colors.red
                            : Colors.green),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                if (collegeTc == "1") {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text("You already uploaded college certificate")));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CollegeTc()));
                }
              },
              child: Card(
                child: ListTile(
                  title: const Text("3. College Tc"),
                  subtitle: Text(
                    collegeTc == "0" ? "Not uploaded" : "Uploaded",
                    style: TextStyle(
                        color: collegeTc == "0" ? Colors.red : Colors.green),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                if (aadhar == "1") {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("You already Uploaded Aadhar")));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AadharUpload()));
                }
              },
              child: Card(
                child: ListTile(
                  title: const Text("4. Aadhar"),
                  subtitle: Text(
                    aadhar == "0" ? "Not uploaded" : "Uploaded",
                    style: TextStyle(
                        color: aadhar == "0" ? Colors.red : Colors.green),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                if (medicalCertificate == "1") {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text("You already Uploaded medical ceritificate")));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MedicalCertificate()));
                }
              },
              child: Card(
                child: ListTile(
                  title: const Text("5. Medical certificate"),
                  subtitle: Text(
                    medicalCertificate == "0" ? "Not uploaded" : "Uploaded",
                    style: TextStyle(
                        color: medicalCertificate == "0"
                            ? Colors.red
                            : Colors.green),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getUserData({required context}) async {
    String url =
        'https://alamelumangaimatrimony.com/api/v1/user-profile/basic-info/$userId';
    var res = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    //print(res.statusCode);
    if (res.statusCode == 200) {
      _basicInfoUser = basicInfoUserModelFromJson(res.body);
      log(_basicInfoUser.data.medicalCertificate);
      if (mounted) {
        setState(() {
          tenthCertificate = _basicInfoUser.data.tenthMarkSheetUploaded;
          twelthCertificate = _basicInfoUser.data.twelthMarkSheetUploaded;
          collegeTc = _basicInfoUser.data.clgTcIsUploaded;
          aadhar = _basicInfoUser.data.adhardCardImageIsUploaded;
          medicalCertificate = _basicInfoUser.data.medicalCertificate;
          // print(tenthCertificate +
          //     twelthCertificate +
          //     collegeTc +
          //     aadhar +
          //     medicalCertificate);
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
        ),
      );
    }
  }
}
