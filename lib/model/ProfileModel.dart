// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ProfileModel {
  late String image;
  late String name;
  late String ageAndHeight;
  late String state;
  late String profession;
  late Icon icon;

  ProfileModel(
      {required this.image,
      required this.name,
      required this.ageAndHeight,
      required this.state});

  ProfileModel.matches(
      {required this.image,
      required this.name,
      required this.ageAndHeight,
      required this.state,
      required this.profession,
      required this.icon});
}
