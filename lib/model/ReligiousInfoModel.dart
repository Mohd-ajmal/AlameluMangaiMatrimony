// To parse this JSON data, do
//
//     final religiousInfoModel = religiousInfoModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

ReligiousInfoModel religiousInfoModelFromJson(String str) =>
    ReligiousInfoModel.fromJson(json.decode(str));

String religiousInfoModelToJson(ReligiousInfoModel data) =>
    json.encode(data.toJson());

class ReligiousInfoModel {
  ReligiousInfoModel({
    required this.data,
  });

  Data data;

  factory ReligiousInfoModel.fromJson(Map<String, dynamic> json) =>
      ReligiousInfoModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.religion,
    required this.caste,
    this.subCaste,
    required this.rasi,
    required this.star,
    this.birthTime,
    this.birthPlace,
    required this.dhosam,
  });

  String id;
  Religion religion;
  Caste caste;
  dynamic subCaste;
  Rasi rasi;
  Star star;
  dynamic birthTime;
  dynamic birthPlace;
  String dhosam;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        religion: Religion.fromJson(json["religion"]),
        caste: Caste.fromJson(json["caste"]),
        subCaste: json["sub_caste"],
        rasi: Rasi.fromJson(json["rasi"]),
        star: Star.fromJson(json["star"]),
        birthTime: json["birth_time"],
        birthPlace: json["birth_place"],
        dhosam: json["dhosam"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "religion": religion.toJson(),
        "caste": caste.toJson(),
        "sub_caste": subCaste,
        "rasi": rasi.toJson(),
        "star": star.toJson(),
        "birth_time": birthTime,
        "birth_place": birthPlace,
        "dhosam": dhosam,
      };
}

class Caste {
  Caste({
    required this.id,
    required this.casteName,
    required this.casteReligion,
  });

  int id;
  String casteName;
  String casteReligion;

  factory Caste.fromJson(Map<String, dynamic> json) => Caste(
        id: json["id"],
        casteName: json["caste_name"],
        casteReligion: json["caste_religion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "caste_name": casteName,
        "caste_religion": casteReligion,
      };
}

class Rasi {
  Rasi({
    required this.id,
    required this.rasi,
  });

  dynamic id;
  String rasi;

  factory Rasi.fromJson(Map<String, dynamic> json) => Rasi(
        id: json["id"],
        rasi: json["rasi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rasi": rasi,
      };
}

class Religion {
  Religion({
    required this.id,
    required this.religionName,
  });

  int id;
  String religionName;

  factory Religion.fromJson(Map<String, dynamic> json) => Religion(
        id: json["id"],
        religionName: json["religion_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "religion_name": religionName,
      };
}

class Star {
  Star({
    required this.id,
    required this.star,
  });

  dynamic id;
  String star;

  factory Star.fromJson(Map<String, dynamic> json) => Star(
        id: json["id"],
        star: json["star"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "star": star,
      };
}
