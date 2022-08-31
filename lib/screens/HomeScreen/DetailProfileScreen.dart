// ignore_for_file: file_names, must_be_immutable

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:matrimony/model/multi_image.dart';

import 'package:matrimony/model/profile_list_model.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';
import '../../Pages/PersonelInfoPage.dart';
import '../../Pages/PreferencesPage.dart';
import '../../Pages/ProffesionalPage.dart';
import '../../Pages/ReligionInfoPage.dart';

class DetailScreen extends StatefulWidget {
  Datum profileModel;
  String? profileImage;
  bool value;
  DetailScreen(this.profileModel,
      {Key? key, required this.profileImage, required this.value})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

int userId = 0;
String token = '';
String error = '';

List<String> _images = [];

class _DetailScreenState extends State<DetailScreen> {
  double mar = 0;

  @override
  void initState() {
    super.initState();
    final box = Boxes.getTransaction();
    final transaction = box.values.toList().cast<UserModelHive>();
    userId = transaction.last.userId;
    token = transaction.last.token;
    _images.add(widget.profileImage ??
        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png");
    getImages();
    //print(widget.profileModel.userHoroScopeInfo.image);
  }

  @override
  void dispose() {
    _images = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
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
            widget.value == false
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                        onPressed: () {
                          shortlistUser(
                              context: context,
                              id: widget.profileModel.basicPartnerInfo.userId);
                        },
                        child: const Text("Shortlist")),
                  )
                : const TextButton(onPressed: null, child: Text("Shortlisted"))
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: widget.profileModel.userBasicInfo.userId,
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
                    text: 'Preferences',
                  ),
                  Tab(
                    text: 'Proffesional info',
                  ),
                  Tab(
                    text: 'Horoscope info',
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
                    PersonelInfoPage(
                        widget.profileModel.userBasicInfo,
                        widget.profileModel.userNativeInfo,
                        widget.profileModel.userFamilyInfo,
                        widget.profileModel.username),
                    ReliginInfo(widget.profileModel.userReligeonInfo),
                    PreferencesPage(widget.profileModel.basicPartnerInfo),
                    ProffesionalPage(widget.profileModel.userProfessionInfo),
                    Center(
                        child: Image.network(widget
                                .profileModel.userHoroScopeInfo.image ??
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
          'https://alamelumangaimatrimony.com/api/v1/user-profile/user-multiple-image-get/${widget.profileModel.userBasicInfo.userId}';
      var res = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      //print('${widget.profileModel.userBasicInfo.userId}');
      String resBody = res.body;
      // print(res.statusCode);
      // var resBody2 = json.decode(resBody);
      // print(resBody2.runtimeType);

      if (res.statusCode == 200) {
        var images = multiImageFromJson(resBody);
        //print(images.toString());
        if (mounted) {
          if (images.isNotEmpty) {
            setState(() {
              _images.addAll(images.map((e) => e.imageFullPath).toList());
            });
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "Something went wrong, while fetching image from the server ${res.statusCode}")));
          }
        }
      }
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "Something went wrong, while fetching image from the server exception")));
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
      setState(() {
        widget.value = true;
      });
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
