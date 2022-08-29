// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/model/FamilyInfoModel.dart';

import 'package:matrimony/screens/Personel&PartnerPreferenceScreen/Pages/EditPages/FamilyInfoEditPage.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';

class FamilyInfo extends StatefulWidget {
  String? appBar;
  FamilyInfo({Key? key, required this.appBar}) : super(key: key);

  @override
  State<FamilyInfo> createState() => _FamilyInfoState();
}

late String userId;
late String token;
late String userIdFromServer;
dynamic fatherName;
dynamic fatherJobDetails;
dynamic motherName;
dynamic motherJobDetails;
late String noOfBrothers;
late String noOfSisters;
late String noOfBrothersMarried;
late String noOfSistersMarried;
late String familyStatus;
dynamic siblingDetails;
late String uncleAdress;

// visibility
bool isProgress = true;
bool isData = false;

// Hive
final box = Boxes.getTransaction();

// family model
late FamilyInfoModel _familyInfoModel;

class _FamilyInfoState extends State<FamilyInfo> {
  @override
  void initState() {
    super.initState();
    final transaction = box.values.toList().cast<UserModelHive>();
    userId = transaction.last.userId.toString();
    token = transaction.last.token;
    userIdFromServer = '';
    noOfBrothers = '';
    noOfSisters = '';
    noOfBrothersMarried = '';
    noOfSistersMarried = '';
    familyStatus = '';
    uncleAdress = '';
    getUserData(context: context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return userIdFromServer.isEmpty
        ? const Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()))
        : Scaffold(
            appBar: widget.appBar == null
                ? null
                : AppBar(
                    title: const Text("Edit family Info"),
                  ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Father name',
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
                      child: Text(fatherName ?? 'Not specified'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Father job details',
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
                      child: Text(fatherJobDetails ?? 'Not specified'),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      'Mother name',
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
                      child: Text(motherName ?? 'Not specified'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Mother job details',
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
                      child: Text(motherJobDetails ?? 'Not specified'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Family status',
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
                      child: Text(familyStatus.isEmpty
                          ? 'Not specified'
                          : familyStatus),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Sibling status',
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
                      child: Text(siblingDetails ?? 'Not specified'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Parental uncle address',
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
                          uncleAdress.isEmpty ? 'Not specified' : uncleAdress),
                    ),
                    const SizedBox(height: 10.0),
                    details(
                        name1: 'No of brothers',
                        value1: noOfBrothers,
                        name2: 'No of sisters',
                        value2: noOfSisters),
                    const SizedBox(height: 10.0),
                    details(
                        name1: 'No of brothers married',
                        value1: noOfBrothersMarried,
                        name2: 'No of sisters married',
                        value2: noOfSistersMarried),
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FamilyInfoEditPage(
                                    _familyInfoModel,
                                    _familyInfoModel.data.fatherName != null
                                        ? 'updated'
                                        : 'notUpdated')));
                      },
                      child: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Edit Family Info',
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

  Widget details(
      {required name1, required value1, required name2, required value2}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name1,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Container(
                height: 40.0,
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.black12, width: 2),
                ),
                child: Text(value1),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name2,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Container(
                height: 40.0,
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.black12, width: 2),
                ),
                child: Text(value2),
              ),
            ],
          ),
        ),
      ],
    );
  }

  getUserData({required context}) async {
    String url =
        'https://alamelumangaimatrimony.com/api/v1/user-profile/family-info/$userId';
    var res = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    //print(res.statusCode);
    if (res.statusCode == 200) {
      _familyInfoModel = familyInfoModelFromJson(res.body.toString());
      if (mounted) {
        setState(() {
          userIdFromServer = _familyInfoModel.data.userId;
          fatherName = _familyInfoModel.data.fatherName;
          fatherJobDetails = _familyInfoModel.data.fatherJobDetails;
          motherName = _familyInfoModel.data.motherName;
          motherJobDetails = _familyInfoModel.data.motherJobDetails;
          familyStatus = _familyInfoModel.data.familyStatus.familyType;
          siblingDetails = _familyInfoModel.data.siblingDetails;
          noOfBrothers = _familyInfoModel.data.noOfBrothers ?? "";
          noOfSisters = _familyInfoModel.data.noOfSisters ?? "";
          noOfBrothersMarried = _familyInfoModel.data.noOfBrothersMarried ?? "";
          noOfSistersMarried = _familyInfoModel.data.noOfSistersMarried ?? "";
          uncleAdress = _familyInfoModel.data.uncleAdress ?? "Not specified";
          isProgress = false;
          isData = true;
          //print(_familyInfoModel.data.noOfBrothers);
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
