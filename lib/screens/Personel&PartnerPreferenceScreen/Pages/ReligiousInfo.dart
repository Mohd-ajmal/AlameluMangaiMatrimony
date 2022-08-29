// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:matrimony/model/ReligiousInfoModel.dart';
import 'package:matrimony/screens/Personel&PartnerPreferenceScreen/Pages/EditPages/ReligiousInfoEditPage.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';

class ReligiousInfo extends StatefulWidget {
  String? appBar;
  ReligiousInfo({Key? key, required this.appBar}) : super(key: key);

  @override
  State<ReligiousInfo> createState() => _ReligiousInfoState();
}

// Model class
late ReligiousInfoModel _religiousInfoModel;

// Hive
final box = Boxes.getTransaction();
late String userId;
late String token;

dynamic subCaste;
dynamic birthTime;
dynamic birthPlace;
dynamic star;
String rasi = '';
String id = '';
String religion = '';
String caste = '';
String dhosam = '';

class _ReligiousInfoState extends State<ReligiousInfo> {
  @override
  void initState() {
    super.initState();
    final transaction = box.values.toList().cast<UserModelHive>();
    userId = transaction.last.userId.toString();
    token = transaction.last.token;
    getUserData(context: context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: widget.appBar == null
            ? null
            : AppBar(
                title: const Text("Religious Info"),
              ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Religion',
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
                  child: Text(religion.isEmpty ? 'Not specified' : religion),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Caste',
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
                  child: Text(caste.isEmpty ? 'Not specified' : caste),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'SubCaste',
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
                  child: Text(subCaste ?? 'Not specified'),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Rasi',
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
                  child: Text(rasi.isEmpty ? 'Not specified' : rasi),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Star',
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
                  child: Text(star ?? 'Not specified'),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Birth time',
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
                  child: Text(birthTime ?? 'Not specified'),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Birth place',
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
                  child: Text(birthPlace ?? 'Not Specified'),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Dhosham',
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
                  child: Text(dhosam.isEmpty ? 'Not specified' : dhosam),
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
                                ReligiousInfoEditPage(_religiousInfoModel)));
                  },
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Edit Religious Info',
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getUserData({required context}) async {
    String url =
        'https://alamelumangaimatrimony.com/api/v1/user-profile/religious-info/$userId';
    var res = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    //print(res.body);
    if (res.statusCode == 200) {
      _religiousInfoModel = religiousInfoModelFromJson(res.body.toString());
      if (mounted) {
        setState(() {
          religion = _religiousInfoModel.data.religion.religionName;
          caste = _religiousInfoModel.data.caste.casteName;
          subCaste = _religiousInfoModel.data.subCaste;
          rasi = _religiousInfoModel.data.rasi.rasi;
          star = _religiousInfoModel.data.star.star;
          birthTime = _religiousInfoModel.data.birthTime;
          birthPlace = _religiousInfoModel.data.birthPlace;
          dhosam = _religiousInfoModel.data.dhosam;
        });
      }

      //print(country.isEmpty ? 'notspecified' : 'summa');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
        ),
      );
    }
  }
}
