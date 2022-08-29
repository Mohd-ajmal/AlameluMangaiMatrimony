// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/constants/Constants.dart';

import 'package:matrimony/model/FamilyInfoModel.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';

// ignore: must_be_immutable
class FamilyInfoEditPage extends StatefulWidget {
  final FamilyInfoModel _familyInfoModel;
  String updateOrNot;
  FamilyInfoEditPage(this._familyInfoModel, this.updateOrNot, {Key? key})
      : super(key: key);

  @override
  State<FamilyInfoEditPage> createState() => _FamilyInfoEditPageState();
}

late String userId;
late String token;
late String userIdFromServer;
dynamic fatherName;
dynamic fatherJobDetails;
dynamic motherName;
dynamic motherJobDetails;
late String? noOfSiblings;
late String? noOfBrothers;
late String? noOfSisters;
late String? noOfBrothersMarried;
late String? noOfSistersMarried;
dynamic familyStatus;
dynamic siblingDetails;

// visibility
bool isProgress = true;
bool isData = false;

// Hive
final box = Boxes.getTransaction();

// Controller
final fatherNameController = TextEditingController();
final motherNameController = TextEditingController();
final siblingDetailsController = TextEditingController();
final uncleController = TextEditingController();

// family model
late FamilyInfoModel _familyInfoModel;

// lists
List jobDropDownFromServer = [];
List familyDropDownFromServer = [];

// DropDown From server
List<DropdownMenuItem<String>>? get jobDropDown {
  return jobDropDownFromServer.map((e) {
    return DropdownMenuItem(child: Text(e['job']), value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get familyStatusDropDown {
  return familyDropDownFromServer.map((e) {
    return DropdownMenuItem(
        child: Text(e['family_type']), value: e['id'].toString());
  }).toList();
}

class _FamilyInfoEditPageState extends State<FamilyInfoEditPage> {
  Future<void> getSWData() async {
    String url = 'https://alamelumangaimatrimony.com/api/v1/masters/job-list';
    var res = await http.get(Uri.parse(url));
    var resBody = json.decode(res.body);

    String urlFamilyStatus =
        'https://alamelumangaimatrimony.com/api/v1/masters/family-status';
    var resFamilyStatus = await http.get(Uri.parse(urlFamilyStatus));
    var resBodyFamilyStatus = json.decode(resFamilyStatus.body);

    setState(() {
      jobDropDownFromServer = resBody['data'];
      familyDropDownFromServer = resBodyFamilyStatus['data'];

      isProgress = false;
      isData = true;
    });
  }

  @override
  void initState() {
    super.initState();
    final transaction = box.values.toList().cast<UserModelHive>();
    userId = transaction.last.userId.toString();
    token = transaction.last.token;
    getSWData();
    _familyInfoModel = widget._familyInfoModel;
    fatherNameController.text = _familyInfoModel.data.fatherName ?? '';
    motherNameController.text = _familyInfoModel.data.motherName ?? '';
    siblingDetailsController.text = _familyInfoModel.data.siblingDetails ?? '';
    uncleController.text = _familyInfoModel.data.uncleAdress ?? "";
    noOfSiblings = '';
    noOfBrothers = '';
    noOfSisters = '';
    noOfBrothersMarried = '';
    noOfSistersMarried = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Edit Family Info',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
      ),
      body: isProgress
          ? Visibility(
              visible: isProgress,
              child: const Center(child: CircularProgressIndicator.adaptive()),
            )
          : Visibility(
              visible: isData,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
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
                      TextField(
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                        controller: fatherNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'Mother name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                        controller: motherNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'Sibling details',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                        controller: siblingDetailsController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'Parental uncle address',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                        controller: uncleController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'No. of siblings',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 2),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    value: null,
                                    onChanged: (dynamic newValue) {
                                      setState(() {
                                        noOfSiblings = newValue!;
                                      });
                                    },
                                    items: Constants.numbers),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      details(
                          name1: 'Father job details',
                          name2: 'Mother job details',
                          dropdown1: jobDropDown,
                          dropdown2: jobDropDown,
                          value1: null,
                          value2: null,
                          identify1: 'fatherJobDetails',
                          identify2: 'motherJobDetails'),
                      const SizedBox(height: 10.0),
                      details(
                          name1: 'No. of brothers',
                          name2: 'No. of sisters',
                          dropdown1: Constants.numbers,
                          dropdown2: Constants.numbers,
                          value1: null,
                          value2: null,
                          identify1: 'noOfBrothers',
                          identify2: 'noOfSisters'),
                      const SizedBox(height: 10.0),
                      details(
                          name1: 'No of brothers married',
                          name2: 'No of sisters married',
                          dropdown1: Constants.numbers,
                          dropdown2: Constants.numbers,
                          value1: null,
                          value2: null,
                          identify1: 'noOfBrothersMarried',
                          identify2: 'noOfSistersMarried'),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Family status',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                DropdownButtonFormField(
                                    hint: Text(_familyInfoModel
                                        .data.familyStatus.familyType),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 2),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    value: null,
                                    onChanged: (dynamic newValue) {
                                      setState(() {
                                        familyStatus = newValue!;
                                      });
                                    },
                                    items: familyStatusDropDown),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.4,
                            child: TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.4,
                            child: ElevatedButton(
                              onPressed: () {
                                assignVariables();
                              },
                              child: const Text('Done'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget details(
      {required name1,
      required name2,
      required List<DropdownMenuItem<String>>? dropdown1,
      required List<DropdownMenuItem<String>>? dropdown2,
      required String? value1,
      required String? value2,
      required String identify1,
      required String identify2}) {
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
              DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  hint: getValue1(identify1: identify1),
                  value: value1,
                  onChanged: (String? newValue) {
                    setState(() {
                      if (identify1 == 'fatherJobDetails') {
                        fatherJobDetails = newValue;
                      } else if (identify1 == 'noOfBrothersMarried') {
                        noOfBrothersMarried = newValue!;
                      } else if (identify1 == 'noOfBrothers') {
                        noOfBrothers = newValue!;
                      }
                      value1 = newValue!;
                    });
                  },
                  items: dropdown1),
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
              DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  hint: getValue2(identify2: identify2),
                  value: value2,
                  onChanged: (String? newValue) {
                    setState(() {
                      if (identify2 == 'motherJobDetails') {
                        motherJobDetails = newValue;
                      } else if (identify2 == 'noOfSisters') {
                        noOfSisters = newValue!;
                      } else if (identify2 == 'noOfSistersMarried') {
                        noOfSistersMarried = newValue!;
                      }
                      value2 = newValue!;
                    });
                  },
                  items: dropdown2),
            ],
          ),
        ),
      ],
    );
  }

  Widget getValue1({required identify1}) {
    if (identify1 == 'fatherJobDetails') {
      return Text(_familyInfoModel.data.fatherJobDetails ?? '');
    } else if (identify1 == 'noOfBrothersMarried') {
      return Text(_familyInfoModel.data.noOfBrothersMarried ?? '');
    } else if (identify1 == 'noOfBrothers') {
      return Text(_familyInfoModel.data.noOfBrothers ?? '');
    } else {
      return const Text('');
    }
  }

  Widget getValue2({required identify2}) {
    if (identify2 == 'motherJobDetails') {
      return Text(_familyInfoModel.data.motherJobDetails ?? '');
    } else if (identify2 == 'noOfSistersMarried') {
      return Text(_familyInfoModel.data.noOfSistersMarried ?? '');
    } else if (identify2 == 'noOfSisters') {
      return Text(_familyInfoModel.data.noOfSisters ?? '');
    } else {
      return const Text('');
    }
  }

  postUserData({required context}) async {
    final response = await http.post(
        Uri.parse(
            'https://alamelumangaimatrimony.com/api/v1/user-profile/family-info'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          "user_father_name": fatherNameController.text,
          "user_father_job_details":
              fatherJobDetails ?? '${_familyInfoModel.data.fatherJobDetails}',
          "user_mother_name": motherNameController.text,
          "user_mother_job_details":
              motherJobDetails ?? '${_familyInfoModel.data.motherJobDetails}',
          "user_family_status":
              familyStatus ?? '${_familyInfoModel.data.familyStatus.id}',
          "no_of_sibling": noOfSiblings,
          "no_of_brothers": noOfBrothers!.isEmpty
              ? _familyInfoModel.data.noOfBrothers
              : noOfBrothers!,
          "no_of_sisters": noOfSisters!.isEmpty
              ? _familyInfoModel.data.noOfSisters
              : noOfSisters!,
          "no_of_brothers_married": noOfBrothersMarried!.isEmpty
              ? _familyInfoModel.data.noOfBrothersMarried
              : noOfBrothersMarried!,
          "no_of_sisters_married": noOfSistersMarried!.isEmpty
              ? _familyInfoModel.data.noOfSistersMarried
              : noOfSistersMarried!,
          "user_sibling_details": siblingDetailsController.text,
          "paternal_uncle_address": uncleController.text
        });

    // print(familyStatus);
    String responseString = response.body;
    var resBody = json.decode(responseString);
    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resBody['message']),
        ),
      );
      //print(responseString);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resBody['message']),
        ),
      );
      //print(response.statusCode);
    }
  }

  assignVariables() {
    if (fatherNameController.text.isEmpty &&
        _familyInfoModel.data.fatherName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide father name'),
        ),
      );
    } else if (motherNameController.text.isEmpty &&
        _familyInfoModel.data.motherName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide Mother name'),
        ),
      );
    } else if (siblingDetailsController.text.isEmpty &&
        _familyInfoModel.data.siblingDetails == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide sibling details'),
        ),
      );
    } else if (uncleController.text.isEmpty &&
        _familyInfoModel.data.uncleAdress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide uncle address'),
        ),
      );
    } else if (noOfSiblings!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide number of siblings'),
        ),
      );
    } else if (fatherJobDetails == null &&
        _familyInfoModel.data.fatherJobDetails == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide father job details'),
        ),
      );
    } else if (motherJobDetails == null &&
        _familyInfoModel.data.motherJobDetails == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide mother job details'),
        ),
      );
    } else if (familyStatus == null &&
        _familyInfoModel.data.familyStatus.familyType.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide family status'),
        ),
      );
    } else {
      var noOfSiblingsInt = int.parse(noOfSiblings!);
      var noOfBrothersInt = int.parse(noOfBrothers!.isEmpty
          ? _familyInfoModel.data.noOfBrothers!
          : noOfBrothers!);
      var noOfSistersInt = int.parse(noOfSisters!.isEmpty
          ? _familyInfoModel.data.noOfSisters!
          : noOfSisters!);
      var noOfSisterMarriedInt = int.parse(noOfSistersMarried!.isEmpty
          ? _familyInfoModel.data.noOfSistersMarried!
          : noOfSistersMarried!);
      var noOfBrothersMarriedInt = int.parse(noOfBrothersMarried!.isEmpty
          ? _familyInfoModel.data.noOfBrothersMarried!
          : noOfBrothersMarried!);
      var totalSiblings = noOfBrothersInt + noOfSistersInt;

      if (noOfSiblingsInt == 0 &&
          noOfBrothersInt == 0 &&
          noOfSistersInt == 0 &&
          noOfBrothersMarriedInt == 0 &&
          noOfSisterMarriedInt == 0) {
        postUserData(context: context);
      } else if (noOfSiblingsInt > totalSiblings ||
          noOfSiblingsInt < totalSiblings ||
          noOfSiblingsInt < noOfBrothersMarriedInt ||
          noOfSiblingsInt < noOfSisterMarriedInt ||
          noOfBrothersInt < noOfBrothersMarriedInt ||
          noOfSistersInt < noOfSisterMarriedInt) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'You provided number of siblings as $noOfSiblingsInt\nBut number of brothers is $noOfBrothersInt\nnumber of sisters is $noOfSistersInt\nNumber of married brothers $noOfBrothersMarriedInt\nNumber of married sisters $noOfSisterMarriedInt'),
          ),
        );
      } else {
        postUserData(context: context);
      }
    }
  }
}
