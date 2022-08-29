// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:matrimony/model/ReligiousInfoModel.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';

class ReligiousInfoEditPage extends StatefulWidget {
  final ReligiousInfoModel _religiousInfoModel;
  const ReligiousInfoEditPage(this._religiousInfoModel, {Key? key})
      : super(key: key);

  @override
  State<ReligiousInfoEditPage> createState() => _ReligiousInfoEditPageState();
}

late ReligiousInfoModel _religiousInfoModel;

// visibility
bool isProgress = true;
bool isData = false;

// Hive
final box = Boxes.getTransaction();

dynamic subCaste;
dynamic birthTime;
dynamic birthPlace;
dynamic star;
String rasi = '';
String id = '';
String religion = '';
String caste = '';
String dhosam = '';

// token and user id
late String userId;
late String token;

// controller
final subCasteController = TextEditingController();
final dhoshamDetailsController = TextEditingController();
final birthPlaceController = TextEditingController();
final birthTimeController = TextEditingController();

// lists
List religionDropDownFromServer = [];
List casteDropDownFromServer = [];
List rasiDropDownFromServer = [];
List starDropDownFromServer = [];

// DropDown From server
List<DropdownMenuItem<String>>? get religionDropDown {
  return religionDropDownFromServer.map((e) {
    return DropdownMenuItem(
        child: Text(e['religion_name']), value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get casteDropDown {
  return casteDropDownFromServer.map((e) {
    return DropdownMenuItem(
        child: Text(
          e['caste_name'],
          style: const TextStyle(fontSize: 12.0),
        ),
        value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get rasiDropDown {
  return rasiDropDownFromServer.map((e) {
    return DropdownMenuItem(child: Text(e['rasi']), value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get starDropDown {
  return starDropDownFromServer.map((e) {
    return DropdownMenuItem(child: Text(e['star']), value: e['id'].toString());
  }).toList();
}

class _ReligiousInfoEditPageState extends State<ReligiousInfoEditPage> {
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

    String urlstar =
        'https://alamelumangaimatrimony.com/api/v1/masters/star-list';
    var resStar = await http.get(Uri.parse(urlstar));
    var resBodyStar = json.decode(resStar.body);

    setState(() {
      religionDropDownFromServer = resBody['data'];
      casteDropDownFromServer = resBodyCaste['data'];
      rasiDropDownFromServer = resBodyRasi['data'];
      starDropDownFromServer = resBodyStar['data'];

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
    _religiousInfoModel = widget._religiousInfoModel;
    getSWData();
    subCasteController.text = _religiousInfoModel.data.subCaste ?? '';
    dhoshamDetailsController.text = _religiousInfoModel.data.dhosam.isEmpty
        ? ''
        : _religiousInfoModel.data.dhosam;
    birthPlaceController.text = _religiousInfoModel.data.birthPlace ?? '';
    birthTimeController.text = _religiousInfoModel.data.birthTime ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Edit Religious Info',
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
      body: !isProgress
          ? SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SubCaste',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(fontWeight: FontWeight.normal),
                      controller: subCasteController,
                      autocorrect: false,
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
                      'Dhosham details',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(fontWeight: FontWeight.normal),
                      controller: dhoshamDetailsController,
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
                      'Birth Place',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(fontWeight: FontWeight.normal),
                      controller: birthPlaceController,
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
                      'Birth Time',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      textInputAction: TextInputAction.done,
                      style: const TextStyle(fontWeight: FontWeight.normal),
                      controller: birthTimeController,
                      decoration: InputDecoration(
                        hintText: "Please provide time like this 12:39",
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    details(
                        name1: 'Religion',
                        name2: 'Caste',
                        dropdown1: religionDropDown,
                        dropdown2: casteDropDown,
                        value1: null,
                        value2: null,
                        identify1: 'religion',
                        identify2: 'caste'),
                    const SizedBox(height: 10.0),
                    // details(
                    //     name1: 'Rasi',
                    //     name2: 'Star',
                    //     dropdown1: rasiDropDown,
                    //     dropdown2: starDropDown,
                    //     value1: null,
                    //     value2: null,
                    //     identify1: 'rasi',
                    //     identify2: 'star'),
                    // const SizedBox(
                    //   height: 10.0,
                    // ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Rasi',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    hintText: widget
                                        ._religiousInfoModel.data.rasi.rasi,
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  value: null,
                                  onChanged: (dynamic newValue) {
                                    setState(() {
                                      rasi = newValue;
                                    });
                                  },
                                  items: rasiDropDown),
                            ],
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Star',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    hintText: widget
                                        ._religiousInfoModel.data.star.star,
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  value: null,
                                  onChanged: (dynamic newValue) {
                                    setState(() {
                                      star = newValue;
                                    });
                                  },
                                  items: starDropDown),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    //const Spacer(),
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
            )
          : const Center(child: CircularProgressIndicator.adaptive()),
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
                    if (identify1 == 'religion') {
                      religion = newValue!;
                    } else if (identify1 == 'rasi') {
                      rasi = newValue!;
                    }
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
                    if (identify2 == 'caste') {
                      caste = newValue!;
                    } else if (identify2 == 'star') {
                      star = newValue!;
                    }
                  },
                  items: dropdown2),
            ],
          ),
        ),
      ],
    );
  }

  Widget getValue1({required identify1}) {
    if (identify1 == 'religion') {
      return Text(_religiousInfoModel.data.religion.religionName);
    } else if (identify1 == 'rasi') {
      return Text(_religiousInfoModel.data.rasi.rasi);
    } else {
      return const Text('');
    }
  }

  Widget getValue2({required identify2}) {
    if (identify2 == 'caste') {
      return Text(_religiousInfoModel.data.caste.casteName);
    } else if (identify2 == 'star') {
      return Text(_religiousInfoModel.data.star.star);
    } else {
      return const Text('');
    }
  }

  assignVariables() {
    if (subCasteController.text.isEmpty &&
        _religiousInfoModel.data.subCaste == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide sub-caste'),
        ),
      );
    } else if (dhoshamDetailsController.text.isEmpty &&
        _religiousInfoModel.data.dhosam == '0') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide dhosham'),
        ),
      );
    } else if (birthPlaceController.text.isEmpty &&
        _religiousInfoModel.data.birthPlace == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please birth place'),
        ),
      );
    } else if (birthTimeController.text.isEmpty &&
        _religiousInfoModel.data.birthTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide birth time'),
        ),
      );
    } else if (religion.isEmpty &&
        _religiousInfoModel.data.religion.religionName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide religion'),
        ),
      );
    } else if (caste.isEmpty &&
        _religiousInfoModel.data.caste.casteName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide caste'),
        ),
      );
    } else if (rasi.isEmpty && _religiousInfoModel.data.rasi.rasi.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide rasi'),
        ),
      );
    } else if (star == null && _religiousInfoModel.data.star == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide star'),
        ),
      );
    } else {
      postUserData(context: context);
    }
  }

  postUserData({required context}) async {
    final response = await http.post(
        Uri.parse(
            'https://alamelumangaimatrimony.com/api/v1/user-profile/religious-info'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          'user_religion': religion.isEmpty
              ? '${_religiousInfoModel.data.religion.id}'
              : religion,
          'user_caste':
              caste.isEmpty ? '${_religiousInfoModel.data.caste.id}' : caste,
          'user_subcaste': subCasteController.text,
          'user_rasi':
              rasi.isEmpty ? '${_religiousInfoModel.data.rasi.id}' : rasi,
          'user_star': star ?? '${_religiousInfoModel.data.star}',
          'user_dhosam':
              dhosam.isEmpty ? _religiousInfoModel.data.dhosam : dhosam,
          'user_btime': birthTimeController.text,
          'user_bplace': birthPlaceController.text
        });

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
}
