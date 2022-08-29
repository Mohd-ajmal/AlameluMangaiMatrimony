// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:matrimony/model/PpreligionPreference.dart';

import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class PpReligiousEditPage extends StatefulWidget {
  PpReligionPreference ppReligionPreference;
  PpReligiousEditPage(this.ppReligionPreference, {Key? key}) : super(key: key);

  @override
  State<PpReligiousEditPage> createState() => _PpReligiousEditPageState();
}

// variables
List selectedRasi = [];
String religion = '';
String caste = '';

// Hive
final box = Boxes.getTransaction();
late String userId;
late String token;

// selected items
List selectedPartnerRasi = [];

// from server
List rasiFromServer = [];
List religionFromServer = [];
List casteFromServer = [];

// DropDown From server
List<DropdownMenuItem<String>>? get religionDropDown1 {
  return religionFromServer.map((e) {
    return DropdownMenuItem(
        child: Text(e['religion_name']), value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get casteDropDown {
  return casteFromServer.map((e) {
    return DropdownMenuItem(
        child: Text(e['caste_name']), value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get rasiDropDown {
  return rasiFromServer.map((e) {
    return DropdownMenuItem(child: Text(e['rasi']), value: e['id'].toString());
  }).toList();
}

// visibility check
bool isProgress2 = true;
bool isData = false;

class _PpReligiousEditPageState extends State<PpReligiousEditPage> {
  Future<void> getSWData() async {
    String url = 'https://alamelumangaimatrimony.com/api/v1/masters/religion';
    var res = await http.get(Uri.parse(url));
    var resBody = json.decode(res.body);

    String urlCaste = 'https://alamelumangaimatrimony.com/api/v1/masters/caste';
    var resCaste = await http.get(Uri.parse(urlCaste));
    var resBodyCaste = json.decode(resCaste.body);

    String urlRasi =
        'https://alamelumangaimatrimony.com/api/v1/masters/rasi-list';
    var resRasi = await http.get(Uri.parse(urlRasi));
    var resBodyRasi = json.decode(resRasi.body);

    setState(() {
      religionFromServer = resBody['data'];
      casteFromServer = resBodyCaste['data'];
      rasiFromServer = resBodyRasi['data'];
      isProgress2 = false;
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
  }

  @override
  Widget build(BuildContext context) {
    return isProgress2 == false
        ? Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Partner Religion',
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
                              hint: Text(widget.ppReligionPreference.data
                                  .partnerReligion.religionName),
                              value: null,
                              onChanged: (dynamic value) {
                                setState(() {
                                  religion = value;
                                });
                              },
                              items: religionDropDown1),
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
                              hint: Text(widget
                                      .ppReligionPreference.data.partnerCaste ??
                                  "Not specified"),
                              value: null,
                              onChanged: (dynamic value) {
                                setState(() {
                                  caste = value;
                                });
                              },
                              items: casteDropDown),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.black12, width: 2),
                  ),
                  child: MultiSelectDialogField(
                    buttonText: Text(widget
                            .ppReligionPreference.data.partnerRasi.isEmpty
                        ? "Not specified"
                        : getRasiArrayToString(
                            list:
                                widget.ppReligionPreference.data.partnerRasi)),
                    items: rasiFromServer
                        .map((e) => MultiSelectItem(e['id'], e['rasi']))
                        .toList(),
                    listType: MultiSelectListType.CHIP,
                    onConfirm: (values) {
                      selectedRasi = values;
                    },
                  ),
                ),
                const Spacer(),
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
          )
        : const Center(child: CircularProgressIndicator.adaptive());
  }

  postUserData({required context}) async {
    var resBody1 = {};
    resBody1['partner_religion'] = religion.isEmpty
        ? widget.ppReligionPreference.data.partnerReligion
        : religion;
    resBody1['partner_caste'] = 0;
    caste.isEmpty ? widget.ppReligionPreference.data.partnerCaste : caste;
    resBody1['partner_rasi'] = [0, 1];
    selectedPartnerRasi.isEmpty
        ? widget.ppReligionPreference.data.partnerRasi
            .map((e) => e['id'])
            .toList()
        : selectedRasi;

    var js = json.encode(resBody1);
    // print(js);
    final response = await http.post(
        Uri.parse(
            'https://alamelumangaimatrimony.com/api/v1/user-profile/prefference-info-religious'),
        headers: {
          "content-type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: js);

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

  String getRasiArrayToString({required List list}) {
    String returnType = '';
    for (var element in list) {
      returnType += element['rasi_name'] + '  ';
    }
    return returnType;
  }
}
