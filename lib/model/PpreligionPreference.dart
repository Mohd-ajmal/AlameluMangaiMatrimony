// ignore_for_file: file_names
// To parse this JSON data, do
//
//     final ppReligionPreference = ppReligionPreferenceFromJson(jsonString);

import 'dart:convert';

PpReligionPreference ppReligionPreferenceFromJson(String str) =>
    PpReligionPreference.fromJson(json.decode(str));

String ppReligionPreferenceToJson(PpReligionPreference data) =>
    json.encode(data.toJson());

class PpReligionPreference {
  PpReligionPreference({
    required this.data,
  });

  Data data;

  factory PpReligionPreference.fromJson(Map<String, dynamic> json) =>
      PpReligionPreference(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.userId,
    required this.partnerReligion,
    this.partnerCaste,
    required this.partnerRasi,
  });

  dynamic userId;
  PartnerReligion partnerReligion;
  dynamic partnerCaste;
  List<dynamic> partnerRasi;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        partnerReligion: PartnerReligion.fromJson(json["partner_religion"]),
        partnerCaste: json["partner_caste"],
        partnerRasi: List<dynamic>.from(json["partner_rasi"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "partner_religion": partnerReligion.toJson(),
        "partner_caste": partnerCaste,
        "partner_rasi": List<dynamic>.from(partnerRasi.map((x) => x)),
      };
}

class PartnerReligion {
  PartnerReligion({
    required this.id,
    required this.religionName,
  });

  dynamic id;
  String religionName;

  factory PartnerReligion.fromJson(Map<String, dynamic> json) =>
      PartnerReligion(
        id: json["id"],
        religionName: json["religion_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "religion_name": religionName,
      };
}
