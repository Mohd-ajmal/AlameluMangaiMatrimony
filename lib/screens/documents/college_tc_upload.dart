import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';

class CollegeTc extends StatefulWidget {
  const CollegeTc({Key? key}) : super(key: key);

  @override
  State<CollegeTc> createState() => _CollegeTcState();
}

// Hive
final box = Boxes.getTransaction();
late String userId;
String token = '';

class _CollegeTcState extends State<CollegeTc> {
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
      return const Center(child: Text('Select image to upload College Tc'));
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
        title: const Text("Upload Tc", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 20.0,
            ),
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
                    child: const Text("Pick image"),
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
          "https://alamelumangaimatrimony.com/api/v1/user-profile/user-college-certificate-upload/$userId");

      // create multipart request
      var request = http.MultipartRequest("POST", uri);

      // multipart that takes file
      var multipartFile = http.MultipartFile('clg_tc', stream, length,
          filename: basename(imageFile.path));

      // add file to multipart
      request.headers.addAll(headers);
      request.files.add(multipartFile);

      // send
      var response = await request.send();
      //print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        testing(state: false);
        setState(() {
          Navigator.pop(context);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'CollegeTc uploaded successfully',
            ),
          ),
        );
      } else {
        testing(state: false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Something went wrong',
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
