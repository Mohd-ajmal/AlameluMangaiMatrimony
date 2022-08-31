// ignore_for_file: file_names, constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:matrimony/model/BasicInfoUser.dart';
import 'package:matrimony/model/matches_based_on_preference.dart';
import 'package:matrimony/model/profile_list_model.dart';
import 'package:matrimony/screens/HomeScreen/detail_profile2.dart';
import 'package:matrimony/screens/PaginationScreen/PaginationScreen.dart';
import 'package:matrimony/screens/Personel&PartnerPreferenceScreen/Pages/FamilyInfo.dart';
import 'package:matrimony/screens/Personel&PartnerPreferenceScreen/Pages/PartnerPreference.dart';
import 'package:matrimony/screens/Personel&PartnerPreferenceScreen/Pages/PersonelDetails.dart';
import 'package:matrimony/screens/Personel&PartnerPreferenceScreen/Pages/ReligiousInfo.dart';
import 'package:matrimony/screens/Personel&PartnerPreferenceScreen/Pages/UserNativeInfo.dart';
import 'package:matrimony/screens/Personel&PartnerPreferenceScreen/Pages/proffestion_page.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';

import '../HomeScreen/ProfileStatus(HomeScreen).dart';
import '../HomeScreen/DetailProfileScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<Datum> _profileMatchModel = [];
List<Datum1> _profilesBasedOnPreference = [];
List<dynamic> _shortlistIds = [];

// filled details
String basicFilled = "0";
String religionFilled = "0";
String familiyInfoFilled = "0";
String locationFilled = "0";
String preferenceFilled = "0";
String proffestionFilled = "0";

int userId = 0;
String token = '';
String error = '';

DateTime? currentBackPressTime;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final box = Boxes.getTransaction();
    final transaction = box.values.toList().cast<UserModelHive>();
    userId = transaction.last.userId;
    token = transaction.last.token;
    getBasicData(context: context);
    print(transaction.last.token);
    print(transaction.last.userId);
    // print(transaction.last.profileId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  var currentPage = NavigationDrawerList.Home;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              const ProfileStatus(),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Profiles',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PaginationPage()));
                        },
                        child: const Text(
                          'See All',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ], // RowNewMatchesAndSeeAll
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              FutureBuilder(
                future: getMatches(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                          height: 220,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Skeleton(
                                    height: 100,
                                    width: 100,
                                  ),
                                  SizedBox(height: 10.0),
                                  Skeleton(
                                    height: 20,
                                    width: 60,
                                  ),
                                  SizedBox(height: 10.0),
                                  Skeleton(
                                    height: 20,
                                    width: 110,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Skeleton(
                                    height: 100,
                                    width: 100,
                                  ),
                                  SizedBox(height: 10.0),
                                  Skeleton(
                                    height: 20,
                                    width: 60,
                                  ),
                                  SizedBox(height: 10.0),
                                  Skeleton(
                                    height: 20,
                                    width: 110,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Skeleton(
                                    height: 100,
                                    width: 100,
                                  ),
                                  SizedBox(height: 10.0),
                                  Skeleton(
                                    height: 20,
                                    width: 60,
                                  ),
                                  SizedBox(height: 10.0),
                                  Skeleton(
                                    height: 20,
                                    width: 110,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    case ConnectionState.done:
                    default:
                      if (snapshot.hasData) {
                        if (_profileMatchModel.isNotEmpty) {
                          return Container(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                            height: 220,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _profileMatchModel.length,
                              itemBuilder: (BuildContext context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    bool isHere = false;
                                    for (var element in _shortlistIds) {
                                      if (element ==
                                          _profileMatchModel[index]
                                              .userBasicInfo
                                              .userId
                                              .toString()) {
                                        isHere = true;
                                      }
                                      // print(isHere);
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                          _profileMatchModel[index],
                                          profileImage:
                                              _profileMatchModel[index]
                                                  .userBasicInfo
                                                  .imageWithPath,
                                          value: isHere,
                                        ),
                                      ),
                                    );
                                  },
                                  child: promoCart(
                                      image: _profileMatchModel[index]
                                              .userBasicInfo
                                              .imageWithPath ??
                                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                                      name: _profileMatchModel[index].username,
                                      ageAndHeight:
                                          'Age ${_profileMatchModel[index].userBasicInfo.age}',
                                      state: _profileMatchModel[index]
                                          .userReligeonInfo
                                          .belongsToCaste
                                          .casteName,
                                      index: index),
                                );
                              },
                            ),
                          );
                        } else {
                          Center(
                              child: Center(
                                  child: Container(
                                      height: 220.0,
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.center,
                                      child: Lottie.asset(
                                          'assets/images/no_data.json'))));
                        }
                      } else if (snapshot.hasError) {
                        const Center(
                          child: Text(
                              'Something went wrong, Please check your internet connection and try again'),
                        );
                      }

                      return Center(
                          child: Container(
                              height: 220.0,
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              child:
                                  Lottie.asset('assets/images/no_data.json')));
                  }
                },
              ),
              // Container(
              //   padding: const EdgeInsets.all(20.0),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       const Text(
              //         'Discover Matches',
              //         style: TextStyle(
              //             fontWeight: FontWeight.bold, fontSize: 18.0),
              //       ),
              //       const SizedBox(
              //         height: 8,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           discoverMatchesCards(
              //             context1: context,
              //             noOfMatches: 135,
              //             type: 'Location',
              //             icon: const Icon(
              //               Icons.location_pin,
              //               size: 25.0,
              //               color: Colors.grey,
              //             ),
              //           ),
              //           discoverMatchesCards(
              //             context1: context,
              //             noOfMatches: 15,
              //             type: 'Profession',
              //             icon: const Icon(
              //               Icons.backpack,
              //               size: 25.0,
              //               color: Colors.grey,
              //             ),
              //           ), // discoverMatchesCard
              //         ],
              //       )
              //     ], // DiscorverMatchColumn,
              //   ),
              // ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 150.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.green[100],
                ),
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Complete your profile for',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'more response',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            basicFilled == "0"
                                ? const Text(
                                    'Let us know more about you \nPlease fill your personel details',
                                    style: TextStyle(),
                                  )
                                : religionFilled == "0"
                                    ? const Text(
                                        'Let us know more about you \nPlease fill your religious details',
                                        style: TextStyle(),
                                      )
                                    : familiyInfoFilled == "0"
                                        ? const Text(
                                            'Let us know more about you \nPlease fill your family details',
                                            style: TextStyle(),
                                          )
                                        : locationFilled == "0"
                                            ? const Text(
                                                'Let us know more about you \nPlease fill your location details',
                                                style: TextStyle(),
                                              )
                                            : preferenceFilled == "0"
                                                ? const Text(
                                                    'Let us know more about you \nPlease fill your preference details',
                                                    style: TextStyle(),
                                                  )
                                                : proffestionFilled == "0"
                                                    ? const Text(
                                                        'Let us know more about you \nPlease fill your proffesion details',
                                                        style: TextStyle(),
                                                      )
                                                    : const Text(
                                                        'All details set correctly',
                                                        style: TextStyle(),
                                                      ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
                              basicFilled == "0"
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PersonelDetails(
                                                appbar: "Something",
                                              )))
                                  : religionFilled == "0"
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ReligiousInfo(
                                                    appBar: "something",
                                                  )))
                                      : familiyInfoFilled == "0"
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FamilyInfo(
                                                        appBar: "something",
                                                      )))
                                          : locationFilled == "0"
                                              ? Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UserNativeInfoPage(
                                                            appbar: "something",
                                                          )))
                                              : preferenceFilled == "0"
                                                  ? Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PartnerPreferenceScreen(
                                                                appBar:
                                                                    "Something",
                                                              )))
                                                  : proffestionFilled == "0"
                                                      ? Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ProffesionPage2(
                                                                    appbar:
                                                                        "Something",
                                                                  )))
                                                      : ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      'You filled all details')));
                            },
                            child: Text(basicFilled == "0" ||
                                    religionFilled == "0" ||
                                    locationFilled == "0" ||
                                    proffestionFilled == "0" ||
                                    familiyInfoFilled == "0" ||
                                    preferenceFilled == "0"
                                ? "Fill details"
                                : "Completed"))
                      ], // TheFirstThingNotice
                    ),
                  ], // CompleteYourProfile
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Matches',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                    // Text(
                    //   'See All',
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 13.0,
                    //       color: Colors.green),
                    // ),
                  ], // RowNewMatchesAndSeeAll
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              FutureBuilder(
                future: getMatchesBasedOnPreference(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                          height: 220,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Skeleton(
                                    height: 100,
                                    width: 100,
                                  ),
                                  SizedBox(height: 10.0),
                                  Skeleton(
                                    height: 20,
                                    width: 60,
                                  ),
                                  SizedBox(height: 10.0),
                                  Skeleton(
                                    height: 20,
                                    width: 110,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Skeleton(
                                    height: 100,
                                    width: 100,
                                  ),
                                  SizedBox(height: 10.0),
                                  Skeleton(
                                    height: 20,
                                    width: 60,
                                  ),
                                  SizedBox(height: 10.0),
                                  Skeleton(
                                    height: 20,
                                    width: 110,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Skeleton(
                                    height: 100,
                                    width: 100,
                                  ),
                                  SizedBox(height: 10.0),
                                  Skeleton(
                                    height: 20,
                                    width: 60,
                                  ),
                                  SizedBox(height: 10.0),
                                  Skeleton(
                                    height: 20,
                                    width: 110,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    case ConnectionState.done:
                    default:
                      if (snapshot.hasData) {
                        if (_profilesBasedOnPreference.isNotEmpty) {
                          return Container(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                            height: 220,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
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
                                  child: promoCart2(
                                      image: _profilesBasedOnPreference[index]
                                          .userBasicInfo
                                          .imageWithPath,
                                      name: _profilesBasedOnPreference[index]
                                          .userBasicInfo
                                          .userFullName,
                                      ageAndHeight:
                                          'Age ${_profilesBasedOnPreference[index].userBasicInfo.age}',
                                      state: _profilesBasedOnPreference[index]
                                          .userReligeonInfo
                                          .belongsToCaste
                                          .casteName,
                                      index: index),
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
              const SizedBox(
                height: 20,
              )
            ],
          )),
    );
  }

  Widget promoCart({required image, name, ageAndHeight, state, index}) {
    return AspectRatio(
      aspectRatio: 2.20 / 3,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Hero(
                tag: _profileMatchModel[index].id,
                child: Container(
                  height: 120.0,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0),
                    ),
                  ),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/missingImage.png',
                    image: image ??
                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      ageAndHeight,
                      maxLines: 1,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      state,
                      maxLines: 1,
                      style: const TextStyle(color: Colors.grey),
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

  Widget promoCart2({required image, name, ageAndHeight, state, index}) {
    return AspectRatio(
      aspectRatio: 2.20 / 3,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Hero(
                tag: _profilesBasedOnPreference[index].userProfileId,
                child: Container(
                  height: 120.0,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0),
                    ),
                  ),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/missingImage.png',
                    image: image ??
                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      ageAndHeight ?? "Not specified",
                      maxLines: 1,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      state ?? "Not specified",
                      maxLines: 1,
                      style: const TextStyle(color: Colors.grey),
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

  Widget discoverMatchesCards(
      {context1, type, noOfMatches, required Icon icon}) {
    return Container(
      padding: const EdgeInsets.all(0.1),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(5.0),
      ),
      height: 80,
      width: MediaQuery.of(context1).size.width / 2.30,
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              icon,
              const SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('$noOfMatches Matches'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  getBasicData({required context}) async {
    try {
      String url =
          'https://alamelumangaimatrimony.com/api/v1/user-profile/basic-info/$userId';
      var res = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (res.statusCode == 200) {
        var _basicInfoUser = basicInfoUserModelFromJson(res.body);

        if (mounted) {
          setState(() {
            basicFilled = _basicInfoUser.data.profileBasicFilledStatus;
            religionFilled = _basicInfoUser.data.profileReligionFilledStatus;
            proffestionFilled = _basicInfoUser.data.profileProInfoFilledStatus;
            familiyInfoFilled = _basicInfoUser.data.profileFamInfoFilledStatus;
            locationFilled = _basicInfoUser.data.profileLocationFilledStatus;
            preferenceFilled = _basicInfoUser.data.profilePrefInfoFilledStatus;
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res.statusCode.toString()),
          ),
        );
      }
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("res.statusCode.toString()"),
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

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius: const BorderRadius.all(Radius.circular(16))),
    );
  }
}

enum NavigationDrawerList {
  Home,
  Matches,
  Search,
  Profile,
}

Future<List<Datum>?> getMatches() async {
  try {
    String url =
        'https://alamelumangaimatrimony.com/api/v1/user-profile/profiles-list';
    var res = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    //print(resBody);
    // var resBody2 = json.decode(resBody);
    // print(resBody2.runtimeType);

    if (res.statusCode == 200) {
      //print(res.body);
      try {
        ProfileListModel body3 = profileListModelFromJson(res.body);
        _shortlistIds = body3.shortListIds.map((e) => e['user_id']).toList();
        _profileMatchModel = body3.data.data;
      } on Exception {
        return _profileMatchModel;
      }
    } else {
      return _profileMatchModel;
      //print(resBody2);
    }
    return _profileMatchModel;
  } on Exception {
    return _profileMatchModel;
  }
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
    //log("s" + res.statusCode.toString());
    //log(res.body);
    var resBody2 = json.decode(resBody);
    //print(resBody2.runtimeType);

    if (res.statusCode == 200 || res.statusCode == 201) {
      //log(res.body);
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
