// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/model/UserNativeInfoModel.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';

class NativeInfoEditPage extends StatefulWidget {
  final UserNativeInfoModel _userNativeInfoModel;
  const NativeInfoEditPage(this._userNativeInfoModel, {Key? key})
      : super(key: key);

  @override
  State<NativeInfoEditPage> createState() => _NativeInfoEditPageState();
}

// modelClass
late UserNativeInfoModel _userNativeInfoModel;

// Hive
final box = Boxes.getTransaction();
late String userId;
late String token;

// visibility check
bool isProgress = true;
bool isContainer = false;
bool isStateVisible = false;
bool isCityVisible = false;

// variables
String country = '';
String state = '';
String city = '';

// lists
List countryDropDownFromServer = [];
List stateDropDownFromServer = [];
List cityDropDownFromServer = [];

List<DropdownMenuItem<String>>? get countryDropDown {
  return countryDropDownFromServer.map((e) {
    return DropdownMenuItem(
        child: Text(e['country']), value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get stateDropDown {
  return stateDropDownFromServer.map((e) {
    return DropdownMenuItem(child: Text(e['state']), value: e['id'].toString());
  }).toList();
}

List<DropdownMenuItem<String>>? get cityDropDown {
  return cityDropDownFromServer.map((e) {
    return DropdownMenuItem(child: Text(e['city']), value: e['id'].toString());
  }).toList();
}

class _NativeInfoEditPageState extends State<NativeInfoEditPage> {
  Future<void> getSWData() async {
    String url =
        'https://alamelumangaimatrimony.com/api/v1/masters/country-list';
    var res = await http.get(Uri.parse(url));
    var resBody = json.decode(res.body);

    // String urlstate =
    //     'http://rbsreadymadesteel.com/tmclone.in/api/v1/masters/state-list';
    // var resState = await http.get(Uri.parse(urlstate));
    // var resBodyState = json.decode(resState.body);

    // String urlCity =
    //     'http://rbsreadymadesteel.com/tmclone.in/api/v1/masters/city-list';
    // var resCity = await http.get(Uri.parse(urlCity));
    // var resBodyCity = json.decode(resCity.body);

    setState(() {
      countryDropDownFromServer = resBody['data'];
      // stateDropDownFromServer = resBodyState['data'];
      // cityDropDownFromServer = resBodyCity['data'];

      //print(resBodyCity);
    });
  }

  Future<void> getState() async {
    String urlstate =
        'https://alamelumangaimatrimony.com/api/v1/masters/state/state-by-country/$country';
    var resState = await http.get(Uri.parse(urlstate));
    var resBodyState = json.decode(resState.body);
    //print(country.toString());
    setState(() {
      stateDropDownFromServer = resBodyState['data'];
    });
  }

  Future<void> getCity() async {
    String urlCity =
        'https://alamelumangaimatrimony.com/api/v1/masters/city/city-by-state/$state';
    var resCity = await http.get(Uri.parse(urlCity));
    var resBodyCity = json.decode(resCity.body);
    setState(() {
      cityDropDownFromServer = resBodyCity['data'];
    });
  }

  @override
  void initState() {
    super.initState();
    final transaction = box.values.toList().cast<UserModelHive>();
    userId = transaction.last.userId.toString();
    token = transaction.last.token;
    _userNativeInfoModel = widget._userNativeInfoModel;
    getSWData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Edit Native Info',
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
      body: Container(
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
                        'Country',
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
                          hint: Text(_userNativeInfoModel.data.country.country),
                          value: null,
                          onChanged: (dynamic value) {
                            setState(() {
                              country = value;
                              getState();
                              isStateVisible = true;
                            });
                          },
                          items: countryDropDown),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Visibility(
              visible: isStateVisible,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'State',
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
                            hint: Text(_userNativeInfoModel.data.state.state),
                            value: null,
                            onChanged: (dynamic value) {
                              setState(() {
                                state = value;
                                getCity();
                                isCityVisible = true;
                              });
                            },
                            items: stateDropDown),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Visibility(
              visible: isCityVisible,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'City',
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
                            hint: Text(_userNativeInfoModel.data.city.city),
                            value: null,
                            onChanged: (dynamic value) {
                              setState(() {
                                city = value;
                              });
                            },
                            items: cityDropDown),
                      ],
                    ),
                  ),
                ],
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
    );
  }

  assignVariables() {
    if (country.isEmpty && _userNativeInfoModel.data.country.country.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide country'),
        ),
      );
    } else if (state.isEmpty && _userNativeInfoModel.data.state.state.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide state'),
        ),
      );
    } else if (city.isEmpty && _userNativeInfoModel.data.city.city.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide city'),
        ),
      );
    } else {
      postUserData(context: context);
    }
  }

  postUserData({required context}) async {
    final response = await http.post(
        Uri.parse(
            'https://alamelumangaimatrimony.com/api/v1/user-profile/native-info'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          "user_country": country.isEmpty
              ? '${_userNativeInfoModel.data.country.id}'
              : country,
          "user_state":
              state.isEmpty ? '${_userNativeInfoModel.data.state.id}' : state,
          "user_city":
              city.isEmpty ? '${_userNativeInfoModel.data.city.id}' : city
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
      // print(response.statusCode);
    }
  }
}
