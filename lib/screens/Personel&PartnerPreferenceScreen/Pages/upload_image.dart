import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:matrimony/model/multi_image.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/BoxTransaction.dart';
import 'package:matrimony/screens/SignIn&SignUpScreen/HiveDatabase/UserModelHive.dart';
import 'package:path/path.dart';

class UploadImges extends StatefulWidget {
  const UploadImges({Key? key}) : super(key: key);

  @override
  _UploadImgesState createState() => _UploadImgesState();
}

// Hive
final box = Boxes.getTransaction();
String userId = '';
String token = '';

List<String> _images = [];

class _UploadImgesState extends State<UploadImges> {
  List<File>? imageUpload;
  String? _error;
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
      return GridView.count(
        crossAxisCount: 3,
        children: List.generate(imageUpload!.length, (index) {
          File file = imageUpload![index];
          return Image.file(file, fit: BoxFit.cover, width: 50.0, height: 50.0);
        }),
      );
    } else {
      return const Center(child: Text('Select images to upload multi images'));
    }
  }

  void testing({required state}) {
    setState(() {
      _isProgress = state;
    });
  }

  Future<void> multiImage() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final image = await _picker.pickMultiImage(
          maxWidth: 300.0, maxHeight: 300.0, imageQuality: 100);
      if (image == null) return;
      List<File> fileImage = [];

      for (int i = 0; i < image.length; i++) {
        fileImage.add(File(image[i].path));
      }
      setState(() {
        imageUpload = fileImage;
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(_context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  checkForPhotos() {
    if (imageUpload == null) {
      ScaffoldMessenger.of(_context).showSnackBar(
          const SnackBar(content: Text("Please select photo to upload")));
    } else {
      setState(() {
        _isProgress = true;
      });
      uploadmultipleimage(imageUpload!, context);
    }
  }

  Widget selectImage() {
    return Column(
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
                  //postPhotoToServer(title: 'title', context: context);
                  checkForPhotos();
                },
                child: const Text('Upload'),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget showImage() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(_images.length, (index) {
        return Image.network(_images[index]);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(body: _images.isEmpty ? selectImage() : showImage());
  }

  Future uploadmultipleimage(List<File> images, context) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };
    var uri = Uri.parse(
        "https://alamelumangaimatrimony.com/api/v1/user-profile/user-multiple-image-upload");

// create multipart request
    var request = http.MultipartRequest("POST", uri);

    for (var file in images) {
      String fileName = file.path.split("/").last;
      var stream = http.ByteStream(Stream.castFrom(file.openRead()));

      // get file length

      var length = await file.length(); //imageFile is your image file

      // multipart that takes file
      var multipartFileSign =
          http.MultipartFile('file[]', stream, length, filename: fileName);

      request.files.add(multipartFileSign);
    } // ignore this headers if there is no authentication

//add headers
    request.headers.addAll(headers);

//adding params
    request.fields['user_id'] = userId;
    //print(userId);
    //request.fields['file[]'] = images;

// send
    var response = await request.send();

    //print(response.statusCode);
    // print(response.stream.toString());

    if (response.statusCode == 200) {
      setState(() {
        _isProgress = false;
      });
      ScaffoldMessenger.of(_context).showSnackBar(
          const SnackBar(content: Text('Photo uploaded successfully')));
    } else {
      setState(() {
        _isProgress = false;
      });
      ScaffoldMessenger.of(_context)
          .showSnackBar(const SnackBar(content: Text('Something went wrong')));
    }

// listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      var body = json.decode(value);
      ScaffoldMessenger.of(_context)
          .showSnackBar(SnackBar(content: Text(body['message'])));
    });
  }

  void getImages() async {
    try {
      String url =
          'https://alamelumangaimatrimony.com/api/v1/user-profile/user-multiple-image-get/$userId';
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
        // print(images[0].imageFullPath);
        if (images.isEmpty) {
          _images = [];
        } else {
          if (mounted) {
            setState(() {
              _images = images.map((e) => e.imageFullPath).toList();
            });
          }
        }
      }
    } on Exception {
      ScaffoldMessenger.of(_context).showSnackBar(const SnackBar(
          content: Text(
              "Something went wrong, while fetching image from the server")));
    }
  }
}
