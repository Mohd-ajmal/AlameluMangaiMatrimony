// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/model/ShortlistModel.dart';
import 'package:matrimony/screens/ProfileScreen/shorlistScreen/shortlist_details.dart';

import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';

class ShortlistScreen extends StatefulWidget {
  const ShortlistScreen({Key? key}) : super(key: key);

  @override
  State<ShortlistScreen> createState() => _ShortlistScreenState();
}

var _profileMatchModel = [];

int userId = 0;
String token = '';

// model class
ShortlistModel? _shortlistModel;

class _ShortlistScreenState extends State<ShortlistScreen> {
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
    return Scaffold(
      body: Container(
        child: shortlistContainer(context: context),
      ),
    );
  }

  Widget shortlistContainer({required context}) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: FutureBuilder(
        future: getMatches(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator.adaptive());
            case ConnectionState.done:
            default:
              if (snapshot.hasData) {
                if (_profileMatchModel.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShortlistDetailScreen(
                                      _shortlistModel!.data.data[index]))),
                          child: ListTile(
                            leading: Container(
                              height: 80.0,
                              width: 80.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Image.network(
                                _shortlistModel!.data.data[index]
                                        .shortlistBasicInfo!.imageWithPath ??
                                    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              _shortlistModel!
                                  .data.data[index].userShortListInfo.username,
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Age ${_shortlistModel!.data.data[index].shortlistBasicInfo!.age}',
                              maxLines: 1,
                            ),
                            trailing: TextButton(
                                onPressed: () {
                                  removeUser(
                                      _shortlistModel!.data.data[index].userId,
                                      index);
                                  // //print(
                                  //     _shortlistModel!.data.data[index].userId);
                                },
                                child: const Text('Remove')),
                          ),
                        ),
                      );
                    },
                    itemCount: _profileMatchModel.length,
                  );
                } else {
                  const Center(
                      child: Text('You did not shorlisted any profiles yet'));
                }
              } else if (snapshot.hasError) {
                const Center(
                  child: Text(
                      'Something went wrong, Please check your internet connection and try again'),
                );
              }

              return const Center(
                  child: Text('You did not shorlisted any profiles yet'));
          }
        },
      ),
    );
  }

  Future<List<dynamic>> getMatches() async {
    String url =
        'https://alamelumangaimatrimony.com/api/v1/user-profile/my-short-list/$userId';
    var res = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    String resBody = res.body.toString();
    //print(resBody.runtimeType);

    //print(resBody2.runtimeType);

    if (res.statusCode == 200) {
      final shortlistModel = shortlistModelFromJson(resBody);
      _shortlistModel = shortlistModel;
      _profileMatchModel = shortlistModel.data.data;
    } else {
      //print("resBody2");
    }
    return _profileMatchModel;
  }

  removeUser(String userId, int index) async {
    String url =
        'https://alamelumangaimatrimony.com/api/v1/user-profile/my-short-list/$userId';
    var res = await http.delete(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    //print(res.statusCode);

    if (res.statusCode == 204) {
      setState(() {
        _shortlistModel!.data.data.remove(index);
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
  }
}
