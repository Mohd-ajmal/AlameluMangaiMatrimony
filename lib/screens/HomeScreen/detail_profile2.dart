import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:matrimony/Pages/personel_info_page2.dart';
import 'package:matrimony/Pages/proffession_page2.dart';
import 'package:matrimony/Pages/religious_info_2.dart';

import 'package:matrimony/model/matches_based_on_preference.dart';
import 'package:matrimony/model/multi_image.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';

class DetailScreenPreference extends StatefulWidget {
  Datum1 profilesBasedOnPreference;
  DetailScreenPreference(this.profilesBasedOnPreference, {Key? key})
      : super(key: key);

  @override
  State<DetailScreenPreference> createState() => _DetailScreenPreferenceState();
}

int userId = 0;
String token = '';
List<String> _images = [];

class _DetailScreenPreferenceState extends State<DetailScreenPreference> {
  @override
  void initState() {
    super.initState();
    final box = Boxes.getTransaction();
    final transaction = box.values.toList().cast<UserModelHive>();
    userId = transaction.last.userId;
    token = transaction.last.token;
    _images.add(widget.profilesBasedOnPreference.userBasicInfo.imageWithPath);
    getImages();
  }

  @override
  void dispose() {
    _images = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Detail screen",
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  onPressed: () {
                    shortlistUser(
                        context: context,
                        id: widget
                            .profilesBasedOnPreference.userBasicInfo.userId);
                  },
                  child: const Text("Shortlist")),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: widget.profilesBasedOnPreference.userProfileId,
                child: CarouselSlider(
                  items: _images
                      .map(
                        (e) => ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                e,
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    initialPage: 0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    autoPlay: true,
                    aspectRatio: 3 / 1.4,
                  ),
                ),
              ),
              TabBar(
                tabs: const [
                  Tab(
                    text: 'Personel Info',
                  ),
                  Tab(
                    text: 'Religion Info',
                  ),
                  Tab(
                    text: 'Proffesional Info',
                  ),
                  Tab(
                    text: 'Horoscope Info',
                  ),
                ],
                padding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                labelPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                labelColor: Colors.green[800],
                isScrollable: true,
                labelStyle: const TextStyle(
                    fontSize: 13.0, fontWeight: FontWeight.bold),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 4,
                indicatorColor: Colors.green[800],
                unselectedLabelColor: Colors.grey,
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    PersonelInfoPage2(
                        widget.profilesBasedOnPreference.userBasicInfo,
                        widget.profilesBasedOnPreference.userNativeInfo,
                        widget.profilesBasedOnPreference.userFamilyInfo),
                    ReliginInfo2(
                        widget.profilesBasedOnPreference.userReligeonInfo),
                    // PreferencesPage2(
                    //     widget.profilesBasedOnPreference.user,
                    //     widget.profilesBasedOnPreference
                    //         .userProfessionInfo,
                    //     widget
                    //         .profilesBasedOnPreference.religiousPreferenceInfo),
                    // const Center(
                    //   child: Text("0"),
                    // ),
                    ProffesionalPage2(
                        widget.profilesBasedOnPreference.userProfessionInfo),
                    Center(
                        child: Image.network(widget.profilesBasedOnPreference
                                .userHoroScopeInfo.image ??
                            "https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg"))
                  ],
                ),
              )
            ], // TabBarColumn
          ),
        ),
      ),
    );
  }

  void getImages() async {
    try {
      String url =
          'https://alamelumangaimatrimony.com/api/v1/user-profile/user-multiple-image-get/${widget.profilesBasedOnPreference.userBasicInfo.userId}';
      var res = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      String resBody = res.body;
      // print(res.statusCode);
      // var resBody2 = json.decode(resBody);
      // print(resBody2.runtimeType);

      if (res.statusCode == 200) {
        var images = multiImageFromJson(resBody);
        //print(images.toString());
        if (images.isNotEmpty) {
          setState(() {
            _images.addAll(images.map((e) => e.imageFullPath).toList());
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "Something went wrong, while fetching image from the server")));
      }
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "Something went wrong, while fetching image from the server")));
    }
  }

  shortlistUser({required context, id}) async {
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
}
