// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/model/UserNativeInfoModel.dart';

import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';

import 'EditPages/UserNativeEditPage.dart';

class UserNativeInfoPage extends StatefulWidget {
  String? appbar;
  UserNativeInfoPage({Key? key, required this.appbar}) : super(key: key);

  @override
  State<UserNativeInfoPage> createState() => _UserNativeInfoPageState();
}

// Hive
final box = Boxes.getTransaction();
late String userId;
late String token;

// variables
String id = '';
String country = '';
String state = '';
String city = '';

// Visibility check
bool isProgressVisible = true;
bool isContainerVisible = false;

// Model class
late UserNativeInfoModel _userNativeInfoModel;

class _UserNativeInfoPageState extends State<UserNativeInfoPage> {
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
    isProgress = true;
    isContainer = false;
  }

  @override
  Widget build(BuildContext context) {
    return id.isNotEmpty
        ? Scaffold(
            appBar: widget.appbar == null
                ? null
                : AppBar(
                    title: const Text("Native Info"),
                  ),
            body: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Country',
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
                    child: Text(country.isEmpty ? 'Not Specified' : country),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'State',
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
                    child: Text(state.isEmpty ? 'Not Specified' : state),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'City',
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
                    child: Text(city.isEmpty ? 'Not Specified' : city),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NativeInfoEditPage(_userNativeInfoModel)));
                    },
                    child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Edit Native Info',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        : const Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()));
  }

  getUserData({required context}) async {
    String url =
        'https://alamelumangaimatrimony.com/api/v1/user-profile/native-info/$userId';
    var res = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    //print(res.body);
    if (res.statusCode == 200) {
      _userNativeInfoModel = userNativeInfoModelFromJson(res.body.toString());
      if (mounted) {
        setState(() {
          id = _userNativeInfoModel.data.id;
          country = _userNativeInfoModel.data.country.country;
          state = _userNativeInfoModel.data.state.state;
          city = _userNativeInfoModel.data.city.city;
          isProgressVisible = false;
          isContainerVisible = true;
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
