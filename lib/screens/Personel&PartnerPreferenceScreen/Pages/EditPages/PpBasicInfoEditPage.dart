// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/constants/Constants.dart';
import 'package:matrimony/model/PpBasicInfoModel.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class PpBasicInfoEditPage extends StatefulWidget {
  PpBasicInfo ppBasicInfo;
  PpBasicInfoEditPage({Key? key, required this.ppBasicInfo}) : super(key: key);

  @override
  State<PpBasicInfoEditPage> createState() => _PpBasicInfoEditPageState();
}

// Hive
final box = Boxes.getTransaction();
late String userId;
late String token;

// visibility check
bool progressBar = true;
bool container = false;

// selected values
List selectedLanguage = [];
List selectedComplextion = [];
List selectedCountry = [];

// from server
List heightDropdownFromServer = [];
List statusDropdownFromServer = [];
List languageDropdownFromServer = [];
List complextionDropdownFromServer = [];
List countryDropDownFromServer = [];

// variables
String ageFrom = '';
String ageTo = '';
String heightFrom = '';
String heightTo = '';
String maritalStatus = '';

List<DropdownMenuItem<String>>? get heightDropdown {
  return heightDropdownFromServer.map((e) {
    return DropdownMenuItem(
        child: Text(e['height'], style: const TextStyle(fontSize: 12.0)),
        value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get statusDropDown {
  return statusDropdownFromServer.map((e) {
    return DropdownMenuItem(
        child: Text(e['martial_status']), value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get languageDropdown {
  return languageDropdownFromServer.map((e) {
    return DropdownMenuItem(
        child: Text(e['language']), value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get complextionDropdown {
  return complextionDropdownFromServer.map((e) {
    return DropdownMenuItem(
        child: Text(e['complexion']), value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get countryDropDown {
  return countryDropDownFromServer.map((e) {
    return DropdownMenuItem(
        child: Text(e['country']), value: e['id'].toString());
  }).toList();
}

class _PpBasicInfoEditPageState extends State<PpBasicInfoEditPage> {
  Future<void> getSWData() async {
    String url =
        'https://alamelumangaimatrimony.com/api/v1/masters/country-list';
    var res = await http.get(Uri.parse(url));
    var resBody = json.decode(res.body);

    String urlHeight =
        'https://alamelumangaimatrimony.com/api/v1/masters/height';
    var resHeight = await http.get(Uri.parse(urlHeight));
    var resBodyHeight = json.decode(resHeight.body);

    String urlStatus =
        'https://alamelumangaimatrimony.com/api/v1/masters/m-status';
    var resStatus = await http.get(Uri.parse(urlStatus));
    var resStatusBody = json.decode(resStatus.body);

    String urlLanguage =
        'https://alamelumangaimatrimony.com/api/v1/masters/language';
    var resLanguage = await http.get(Uri.parse(urlLanguage));
    var resLanguageBody = json.decode(resLanguage.body);

    String urlComplexion =
        'https://alamelumangaimatrimony.com/api/v1/masters/complexion';
    var resComplexion = await http.get(Uri.parse(urlComplexion));
    var resComplexionbody = json.decode(resComplexion.body);

    if (mounted) {
      setState(() {
        heightDropdownFromServer = resBodyHeight['data'];
        statusDropdownFromServer = resStatusBody['data'];
        languageDropdownFromServer = resLanguageBody['data'];
        complextionDropdownFromServer = resComplexionbody['data'];
        countryDropDownFromServer = resBody['data'];
        container = true;
        progressBar = false;
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
  }

  @override
  Widget build(BuildContext context) {
    return progressBar == false
        ? SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  numberWidgetWithFromTo(
                      category: 'Partner Age',
                      number: '01',
                      dropdown: Constants.dropdownItems,
                      value: null),
                  const SizedBox(
                    height: 10.0,
                  ),
                  numberWidgetWithFromTo(
                      category: 'Partner Height',
                      number: '02',
                      dropdown: heightDropdown,
                      value: null),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Marital status',
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
                                hint: Text(widget.ppBasicInfo.data
                                    .partnerMartialStatusPrefer.martialStatus),
                                value: null,
                                onChanged: (dynamic newValue) {
                                  setState(() {
                                    maritalStatus = newValue.toString();
                                  });
                                },
                                items: statusDropDown),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Partner Language',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.black12, width: 2),
                    ),
                    child: MultiSelectDialogField(
                      buttonText: Text(widget
                              .ppBasicInfo.data.partnerMotherTongue.isEmpty
                          ? "Select Language Preference"
                          : getMotherToungArrayToString(
                              list:
                                  widget.ppBasicInfo.data.partnerMotherTongue)),
                      items: languageDropdownFromServer
                          .map((e) => MultiSelectItem(e['id'], e['language']))
                          .toList(),
                      listType: MultiSelectListType.CHIP,
                      onConfirm: (values) {
                        selectedLanguage = values;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Partner Complexion',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.black12, width: 2),
                    ),
                    child: MultiSelectDialogField(
                      buttonText: Text(widget
                              .ppBasicInfo.data.partnerMotherTongue.isEmpty
                          ? "Select Complexion Preference"
                          : getComplextionArrayToString(
                              list: widget.ppBasicInfo.data.partnerComplexion)),
                      items: complextionDropdownFromServer
                          .map((e) => MultiSelectItem(e['id'], e['complexion']))
                          .toList(),
                      listType: MultiSelectListType.CHIP,
                      onConfirm: (values) {
                        selectedComplextion = values;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Partner Country',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.black12, width: 2),
                    ),
                    child: MultiSelectDialogField(
                      buttonText: Text(widget
                              .ppBasicInfo.data.partnerCountry.isEmpty
                          ? "Select Country Preference"
                          : getCountryArrayToString(
                              list: widget.ppBasicInfo.data.partnerCountry)),
                      items: countryDropDownFromServer
                          .map((e) => MultiSelectItem(e['id'], e['country']))
                          .toList(),
                      listType: MultiSelectListType.CHIP,
                      onConfirm: (values) {
                        selectedCountry = values;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
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
                            postUserData(context: context);
                          },
                          child: const Text('Done'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator.adaptive(),
          );
  }

  Widget numberWidgetWithFromTo(
      {required String category,
      required String number,
      required List<DropdownMenuItem<String>>? dropdown,
      required String? value}) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.black26, width: 2),
              ),
              child: Center(
                child: Text(
                  number,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              category,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'From',
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  validator: (value) =>
                      value == null ? "Select a country" : null,
                  hint: Text(getHintStringFrom(nameRequred: category)),
                  value: value,
                  onChanged: (String? newValue) {
                    setState(() {
                      if (category == "Partner Age") {
                        ageFrom = newValue!;
                      } else if (category == "Partner Height") {
                        heightFrom = newValue!;
                      }
                      value = newValue!;
                    });
                  },
                  items: dropdown),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'To',
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  validator: (value) =>
                      value == null ? "Select a Height" : null,
                  hint: Text(getHintStringTo(nameRequred: category)),
                  value: value,
                  onChanged: (String? newValue) {
                    setState(() {
                      if (category == "Partner Age") {
                        ageTo = newValue!;
                      } else if (category == "Partner Height") {
                        heightTo = newValue!;
                      }
                      value = newValue!;
                    });
                  },
                  items: dropdown),
            ),
          ],
        ),
      ],
    );
  }

  String getHintStringFrom({required nameRequred}) {
    if (nameRequred == 'Partner Age') {
      return widget.ppBasicInfo.data.partnerAgeFrom ?? "";
    } else if (nameRequred == 'Partner Height') {
      return widget.ppBasicInfo.data.partnerHeightFrom.height;
    }
    return "";
  }

  String getHintStringTo({required nameRequred}) {
    if (nameRequred == 'Partner Age') {
      return widget.ppBasicInfo.data.partnerAgeTo ?? "";
    } else if (nameRequred == 'Partner Height') {
      return widget.ppBasicInfo.data.partnerHeightTo.height;
    }
    return "";
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

  assignVariables() {
    double fromAgedouble = double.parse(
        ageFrom.isEmpty ? widget.ppBasicInfo.data.partnerAgeFrom : ageFrom);
    double toAgedouble = double.parse(
        ageTo.isEmpty ? widget.ppBasicInfo.data.partnerAgeTo : ageTo);

    if (ageFrom.isEmpty && widget.ppBasicInfo.data.partnerAgeFrom == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide From Age'),
        ),
      );
    } else if (ageTo.isEmpty && widget.ppBasicInfo.data.partnerAgeTo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide To Age'),
        ),
      );
    } else if (fromAgedouble > toAgedouble) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('From age must be smaller than to age'),
        ),
      );
    } else if (heightFrom.isEmpty &&
        widget.ppBasicInfo.data.partnerHeightFrom.height.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide From Height'),
        ),
      );
    } else if (heightTo.isEmpty &&
        widget.ppBasicInfo.data.partnerHeightTo.height.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide To Height'),
        ),
      );
    } else if (maritalStatus.isEmpty &&
        widget.ppBasicInfo.data.partnerMartialStatusPrefer.martialStatus
            .isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide Marital status'),
        ),
      );
    } else if (selectedLanguage.isEmpty &&
        widget.ppBasicInfo.data.partnerMotherTongue.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide Prefering language'),
        ),
      );
    } else if (selectedComplextion.isEmpty &&
        widget.ppBasicInfo.data.partnerComplexion.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide Prefering complexion'),
        ),
      );
    } else if (selectedCountry.isEmpty &&
        widget.ppBasicInfo.data.partnerCountry.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide Prefering country'),
        ),
      );
    } else {
      //print("came");
      postUserData(context: context);
    }
  }

  postUserData({required context}) async {
    var resBody1 = {};
    resBody1['partner_age_from'] =
        ageFrom.isEmpty ? widget.ppBasicInfo.data.partnerAgeFrom : ageFrom;
    resBody1['partner_age_to'] =
        ageTo.isEmpty ? widget.ppBasicInfo.data.partnerAgeTo : ageTo;
    resBody1['partner_height_to'] = heightTo.isEmpty
        ? widget.ppBasicInfo.data.partnerHeightTo.id
        : heightTo;
    resBody1['partner_height_from'] = heightFrom.isEmpty
        ? widget.ppBasicInfo.data.partnerHeightFrom.id
        : heightFrom;
    resBody1['partner_martial_status'] = maritalStatus.isEmpty
        ? widget.ppBasicInfo.data.partnerMartialStatusPrefer.id
        : maritalStatus;
    resBody1['partner_complexion'] = selectedComplextion.isEmpty
        ? widget.ppBasicInfo.data.partnerComplexion.map((e) => e['id']).toList()
        : selectedComplextion;
    resBody1['partner_mother_tongue'] = selectedLanguage.isEmpty
        ? widget.ppBasicInfo.data.partnerMotherTongue
            .map((e) => e['id'])
            .toList()
        : selectedLanguage;
    resBody1['partner_country'] = selectedCountry.isEmpty
        ? widget.ppBasicInfo.data.partnerCountry.map((e) => e['id']).toList()
        : selectedCountry;
    var js = json.encode(resBody1);

    // print(js.runtimeType);

    final response = await http.post(
      Uri.parse(
          'https://alamelumangaimatrimony.com/api/v1/user-profile/prefference-info-basic'),
      headers: {
        "content-type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: js,
    );

    String responseString = response.body;
    var resBody = json.decode(responseString);
    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resBody['message']),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resBody['errors'].toString()),
        ),
      );
    }
  }
}
