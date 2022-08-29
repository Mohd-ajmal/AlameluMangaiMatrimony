// To parse this JSON data, do
//
//     final familyInfoModel = familyInfoModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

FamilyInfoModel familyInfoModelFromJson(String str) =>
    FamilyInfoModel.fromJson(json.decode(str));

String familyInfoModelToJson(FamilyInfoModel data) =>
    json.encode(data.toJson());

class FamilyInfoModel {
  FamilyInfoModel({
    required this.data,
  });

  Data data;

  factory FamilyInfoModel.fromJson(Map<String, dynamic> json) =>
      FamilyInfoModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data(
      {required this.userId,
      this.fatherName,
      this.fatherJobDetails,
      this.motherName,
      this.motherJobDetails,
      required this.familyStatus,
      required this.noOfBrothers,
      required this.noOfSisters,
      required this.noOfBrothersMarried,
      required this.noOfSistersMarried,
      this.siblingDetails,
      this.uncleAdress});

  String userId;
  dynamic fatherName;
  dynamic fatherJobDetails;
  dynamic motherName;
  dynamic motherJobDetails;
  FamilyStatus familyStatus;
  String? noOfBrothers;
  String? noOfSisters;
  String? noOfBrothersMarried;
  String? noOfSistersMarried;
  dynamic siblingDetails;
  String? uncleAdress;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      userId: json["user_id"],
      fatherName: json["father_name"],
      fatherJobDetails: json["father_job_details"],
      motherName: json["mother_name"],
      motherJobDetails: json["mother_job_details"],
      familyStatus: FamilyStatus.fromJson(json["family_status"]),
      noOfBrothers: json["no_of_brothers"],
      noOfSisters: json["no_of_sisters"],
      noOfBrothersMarried: json["no_of_brothers_married"],
      noOfSistersMarried: json["no_of_sisters_married"],
      siblingDetails: json["sibling_details"],
      uncleAdress: json["paternal_uncle_address"]);

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "father_name": fatherName,
        "father_job_details": fatherJobDetails,
        "mother_name": motherName,
        "mother_job_details": motherJobDetails,
        "family_status": familyStatus.toJson(),
        "no_of_brothers": noOfBrothers,
        "no_of_sisters": noOfSisters,
        "no_of_brothers_married": noOfBrothersMarried,
        "no_of_sisters_married": noOfSistersMarried,
        "sibling_details": siblingDetails,
        "paternal_uncle_address": uncleAdress
      };
}

class FamilyStatus {
  FamilyStatus({
    required this.id,
    required this.familyType,
  });

  dynamic id;
  String familyType;

  factory FamilyStatus.fromJson(Map<String, dynamic> json) => FamilyStatus(
        id: json["id"],
        familyType: json["family_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "family_type": familyType,
      };
}
