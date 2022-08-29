// ignore_for_file: file_names, prefer_typing_uninitialized_variables, unnecessary_null_comparison, avoid_init_to_null

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:matrimony/model/UserModel.dart';

import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'HiveDatabase/BoxTransaction.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool registerButtonVisibility = false;

  // User model class
  late UserModel _userModel;

  // variable initialization
  late String? singleReligion = null;
  String? singleGender = null;
  late String? singleCast = null;

  // Date Time
  DateTime? _dateTime = null;

  // text fields
  final userName = TextEditingController();
  final mobileController = TextEditingController();
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  static List<DropdownMenuItem<String>> get genderDropdown {
    List<DropdownMenuItem<String>> educationItems = [
      const DropdownMenuItem(child: Text("Male"), value: "1"),
      const DropdownMenuItem(child: Text("Female"), value: "2"),
    ];
    return educationItems;
  }

  List<DropdownMenuItem<String>> get religionDropdown {
    return religionDropDowndataFromServer.map((e) {
      return DropdownMenuItem(
          child: Text(e['religion_name']), value: e['id'].toString());
    }).toList();
  }

  List<DropdownMenuItem<String>> get castDropdown {
    return castData.map((e) {
      return DropdownMenuItem(
          child: Text(e['caste_name']), value: e['id'].toString());
    }).toList();
  }

  // Getting religion dropdown from server
  List religionDropDowndataFromServer = [];
  List castData = [];

  Future<void> getSWData() async {
    String url = 'https://alamelumangaimatrimony.com/api/v1/masters/religion';
    var res = await http.get(Uri.parse(url));
    var resBody = json.decode(res.body);

    setState(() {
      religionDropDowndataFromServer = resBody['data'];
    });

    //print(castData.first);
  }

  Future<void> getCastPerReligion() async {
    String url2 =
        'https://alamelumangaimatrimony.com/api/v1/masters/religion/$singleReligion/caste';
    var res2 = await http.get(Uri.parse(url2));
    var resBody2 = json.decode(res2.body);

    setState(() {
      castData = resBody2['data'];
    });
  }

  @override
  void initState() {
    super.initState();
    getSWData();
  }

  @override
  void dispose() {
    //Hive.box('transaction').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Visibility(
            visible: registerButtonVisibility,
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: CircularProgressIndicator(),
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sign",
                style: TextStyle(
                    fontFamily: 'AkagiPro', fontSize: 60.0, letterSpacing: 1.0),
              ),
              Row(
                children: const [
                  Text(
                    "Up",
                    style: TextStyle(
                        fontFamily: 'AkagiPro',
                        fontSize: 60.0,
                        letterSpacing: 1.0),
                  ),
                  Text(
                    ".",
                    style: TextStyle(
                        fontFamily: 'AkagiPro',
                        fontSize: 60.0,
                        letterSpacing: 1.0,
                        color: Colors.green),
                  ),
                ], // RowChildren
              ),
              const SizedBox(
                height: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: userName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      labelText: 'User Name',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: mobileController,
                    maxLength: 10,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      labelText: 'Mobile',
                      prefixIcon: Icon(
                        Icons.mobile_friendly_outlined,
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    textInputAction: TextInputAction.next,
                    controller: mailController,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      labelText: 'Mail',
                      prefixIcon: Icon(Icons.mail_outline),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    textInputAction: TextInputAction.next,
                    controller: passwordController,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.password_outlined),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    textInputAction: TextInputAction.done,
                    controller: confirmPasswordController,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(
                        Icons.password_outlined,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.black45, width: 2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _dateTime == null
                              ? '  Click calender icon to select DOB'
                              : '  ${_dateTime!.day} / ${_dateTime!.month} / ${_dateTime!.year}',
                        ),
                        IconButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime(1990),
                              firstDate: DateTime(1960),
                              lastDate: DateTime(2100),
                            ).then((value) {
                              setState(() {
                                _dateTime = value!;
                              });
                            });
                          },
                          icon: const Icon(Icons.calendar_today_outlined),
                        )
                      ],
                    ),
                  ),
                  numberWidget(
                      number: '01',
                      category: 'Gender',
                      value: 'Select',
                      dropdown: genderDropdown,
                      dropdown2: religionDropdown)
                ], // ColumnTextField
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: 'Caste',
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        validator: (value) =>
                            singleCast == null ? "Select a country" : null,
                        value: singleCast,
                        onChanged: (String? newValue) {
                          setState(() {
                            singleCast = newValue!;
                          });
                        },
                        items: castDropdown),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    bool isValidation = mobileController.text.isEmpty ||
                        mailController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        confirmPasswordController.text.isEmpty ||
                        userName.text.isEmpty ||
                        _dateTime == null ||
                        singleGender == null ||
                        singleReligion == null ||
                        singleCast == null;
                    bool isPasswordValidation =
                        passwordController.text.length <= 6 ||
                            confirmPasswordController.text.length <= 6 ||
                            passwordController.text !=
                                confirmPasswordController.text;
                    bool isEmailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(mailController.text);
                    bool isMobileValidation =
                        mobileController.text.length == 10;

                    if (isValidation) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Please fill all credentials to sign up'),
                        ),
                      );
                    } else if (isMobileValidation == false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please provide valid mobile number'),
                        ),
                      );
                    } else if (isEmailValid == false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please provide valid E-mail'),
                        ),
                      );
                    } else if (isPasswordValidation) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Password must be greater then 6 charecters or password mismatch'),
                        ),
                      );
                    } else {
                      onSignUp();
                    }
                  },
                  child: const Text('Register'),
                ),
              )
            ], // ColumnChildren
          ),
        ),
      ),
    );
  }

  Widget numberWidget({
    required String number,
    required String category,
    required String value,
    dropdown,
    dropdown2,
  }) {
    return Column(
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  validator: (value) =>
                      singleGender == null ? "Select a gender" : null,
                  value: singleGender,
                  onChanged: (String? newValue) {
                    setState(() {
                      singleGender = newValue!;
                    });
                  },
                  items: dropdown),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Religion',
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  value: singleReligion,
                  onChanged: (String? newValue) {
                    setState(() {
                      singleReligion = newValue!;
                      castData.isEmpty
                          ? getCastPerReligion()
                          : {
                              singleCast = null,
                              castData.clear(),
                              getCastPerReligion()
                            };
                    });
                  },
                  items: dropdown2),
            ),
          ],
        ),
      ],
    );
  }

  Future<UserModel?> postUserData() async {
    final response = await http.post(
        Uri.parse(
            'https://alamelumangaimatrimony.com/api/v1/users/register-user'),
        body: {
          'username': userName.text,
          'phonenumber': mobileController.text,
          'email': mailController.text,
          'password': passwordController.text,
          'password_confirmation': confirmPasswordController.text,
          'gender': singleGender,
          'dob':
              '${_dateTime!.year}-${_dateTime!.month}-${_dateTime!.day}', //'2000-12-14'
          'religion': singleReligion,
          'caste': singleCast
        });
    //print(response.body);
    if (response.statusCode == 200) {
      String responseString = response.body;
      return userModelFromJson(responseString);
    } else {
      //print(response.statusCode);
      //print(response.body);
      return null;
    }
  }

  void storeUserInHive(
      {required userId,
      required userName,
      required email,
      required phoneNo,
      required profileId,
      statusInfo,
      required token}) {
    final userModelHive = UserModelHive()
      ..userId = _userModel.data.userId
      ..username = _userModel.data.username
      ..email = _userModel.data.email
      ..phoneNo = _userModel.data.phoneNo
      ..profileId = _userModel.data.profileId
      ..statusInfo = _userModel.data.statusInfo
      ..token = _userModel.token;

    final box = Boxes.getTransaction();
    box.add(userModelHive);
    //print(box.length);
  }

  onSignUp() async {
    setState(() {
      registerButtonVisibility = true;
    });
    try {
      final userModel = await postUserData();

      if (userModel == null) {
        setState(() {
          registerButtonVisibility = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something Went Wrong'),
          ),
        );
      } else {
        setState(() {
          registerButtonVisibility = false;
          _userModel = userModel;
        });
        storeUserInHive(
            userId: _userModel.data.userId,
            userName: _userModel.data.username,
            email: _userModel.data.email,
            phoneNo: _userModel.data.phoneNo,
            profileId: _userModel.data.profileId,
            token: _userModel.token);

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('isRegistered', 'registered');

        setState(() {
          Navigator.pushNamedAndRemoveUntil(
              context, '/paymentGateway', (Route<dynamic> route) => false);
        });
      }
    } catch (e) {
      //print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }
}
