// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/model/BasicInfoUser.dart';
import 'package:matrimony/screens/Personel&PartnerPreferenceScreen/Pages/EditPages/horoscope_edit.dart';

import 'package:matrimony/screens/Personel&PartnerPreferenceScreen/Pages/PartnerPreference.dart';
import 'package:matrimony/screens/Personel&PartnerPreferenceScreen/Pages/PersonelDetails.dart';
import 'package:matrimony/screens/Personel&PartnerPreferenceScreen/Pages/ReligiousInfo.dart';
import 'package:matrimony/screens/Personel&PartnerPreferenceScreen/Pages/UserNativeInfo.dart';
import 'package:matrimony/screens/Personel&PartnerPreferenceScreen/Pages/upload_image.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/ProfileImage.dart';
import 'package:matrimony/screens/documents/selecting_page.dart';

import 'Pages/FamilyInfo.dart';
import 'Pages/proffestion_page.dart';

class PersonelAndPartnerPreference extends StatefulWidget {
  const PersonelAndPartnerPreference({Key? key}) : super(key: key);

  @override
  State<PersonelAndPartnerPreference> createState() =>
      _PersonelAndPartnerPreferenceState();
}

late BasicInfoUserModel _basicInfoUser;

late String userId;
late String token;
String name = '';
String age = '';
String designation = '';
String? image;

// Hive
final box = Boxes.getTransaction();

class _PersonelAndPartnerPreferenceState
    extends State<PersonelAndPartnerPreference> {
  @override
  void initState() {
    super.initState();
    final transaction = box.values.toList().cast<UserModelHive>();
    userId = transaction.last.userId.toString();
    token = transaction.last.token;
    getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
            'My Profile',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      height: 150.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/missingImage.png',
                          image: _basicInfoUser.data.userProfileImage ??
                              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ProfileImageUpdate()));
                        },
                        child: const Text('Change profile pic'))
                  ],
                ),
              ),
              SizedBox(
                height: 35,
                child: TabBar(
                  isScrollable: true,
                  indicator: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: BorderRadius.circular(5.0)),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: 'My Info'),
                    Tab(text: 'Family'),
                    Tab(text: 'Native'),
                    Tab(text: 'Religious'),
                    Tab(text: 'Proffesion'),
                    Tab(text: 'Horoscope'),
                    Tab(text: 'Partner Preference'),
                    Tab(text: 'Upload Images'),
                    Tab(text: 'Documents upload')
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    PersonelDetails(appbar: null),
                    FamilyInfo(appBar: null),
                    UserNativeInfoPage(
                      appbar: null,
                    ),
                    ReligiousInfo(appBar: null),
                    ProffesionPage2(appbar: null),
                    const HoroscopeEdit(),
                    PartnerPreferenceScreen(appBar: null),
                    const Center(child: UploadImges()),
                    const Center(child: SelectingPage()),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getUserData({required context}) async {
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
          name = _basicInfoUser.data.userFullName;
          image = _basicInfoUser.data.userProfileImage;
          designation = _basicInfoUser.data.userMobileNo;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
        ),
      );
    }
  }
}
