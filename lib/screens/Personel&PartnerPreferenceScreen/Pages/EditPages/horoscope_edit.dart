import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';

class HoroscopeEdit extends StatefulWidget {
  const HoroscopeEdit({Key? key}) : super(key: key);

  @override
  State<HoroscopeEdit> createState() => _HoroscopeEditState();
}

// Hive
final box = Boxes.getTransaction();
late String userId;
String token = '';
String image = '';

class _HoroscopeEditState extends State<HoroscopeEdit> {
  File? imageUpload;
  bool _isProgress = false;
  late BuildContext _context;

  @override
  void initState() {
    super.initState();
    final transaction = box.values.toList().cast<UserModelHive>();
    userId = transaction.last.userId.toString();
    token = transaction.last.token;
    getImages();
  }

  Widget buildGridView() {
    if (imageUpload != null) {
      return GridView.count(crossAxisCount: 1, children: [
        Image.file(imageUpload!, fit: BoxFit.cover, width: 160.0, height: 160.0)
      ]);
    } else {
      return const Center(child: Text('Select image to upload horoscope pic'));
    }
  }

  Future<void> multiImage() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 300.0,
        maxHeight: 300.0,
      );
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

  getImage({required context}) {
    return Padding(
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
                width: MediaQuery.of(_context).size.width / 3,
                child: ElevatedButton(
                  child: const Text("Pick images"),
                  onPressed: multiImage,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(_context).size.width / 3,
                child: TextButton(
                  onPressed: () {
                    postPhotoToServer(title: 'title', context: _context);
                  },
                  child: const Text('Upload'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget showImage({required context}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.network(image),
          const Spacer(),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      image = "";
                    });
                  },
                  child: const Text("Re-Upload horoscope")))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    //print(image);
    return Scaffold(
        body: image.isEmpty
            ? getImage(context: context)
            : showImage(context: context));
  }

  void testing({required state}) {
    setState(() {
      _isProgress = state;
    });
  }

  Future<void> postPhotoToServer(
      {required String title, required context}) async {
    if (imageUpload == null) {
      ScaffoldMessenger.of(_context).showSnackBar(
        const SnackBar(
          content: Text('Please select a photo'),
        ),
      );
    } else {
      testing(state: true);
      upload(imageUpload!, context: _context);
    }
  }

  upload(File imageFile, {required BuildContext context}) async {
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
          "https://alamelumangaimatrimony.com/api/v1/user-profile/user-horoscope-image/$userId");

      // create multipart request
      var request = http.MultipartRequest("POST", uri);

      // multipart that takes file
      var multipartFile = http.MultipartFile(
          'user_jathakam_image', stream, length,
          filename: basename(imageFile.path));

      // add file to multipart
      request.headers.addAll(headers);
      request.files.add(multipartFile);

      // send
      var response = await request.send();
      // print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        testing(state: false);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Horoscope updated successfully',
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
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  void getImages() async {
    try {
      String url =
          'https://alamelumangaimatrimony.com/api/v1/user-profile/user-horoscope-image-get/$userId';
      var res = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      String resBody = res.body;
      //print(res.statusCode);
      var resBody2 = json.decode(resBody);
      //print(resBody2[0]['image_full_path']);

      if (res.statusCode == 200) {
        if (image.isEmpty) {
          setState(() {
            image = resBody2[0]['image_full_path'];
          });
        }
      }
    } on Exception {
      ScaffoldMessenger.of(_context).showSnackBar(const SnackBar(
          content: Text(
              "Something went wrong, while fetching image from the server")));
    }
  }
}
