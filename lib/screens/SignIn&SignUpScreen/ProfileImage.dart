// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'HiveDatabase/BoxTransaction.dart';
import 'HiveDatabase/UserModelHive.dart';

class ProfileImageUpdate extends StatefulWidget {
  const ProfileImageUpdate({Key? key}) : super(key: key);

  @override
  State<ProfileImageUpdate> createState() => _ProfileImageUpdateState();
}

// Hive
final box = Boxes.getTransaction();
late String userId;
String token = '';

class _ProfileImageUpdateState extends State<ProfileImageUpdate> {
  File? imageUpload;
  bool _isProgress = false;
  late BuildContext _context;

  @override
  void initState() {
    super.initState();
    final transaction = box.values.toList().cast<UserModelHive>();
    userId = transaction.last.userId.toString();
    token = transaction.last.token;
  }

  Widget buildGridView() {
    if (imageUpload != null) {
      return GridView.count(crossAxisCount: 1, children: [
        Image.file(imageUpload!, fit: BoxFit.cover, width: 160.0, height: 160.0)
      ]);
    } else {
      return const Center(child: Text('Select image to upload profile pic'));
    }
  }

  Future<void> multiImage() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final image = await _picker.pickImage(
          source: ImageSource.gallery,
          maxWidth: 300.0,
          maxHeight: 300.0,
          imageQuality: 100);
      if (image == null) return;
      final fileImage = File(image.path);
      setState(() {
        imageUpload = fileImage;
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(_context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload profile pic",
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 20.0,
            ),
            // Center(child: Text('Error: $_error')),
            Expanded(
              child: buildGridView(),
            ),
            Visibility(
              visible: _isProgress,
              child: const CircularProgressIndicator(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: ElevatedButton(
                    child: const Text("Pick images"),
                    onPressed: multiImage,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: TextButton(
                    onPressed: () {
                      postPhotoToServer(title: 'title', context: context);
                    },
                    child: const Text('Upload'),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void testing({required state}) {
    setState(() {
      _isProgress = state;
    });
  }

  Future<void> postPhotoToServer(
      {required String title, required context}) async {
    if (imageUpload == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a photo'),
        ),
      );
    } else {
      testing(state: true);
      upload(imageUpload!, context: context);
    }
  }

  upload(File imageFile, {required context}) async {
    try {
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };
      // open a bytestream
      var stream = http.ByteStream(Stream.castFrom(imageFile.openRead()));
      // get file length
      var length = await imageFile.length();

      // string to uri
      var uri = Uri.parse(
          "https://alamelumangaimatrimony.com/api/v1/user-profile/profile-photo-upload/image-update");

      // create multipart request
      var request = http.MultipartRequest("POST", uri);

      // multipart that takes file
      var multipartFile = http.MultipartFile('profileImage', stream, length,
          filename: basename(imageFile.path));

      // add file to multipart
      request.headers.addAll(headers);
      request.files.add(multipartFile);

      // send
      var response = await request.send();
      //print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        testing(state: false);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('isProfileUpdated', 'isProfileUpdated');
        setState(() {
          Navigator.pushNamedAndRemoveUntil(
              context, '/home', (Route<dynamic> route) => false);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Profile photo updated successfully',
            ),
          ),
        );
      } else {
        testing(state: false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please check your internet connection and try again',
            ),
          ),
        );
      }

      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        //print(value);
      });
    } catch (e) {
      testing(state: false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload photo smaller than 1 MB'),
        ),
      );
    }
  }
}
// "http://rbsreadymadesteel.com/tmclone.in/api/v1/user-profile/profile-photo-upload/image-update"