// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/model/profile_list_model.dart';
import 'package:matrimony/screens/HomeScreen/DetailProfileScreen.dart';

import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';

class PaginationPage extends StatefulWidget {
  const PaginationPage({Key? key}) : super(key: key);

  @override
  State<PaginationPage> createState() => _PaginationPageState();
}

// pages count
int totalNoOfPages = 0;

List<int> _userId = [9, 30];

// controller
final listViewController = ScrollController();

int page = 1;
bool hasMore = true;

// visibility check
bool starFilled = false;
bool starOulined = true;
bool progress = false;

List<Datum> _profileMatchModel = [];

int userId = 0;
String token = '';

class _PaginationPageState extends State<PaginationPage> {
  @override
  void initState() {
    super.initState();
    final box = Boxes.getTransaction();
    final transaction = box.values.toList().cast<UserModelHive>();
    userId = transaction.last.userId;
    token = transaction.last.token;
    getMatches(pageNumber: page);
    listViewController.addListener(() {
      if (listViewController.position.maxScrollExtent ==
          listViewController.offset) {
        getMatches(pageNumber: (page += 1));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    // _userId = [];
    //listViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title:
            const Text('All Profiles', style: TextStyle(color: Colors.black)),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: _profileMatchModel.isNotEmpty
          ? Container(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                controller: listViewController,
                itemBuilder: (context, index) {
                  if (index < _profileMatchModel.length) {
                    return Material(
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                      _profileMatchModel[index],
                                      profileImage: _profileMatchModel[index]
                                          .userBasicInfo
                                          .imageWithPath,
                                    ))),
                        child: ListTile(
                          leading: SizedBox(
                            height: 150,
                            width: 75,
                            child: Hero(
                              tag: _profileMatchModel[index].id,
                              child: Image.network(
                                _profileMatchModel[index]
                                        .userBasicInfo
                                        .imageWithPath ??
                                    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          title: Text(
                            _profileMatchModel[index].username,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(_profileMatchModel[index]
                              .userReligeonInfo
                              .belongsToCaste
                              .casteName),
                          trailing: _userId[
                                      index >= _userId.length ? 0 : index] !=
                                  _profileMatchModel[index].userBasicInfo.userId
                              ? ElevatedButton(
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
                                        id: _profileMatchModel[index]
                                            .userBasicInfo
                                            .userId);
                                  },
                                  child: const Text(
                                    'Shortlist',
                                    style: TextStyle(
                                        color: Color(0xFF2e7d32),
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              : Text("Shortlisted"),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: totalNoOfPages != _profileMatchModel.length
                            ? const Center(
                                child: CircularProgressIndicator.adaptive())
                            : const Center(
                                child: Text("No more Data"),
                              ));
                  }
                },
                itemCount: _profileMatchModel.length + 1,
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Future<List<Datum>?> getMatches({required pageNumber}) async {
    try {
      String url =
          'https://alamelumangaimatrimony.com/api/v1/user-profile/profiles-list?page=$pageNumber';
      var res = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      String resBody = res.body;

      //var resBody2 = json.decode(resBody);

      if (res.body.isEmpty) {
        setState(() {
          hasMore = false;
        });
      }
      if (res.statusCode == 200) {
        //print(res.body);

        if (pageNumber == 1) {
          if (mounted) {
            setState(() {
              ProfileListModel body = profileListModelFromJson(resBody);
              _profileMatchModel = body.data.data;
              totalNoOfPages = body.data.total;
              //print(totalNoOfPages.toString());
            });
          }
        } else {
          if (mounted) {
            setState(() {
              ProfileListModel body = profileListModelFromJson(resBody);
              _profileMatchModel.addAll(body.data.data);
            });
          }
        }
      } else {
        return _profileMatchModel;
      }
      return _profileMatchModel;
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  // post user prefered shortlist
  postUserData({required context, id}) async {
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
