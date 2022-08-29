// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

import 'package:matrimony/model/matches_based_on_preference.dart';
import 'package:matrimony/screens/HomeScreen/detail_profile2.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';

// ignore: must_be_immutable
class MatchesScreen extends StatefulWidget {
  const MatchesScreen({Key? key}) : super(key: key);

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

List<Datum1> _profilesBasedOnPreference = [];

int userId = 0;
String token = '';
String error = '';

DateTime? currentBackPressTime;

class _MatchesScreenState extends State<MatchesScreen> {
  @override
  void initState() {
    super.initState();
    final box = Boxes.getTransaction();
    final transaction = box.values.toList().cast<UserModelHive>();
    userId = transaction.last.userId;
    token = transaction.last.token;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10.0),
            Container(
                margin: const EdgeInsets.only(left: 15.0),
                child: const Text('matches found based on your preferences')),
            Expanded(
              child: FutureBuilder(
                future: getMatchesBasedOnPreference(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Expanded(
                          child: Center(child: CircularProgressIndicator()));
                    case ConnectionState.done:
                    default:
                      if (snapshot.hasData) {
                        if (_profilesBasedOnPreference.isNotEmpty) {
                          return Container(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                            height: 220,
                            child: ListView.builder(
                              itemCount: _profilesBasedOnPreference.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailScreenPreference(
                                                _profilesBasedOnPreference[
                                                    index])),
                                  ),
                                  child: promoCart(
                                      image: _profilesBasedOnPreference[index]
                                              .userBasicInfo
                                              .imageWithPath ??
                                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                                      name: _profilesBasedOnPreference[index]
                                          .userBasicInfo
                                          .userFullName,
                                      ageAndHeight:
                                          'Age ${_profilesBasedOnPreference[index].userBasicInfo.age}',
                                      state: _profilesBasedOnPreference[index]
                                          .userReligeonInfo
                                          .belongsToCaste
                                          .casteName,
                                      index: index,
                                      context: context,
                                      icon: const Icon(Icons.star)),
                                );
                              },
                            ),
                          );
                        } else {
                          Container(
                              height: 220.0,
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              child:
                                  Lottie.asset('assets/images/no_data.json'));
                        }
                      } else if (snapshot.hasError) {
                        const Center(
                          child: Text(
                              'Something went wrong, Please check your internet connection and try again'),
                        );
                      }

                      return Container(
                          height: 220.0,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: Lottie.asset('assets/images/no_data.json'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget promoCart(
      {required BuildContext context,
      required String image,
      name,
      ageAndHeight,
      state,
      index,
      professtion,
      required Icon icon}) {
    return AspectRatio(
      aspectRatio: 3 / 3,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.all(10.0),
        shadowColor: Colors.grey,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(5.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Hero(
                tag: _profilesBasedOnPreference[index].userProfileId,
                child: Container(
                    height: 170.0,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0),
                      ),
                    ),
                    child: Image.network(image, fit: BoxFit.fill)),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                        const SizedBox(width: 8.0),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      professtion ?? "Not specified",
                      maxLines: 1,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      ageAndHeight,
                      maxLines: 1,
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      state,
                      maxLines: 1,
                      style: const TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          side: const BorderSide(
                              width: 2, color: Color(0xFF2e7d32)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        onPressed: () {
                          postUserData(
                              context: context,
                              id: _profilesBasedOnPreference[index]
                                  .userBasicInfo
                                  .userId);
                        },
                        child: const Text(
                          'Shortlist',
                          style: TextStyle(
                              color: Color(0xFF2e7d32),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                  ],
                ),
              )
            ], // promoCartPhoto
          ),
        ),
      ),
    );
  }

  Future<List<Datum1>?> getMatchesBasedOnPreference() async {
    try {
      String url =
          'https://alamelumangaimatrimony.com/api/v1/user-profile/profiles-match-list';
      var res = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      String resBody = res.body;
      log("s" + res.statusCode.toString());
      //log(res.body);
      var resBody2 = json.decode(resBody);
      //print(resBody2.runtimeType);

      if (res.statusCode == 200 || res.statusCode == 201) {
        log(res.body);
        if (resBody2['message'] == "User Does Not Have Preference") {
          //print("summa");
          return _profilesBasedOnPreference;
        } else {
          MatchesBasedOnPreference matchesBasedOnPreference =
              matchesBasedOnPreferenceFromJson(res.body);
          _profilesBasedOnPreference = matchesBasedOnPreference.data;
        }
      } else {
        return _profilesBasedOnPreference;
      }
      return _profilesBasedOnPreference;
    } on Exception catch (e) {
      e is SocketException
          ? error = "Please check your internet connection"
          : error = "somthing went wrong";
    }
  }

  postUserData({required context, required id}) async {
    final response = await http.post(
        Uri.parse(
            'https://alamelumangaimatrimony.com/api/v1/user-profile/my-short-list'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          "short_listed_user_id": '$id'
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
