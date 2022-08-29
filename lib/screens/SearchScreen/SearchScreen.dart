// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:matrimony/model/SearchFilterModel.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

DateTime? currentBackPressTime;

final box = Boxes.getTransaction();

// variables
late int userId;
late String token;

// search model class
SearchFilterModel? _searchFilterModel;

// controller
final searchController = TextEditingController();

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    final transaction = box.values.toList().cast<UserModelHive>();
    userId = transaction.last.userId;
    token = transaction.last.token;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: searchController,
              style: const TextStyle(fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffix: SizedBox(
                  height: 25.0,
                  width: 85.0,
                  child: ElevatedButton(
                    onPressed: () {
                      postUserId(searchController.text);
                    },
                    child: const Text('search'),
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          _searchFilterModel != null
              ? Expanded(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         //DetailScreen(profileModel[index]),
                          //   ),
                          // );
                        },
                        child: promoCart(
                          image: _searchFilterModel!
                                  .data.userBasicInfo.imageWithPath ??
                              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                          state: _searchFilterModel!.data.profileId,
                          ageAndHeight:
                              _searchFilterModel!.data.userBasicInfo.age,
                          name: _searchFilterModel!.data.username,
                          professtion: _searchFilterModel!
                              .data.userBasicInfo.createdAt
                              .toString(),
                          context: context,
                          index: 1,
                        ),
                      );
                    },
                  ),
                )
              : const Center(
                  child: Text(''),
                )
        ],
      ),
    );
  }

  postUserId(String id) async {
    try {
      final url = Uri.parse(
          'https://alamelumangaimatrimony.com/api/v1/search/search-by-id');
      final reponse = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {"profile_id": id},
      );
      log(reponse.statusCode.toString());
      //print(reponse.body);
      if (reponse.statusCode == 200) {
        setState(() {
          _searchFilterModel =
              searchFilterModelFromJson(reponse.body.toString());
        });
        //print(_searchFilterModel!.data.createdAt);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('No user found')));
      }
    } on Exception {
      //print(e);
    }
  }

  Widget promoCart({
    required BuildContext context,
    required String image,
    required name,
    required ageAndHeight,
    required state,
    required index,
    required professtion,
  }) {
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FadeInImage.assetNetwork(
                placeholder: 'assets/images/missingImage.png',
                image: image,
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.fill,
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
                      professtion ?? 'Proffesstion Not Specified',
                      maxLines: 1,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      ageAndHeight ?? 'Age And Height Not Specified',
                      maxLines: 1,
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      state ?? 'Native Not Specified',
                      maxLines: 1,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    side: const BorderSide(width: 2, color: Color(0xFF2e7d32)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: () {
                    postUserData(
                        context: context,
                        id: _searchFilterModel!.data.userBasicInfo.userId);
                  },
                  child: const Text(
                    'Shortlist',
                    style: TextStyle(
                        color: Color(0xFF2e7d32), fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              )
            ],
            // promoCartPhoto
          ),
        ),
      ),
    );
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
