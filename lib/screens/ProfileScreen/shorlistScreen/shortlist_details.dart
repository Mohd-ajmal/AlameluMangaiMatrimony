import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/model/ShortlistModel.dart';

import 'package:matrimony/model/multi_image.dart';
import 'package:matrimony/screens/ProfileScreen/shorlistScreen/page/shortlist_basic_info.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';

// ignore: must_be_immutable
class ShortlistDetailScreen extends StatefulWidget {
  Datum3 shortList;
  ShortlistDetailScreen(this.shortList, {Key? key}) : super(key: key);

  @override
  State<ShortlistDetailScreen> createState() => _ShortlistDetailScreenState();
}

List<String> _images = [
  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
];

int userId = 0;
String token = '';

class _ShortlistDetailScreenState extends State<ShortlistDetailScreen> {
  @override
  void initState() {
    super.initState();
    final box = Boxes.getTransaction();
    final transaction = box.values.toList().cast<UserModelHive>();
    userId = transaction.last.userId;
    token = transaction.last.token;
    getImages();
  }

  @override
  void dispose() {
    _images = [
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'
    ];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail screen",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.shortList.shortlistBasicInfo!.userId,
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
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ShortListBasicInfo(widget.shortList.shortlistBasicInfo,
                  widget.shortList.userShortListInfo.username),
            )
          ], // TabBarColumn
        ),
      ),
    );
  }

  void getImages() async {
    try {
      String url =
          'https://alamelumangaimatrimony.com/api/v1/user-profile/user-multiple-image-get/${widget.shortList.userId}';
      var res = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      //print(widget.shortList.shortlistBasicInfo!.userId);
      String resBody = res.body;
      // print(res.statusCode);
      // var resBody2 = json.decode(resBody);
      // print(resBody2.runtimeType);

      if (res.statusCode == 200) {
        var images = multiImageFromJson(resBody);
        //print(images.toString());
        if (images.isNotEmpty) {
          if (mounted) {
            setState(() {
              _images = images.map((e) => e.imageFullPath).toList();
            });
          }
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
}
