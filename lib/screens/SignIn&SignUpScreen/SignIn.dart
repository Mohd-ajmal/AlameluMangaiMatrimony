// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:matrimony/model/UserModel.dart';
import 'package:matrimony/screens/HomeScreen/HomeScreen.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/SignUp.dart';
import 'package:matrimony/screens/forget_password/forget_password.dart';
import 'package:matrimony/screens/payment_screen/payment_screen.dart';

import 'HiveDatabase/BoxTransaction.dart';
import 'HiveDatabase/UserModelHive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

DateTime? currentBackPressTime;

class _SignInState extends State<SignIn> {
  // userModel class
  late UserModel _userModel;

  // visibility check
  bool isLoginVisible = true;
  bool isProgressIndicatorVisible = false;

  // variables
  late String responseBody2 = '';
  bool hasInternet = false;

  // text fields
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //Hive.box('transaction').close();
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(30.0),
                margin: const EdgeInsets.only(top: 70.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hello",
                      style: TextStyle(
                          fontFamily: 'AkagiPro',
                          fontSize: 60.0,
                          letterSpacing: 1.0),
                    ),
                    Row(
                      children: const [
                        Text(
                          "There",
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
                  ], // ColumnChildren
                ),
              ),
              Container(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      controller: mobileController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        labelText: 'E-Mail',
                        prefixIcon: Icon(
                          Icons.mail_outline_outlined,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextField(
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
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgetPassword()));
                      },
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ], // ColumnTextField
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: [
                        Visibility(
                          visible: isLoginVisible,
                          child: SizedBox(
                            width: double.infinity,
                            height: 50.0,
                            child: ElevatedButton(
                              onPressed: () {
                                bool isMobileNumberEntered =
                                    mobileController.text.isEmpty;

                                bool isPasswordNumberEntered =
                                    passwordController.text.isEmpty;

                                if (isMobileNumberEntered ||
                                    isPasswordNumberEntered) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Please Enter credentials for login'),
                                    ),
                                  );
                                } else {
                                  onLogin();
                                }
                              },
                              child: const Text('Login'),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isProgressIndicatorVisible,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('New to our matrimony ?'),
                        TextButton(
                            onPressed: () async {
                              hasInternet = await InternetConnectionChecker()
                                  .hasConnection;

                              hasInternet
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const SignUp(),
                                      ),
                                    )
                                  : ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Please turn on your internet'),
                                      ),
                                    );
                            },
                            child: const Text('Register'))
                      ], // RowRegister
                    ),
                  ],
                ),
              ),
            ], // Column1Children
          ),
        ),
      ),
    );
  }

  Future<UserModel?> postUserData() async {
    final response = await http.post(
        Uri.parse('https://alamelumangaimatrimony.com/api/v1/users/user-login'),
        body: {
          'email': mobileController.text,
          'password': passwordController.text,
        });
    //print(response.body);
    if (response.statusCode == 200) {
      String responseString = response.body;
      return userModelFromJson(responseString);
    } else if (response.statusCode == 401) {
      responseBody2 = response.body;

      //print('response body' + responseBody2);
    } else if (response.statusCode == 422) {
      responseBody2 = response.body;

      //print('response body' + responseBody2);
    } else {
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

  void onLogin() async {
    try {
      setState(() {
        isLoginVisible = false;
        isProgressIndicatorVisible = true;
      });
      final userModel = await postUserData();

      if (userModel == null) {
        var resBody = json.decode(responseBody2);

        setState(() {
          isLoginVisible = true;
          isProgressIndicatorVisible = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(resBody['message']),
          ),
        );
      } else {
        setState(() {
          isLoginVisible = true;
          isProgressIndicatorVisible = false;
          _userModel = userModel;
          print(_userModel.data.isPaid);
        });
        if (_userModel.data.isPaid == "0") {
          storeUserInHive(
              userId: _userModel.data.userId,
              userName: _userModel.data.username,
              email: _userModel.data.email,
              phoneNo: userModel.data.phoneNo,
              profileId: _userModel.data.profileId,
              token: _userModel.token);
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('isRegistered', 'registered');
          setState(() {
            Route route = MaterialPageRoute(
                builder: (context) => const PaymentGateway1());
            Navigator.pushReplacement(context, route);
          });
        } else {
          storeUserInHive(
              userId: _userModel.data.userId,
              userName: _userModel.data.username,
              email: _userModel.data.email,
              phoneNo: userModel.data.phoneNo,
              profileId: _userModel.data.profileId,
              token: _userModel.token);

          //print(_userModel.toString());
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('isRegistered', 'registered');
          prefs.setString('isProfileUpdated', 'isProfileUpdated');
          prefs.setString('isPayment', 'success');
          setState(() {
            Route route =
                MaterialPageRoute(builder: (context) => const HomeScreen3());
            Navigator.pushReplacement(context, route);
          });
          // prefs.clear();
        }
      }
    } catch (e) {
      // print(e.toString());
      setState(() {
        isLoginVisible = true;
        isProgressIndicatorVisible = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
        ),
      );
    }
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Press back again to exit",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }
}
