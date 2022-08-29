// ignore_for_file: file_names

import 'package:flutter/material.dart';

class HomeScreenDrawer extends StatelessWidget {
  const HomeScreenDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: const BoxDecoration(
          image:
              DecorationImage(image: AssetImage("assets/images/banner.jpg"))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Alamelu mangai',
            style: TextStyle(
                fontSize: 30.0, color: Colors.white, fontFamily: "AkagiPro"),
          ),
          Text(
            'Matrimony',
            style: TextStyle(fontSize: 18.0, color: Colors.grey[300]),
          ),
        ],
      ),
    );
  }
}
