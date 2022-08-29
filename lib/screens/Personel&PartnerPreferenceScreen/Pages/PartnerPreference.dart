// ignore_for_file: file_names, unused_element

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/model/PpBasicInfoModel.dart';
import 'package:matrimony/model/PpProffesionModel.dart';
import 'package:matrimony/model/PpreligionPreference.dart';
import 'package:matrimony/screens/Personel&PartnerPreferenceScreen/Pages/EditPages/PartnerPreferenceEditPage.dart';

import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';

class PartnerPreferenceScreen extends StatefulWidget {
  String? appBar;
  PartnerPreferenceScreen({Key? key, required this.appBar}) : super(key: key);

  @override
  State<PartnerPreferenceScreen> createState() =>
      _PartnerPreferenceScreenState();
}

late String userId;
late String token;
String userIdFromServer = '';

// model classes
late PpBasicInfo _ppBasicInfoModel;
late PpReligionPreference _ppReligionPreference;
late PpProffestionalModel _ppProffesionPreferenceModel;

// Hive
final box = Boxes.getTransaction();

class _PartnerPreferenceScreenState extends State<PartnerPreferenceScreen> {
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
    return userIdFromServer.isNotEmpty
        ? Scaffold(
            appBar: widget.appBar == null
                ? null
                : AppBar(
                    title: const Text("Edit personel info"),
                  ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    basicPreference(),
                    const SizedBox(height: 15.0),
                    proffesionPreference(),
                    const SizedBox(height: 15.0),
                    religionPreference(),
                    const SizedBox(height: 15.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PartnerPreferenceEditPage(
                                      ppBasicInfo: _ppBasicInfoModel,
                                      ppProffestionalModel:
                                          _ppProffesionPreferenceModel,
                                      ppReligionPreference:
                                          _ppReligionPreference,
                                    )));
                      },
                      child: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Edit Partner Prefference',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator.adaptive(),
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
                style: const TextStyle(fontWeight: FontWeight.normal),
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
                style: const TextStyle(fontWeight: FontWeight.normal),
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

  Widget basicPreference() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Basic Preference',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        const SizedBox(
          height: 15.0,
        ),
        details(
            name1: 'Partner Age From',
            value1: _ppBasicInfoModel.data.partnerAgeFrom ?? "Not specified",
            name2: 'Partner Age To',
            value2: _ppBasicInfoModel.data.partnerAgeTo ?? "Not specified"),
        const SizedBox(
          height: 10.0,
        ),
        details(
            name1: 'Partner Height From',
            value1: _ppBasicInfoModel.data.partnerHeightFrom.height.isEmpty
                ? "Not Specified"
                : _ppBasicInfoModel.data.partnerHeightFrom.height,
            name2: 'Partner Height To',
            value2: _ppBasicInfoModel.data.partnerHeightTo.height.isEmpty
                ? "Not Specified"
                : _ppBasicInfoModel.data.partnerHeightTo.height),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Partner Marital Status',
                    style: TextStyle(fontWeight: FontWeight.normal),
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
                    child: Text(_ppBasicInfoModel.data
                            .partnerMartialStatusPrefer.martialStatus.isEmpty
                        ? "Not specified"
                        : _ppBasicInfoModel
                            .data.partnerMartialStatusPrefer.martialStatus),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        // ! Partner Complextion
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Partner Complextion',
                    style: TextStyle(fontWeight: FontWeight.normal),
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
                    child: Text(_ppBasicInfoModel.data.partnerComplexion.isEmpty
                        ? "Not specified"
                        : getComplextionArrayToString(
                            list: _ppBasicInfoModel.data.partnerComplexion)),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        // ! Partner Mother toung
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Partner Mother toung',
                    style: TextStyle(fontWeight: FontWeight.normal),
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
                    child: Text(_ppBasicInfoModel
                            .data.partnerMotherTongue.isEmpty
                        ? "Not specified"
                        : getMotherToungArrayToString(
                            list: _ppBasicInfoModel.data.partnerMotherTongue)),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        // ! Partner country
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Partner Country',
                    style: TextStyle(fontWeight: FontWeight.normal),
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
                    child: Text(_ppBasicInfoModel.data.partnerCountry.isEmpty
                        ? "Not specified"
                        : getCountryArrayToString(
                            list: _ppBasicInfoModel.data.partnerCountry)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget proffesionPreference() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Proffesion Preference',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Partner Education',
                    style: TextStyle(fontWeight: FontWeight.normal),
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
                    child: Text(_ppProffesionPreferenceModel
                            .data.partnerEducation.isEmpty
                        ? "Not specified"
                        : getEducationArrayToString(
                            list: _ppProffesionPreferenceModel
                                .data.partnerEducation)),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        // ! Partner Education details
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Partner Educaiton Details',
                    style: TextStyle(fontWeight: FontWeight.normal),
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
                    child: Text(_ppProffesionPreferenceModel
                            .data.partnerEducationDetails ??
                        "Not specified"),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        // ! Partner job
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Partner Job',
                    style: TextStyle(fontWeight: FontWeight.normal),
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
                    child: Text(_ppProffesionPreferenceModel
                            .data.partnerJob.isEmpty
                        ? "Not specified"
                        : getJobArrayToString(
                            list:
                                _ppProffesionPreferenceModel.data.partnerJob)),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        // ! Partner job details
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Partner Job Details',
                    style: TextStyle(fontWeight: FontWeight.normal),
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
                    child: Text(
                        _ppProffesionPreferenceModel.data.partnerJobDetails ??
                            "Not specified"),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        // ! Partner job country
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Partner Job Country',
                    style: TextStyle(fontWeight: FontWeight.normal),
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
                    child: Text(_ppProffesionPreferenceModel
                            .data.partnerJobCountry.isEmpty
                        ? "Not specified"
                        : getJobCountryArrayToString(
                            list: _ppProffesionPreferenceModel
                                .data.partnerJobCountry)),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        // ! Partner Income
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Partner Income',
                    style: TextStyle(fontWeight: FontWeight.normal),
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
                    child: Text(
                        _ppProffesionPreferenceModel.data.partnerSalary ??
                            'Not specified'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget religionPreference() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Religion Preference',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Partner Religion',
                    style: TextStyle(fontWeight: FontWeight.normal),
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
                    child: Text(_ppReligionPreference
                            .data.partnerReligion.religionName.isEmpty
                        ? "Not specified"
                        : _ppReligionPreference
                            .data.partnerReligion.religionName),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Partner Caste',
                    style: TextStyle(fontWeight: FontWeight.normal),
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
                    child: const Text("Not specified"),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        // ! Partner Rasi
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Partner Rasi',
                    style: TextStyle(fontWeight: FontWeight.normal),
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
                      child: Text(
                        _ppReligionPreference.data.partnerRasi.isEmpty
                            ? "Not specified"
                            : getRasiArrayToString(
                                list: _ppReligionPreference.data.partnerRasi),
                      )),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  getUserData({required context}) async {
    String urlBasic =
        'https://alamelumangaimatrimony.com/api/v1/user-profile/prefference-info-basic/$userId';
    var res = await http.get(
      Uri.parse(urlBasic),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    String urlProffesion =
        'https://alamelumangaimatrimony.com/api/v1/user-profile/prefference-info-professional/$userId';
    var resProffesion = await http.get(
      Uri.parse(urlProffesion),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    String urlReligion =
        'https://alamelumangaimatrimony.com/api/v1/user-profile/prefference-info-religious/$userId';
    var resReligion = await http.get(
      Uri.parse(urlReligion),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    // print(res.body);
    // print(resProffesion.body);
    // print(resReligion.body);
    if (mounted) {
      setState(() {
        _ppBasicInfoModel = ppBasicInfoFromJson(res.body.toString());
        _ppProffesionPreferenceModel =
            ppProffestionalModelFromJson(resProffesion.body.toString());
        _ppReligionPreference =
            ppReligionPreferenceFromJson(resReligion.body.toString());
        userIdFromServer = _ppReligionPreference.data.userId.toString();
      });
    }
    if (res.statusCode == 200) {
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
        ),
      );
    }
  }

  String getComplextionArrayToString({required List list}) {
    String returnType = '';
    for (var element in list) {
      returnType += element['complexion_name'] + '  ';
    }
    return returnType;
  }

  String getMotherToungArrayToString({required List list}) {
    String returnType = '';
    for (var element in list) {
      returnType += element['language_name'] + '  ';
    }
    return returnType;
  }

  String getCountryArrayToString({required List list}) {
    String returnType = '';
    for (var element in list) {
      returnType += element['country_name'] + '  ';
    }
    return returnType;
  }

  String getEducationArrayToString({required List list}) {
    String returnType = '';
    for (var element in list) {
      returnType += element['education_name'] + '  ';
    }
    return returnType;
  }

  String getJobArrayToString({required List list}) {
    String returnType = '';
    for (var element in list) {
      returnType += element['job_name'] + '  ';
    }
    return returnType;
  }

  String getJobCountryArrayToString({required List list}) {
    String returnType = '';
    for (var element in list) {
      returnType += element['country_name'] + '  ';
    }
    return returnType;
  }

  String getRasiArrayToString({required List list}) {
    String returnType = '';
    for (var element in list) {
      returnType += element['rasi_name'] + '  ';
    }
    return returnType;
  }
}
