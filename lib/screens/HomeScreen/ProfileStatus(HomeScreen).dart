// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:matrimony/model/BasicInfoUser.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';

class ProfileStatus extends StatefulWidget {
  const ProfileStatus({Key? key}) : super(key: key);

  @override
  State<ProfileStatus> createState() => _ProfileStatusState();
}

// variables
late String userId;
String token = '';
late String name;
String userProfilePic = '';

// variables for filling status
double _basicFilled = 0;
double _familiyInfoFilled = 0;
double _locationFilled = 0;
double _preferenceFilled = 0;
double _proffestionFilled = 0;
double _religionFilled = 0;

// model class
BasicInfoUserModel? _basicInfoUser;

class _ProfileStatusState extends State<ProfileStatus> {
  // variable declaration
  late double profileCompletionStatus;
  late String profileName;
  late String userId;
  late String profileId;

  // Hive database
  final box = Boxes.getTransaction();

  @override
  void initState() {
    super.initState();
    profileCompletionStatus = 40.0;
    final transaction = box.values.toList().cast<UserModelHive>();
    profileName = transaction.last.username;
    token = transaction.last.token;
    userId = transaction.last.userId.toString();
    profileId = transaction.last.profileId;

    getUserData(context: context);
    userProfilePic = '';
    name = '';
  }

  @override
  Widget build(BuildContext context) {
    return name.isNotEmpty
        ? Container(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/missingImage.png',
                      image: userProfilePic),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profileName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      const SizedBox(
                        height: 3.0,
                      ),
                      Text(
                        'Id - $profileId',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 3,
                            width: 200,
                            color: Colors.grey,
                          ),
                          Container(
                            height: 3,
                            width: profileCompletionStatus * 2,
                            color: Colors.green[800],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        '$profileCompletionStatus% Profile Completion',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        children: [
                          // Container(
                          //   alignment: Alignment.center,
                          //   height: 30,
                          //   width: 60,
                          //   decoration: BoxDecoration(
                          //     color: Colors.green[800],
                          //   ),
                          //   child: const Text(
                          //     'Purchased plan',
                          //     style: TextStyle(color: Colors.white),
                          //   ),
                          // ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 120,
                              decoration: const BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: Colors.green),
                                  top: BorderSide(color: Colors.green),
                                  bottom: BorderSide(color: Colors.green),
                                  left: BorderSide(color: Colors.green),
                                ),
                              ),
                              child: Text(
                                'Purchased Plan',
                                style: TextStyle(color: Colors.green[800]),
                              ),
                            ),
                          ),
                        ], // RowBasicPlan
                      ),
                    ], // UserProfile Photo
                  ),
                ),
              ], // ProfileRowWidget
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Skeleton(
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(width: 15.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(height: 10.0),
                        Skeleton(
                          height: 20,
                          width: 60,
                        ),
                        SizedBox(height: 10.0),
                        Skeleton(
                          height: 20,
                          width: 90,
                        ),
                        SizedBox(height: 10.0),
                        Skeleton(
                          height: 20,
                          width: 150,
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  getUserData({required context}) async {
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
        _basicInfoUser = basicInfoUserModelFromJson(res.body);

        if (mounted) {
          setState(() {
            name = _basicInfoUser!.data.userFullName;
            userProfilePic = _basicInfoUser!.data.userProfileImage ??
                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png";
            //print(userProfilePic);
            profileCompletionStatus = profileCompletionStatusFuntion();
            _basicFilled =
                double.parse(_basicInfoUser!.data.profileBasicFilledStatus);
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong'),
          ),
        );
      }
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
        ),
      );
    }
  }

  static double profileCompletionStatusFuntion() {
    double status = 40.0;
    _basicFilled = double.parse(_basicInfoUser!.data.profileBasicFilledStatus);
    _familiyInfoFilled =
        double.parse(_basicInfoUser!.data.profileFamInfoFilledStatus);
    _locationFilled =
        double.parse(_basicInfoUser!.data.profileLocationFilledStatus);
    _preferenceFilled =
        double.parse(_basicInfoUser!.data.profilePrefInfoFilledStatus);
    _proffestionFilled =
        double.parse(_basicInfoUser!.data.profileProInfoFilledStatus);
    _religionFilled =
        double.parse(_basicInfoUser!.data.profileReligionFilledStatus);

    // print(
    //     '$basicFilled, $familiyInfoFilled, $locationFilled, $preferenceFilled,$proffestionFilled, $religionFilled');

    if (_basicFilled == 0 &&
        _familiyInfoFilled == 0 &&
        _locationFilled == 0 &&
        _preferenceFilled == 0 &&
        _proffestionFilled == 0 &&
        _religionFilled == 0) {
      status = 40.0;
    } else {
      status += (_basicFilled +
              _familiyInfoFilled +
              _locationFilled +
              _preferenceFilled +
              _proffestionFilled +
              _religionFilled) *
          10;
    }
    return status;
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
