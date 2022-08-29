import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/model/proffesion_model.dart';
import 'package:matrimony/screens/Personel&PartnerPreferenceScreen/Pages/EditPages/proffesion_edit_page.dart';

import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';

class ProffesionPage2 extends StatefulWidget {
  String? appbar;
  ProffesionPage2({Key? key, required this.appbar}) : super(key: key);

  @override
  State<ProffesionPage2> createState() => _ProffesionPage2State();
}

ProffesionModel? _proffesionData;

// variables
List selectEducationProffesion = [];
String userEducationDetails = '';
String userJob = '';
String userJobDetails = '';
String userWorkingCountry = '';
String userWorkingState = '';
String userWorkingCity = '';
String userAnnualIncome = '';

// Hive
final box = Boxes.getTransaction();
late String userId;
late String token;

// from server
List<dynamic> educationDropDownFromServer1 = [];

class _ProffesionPage2State extends State<ProffesionPage2> {
  Future<void> getSWData() async {
    String url =
        'https://alamelumangaimatrimony.com/api/v1/masters/education-list';
    var res = await http.get(Uri.parse(url));
    var resBody = json.decode(res.body);

    if (mounted) {
      setState(() {
        educationDropDownFromServer1 = resBody['data'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final transaction = box.values.toList().cast<UserModelHive>();
    userId = transaction.last.userId.toString();
    token = transaction.last.token;
    getSWData();
    getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appbar == null
          ? null
          : AppBar(
              title: const Text("Proffesion Info"),
            ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Education',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: 40.0,
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.black12, width: 2),
                ),
                child: Text(selectEducationProffesion.isEmpty
                    ? 'Not specified'
                    : getEducationArrayToString(
                        list: selectEducationProffesion)),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Education details',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: 40.0,
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.black12, width: 2),
                ),
                child: Text(userEducationDetails.isEmpty
                    ? 'Not specified'
                    : userEducationDetails),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Job',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: 40.0,
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.black12, width: 2),
                ),
                child: Text(userJob.isEmpty ? 'Not specified' : userJob),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Job Details',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: 40.0,
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.black12, width: 2),
                ),
                child: Text(
                    userJobDetails.isEmpty ? 'Not specified' : userJobDetails),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Working country',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: 40.0,
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.black12, width: 2),
                ),
                child: Text(userWorkingCountry.isEmpty
                    ? 'Not specified'
                    : userWorkingCountry),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Working state',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: 40.0,
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.black12, width: 2),
                ),
                child: Text(userWorkingState.isEmpty
                    ? 'Not specified'
                    : userWorkingState),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Working city',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: 40.0,
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.black12, width: 2),
                ),
                child: Text(userWorkingCity.isEmpty
                    ? 'Not specified'
                    : userWorkingCity),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Annual income',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: 40.0,
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.black12, width: 2),
                ),
                child: Text(userAnnualIncome.isEmpty
                    ? 'Not specified'
                    : userAnnualIncome),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProffesionEditPage2(_proffesionData)));
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Edit Proffesion Info',
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getEducationArrayToString({required List list}) {
    String returnType = '';
    for (var element in list) {
      returnType += element.educationName + '  ';
    }
    return returnType;
  }

  getUserData({required context}) async {
    String url =
        'https://alamelumangaimatrimony.com/api/v1/user-profile/professional-info/$userId';
    var res = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    //print(res.body);
    if (res.statusCode == 200) {
      _proffesionData = proffesionModelFromJson(res.body);
      if (mounted) {
        setState(() {
          _proffesionData = proffesionModelFromJson(res.body);
          selectEducationProffesion = _proffesionData!.data.education ?? [];
          userEducationDetails =
              _proffesionData!.data.educationDetails ?? "Not specified";
          userJob = _proffesionData!.data.job!.job ?? "Not specified";
          userJobDetails = _proffesionData!.data.jobDetails ?? "Not specified";
          userWorkingCountry =
              _proffesionData!.data.jobCountry!.country ?? "Not specified";
          userWorkingState =
              _proffesionData!.data.jobState!.state ?? "Not specified";
          userWorkingCity =
              _proffesionData!.data.jobCity!.city ?? "Not specified";
          userAnnualIncome =
              _proffesionData!.data.annualIncome ?? "Not specified";
        });
        //print(_proffesionData.data.education[0].educationName);
      }

      //print(country.isEmpty ? 'notspecified' : 'summa');
    } else if (res.statusCode == 500) {
      log(res.statusCode.toString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
        ),
      );
    }
  }
}
