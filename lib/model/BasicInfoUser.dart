// To parse this JSON data, do
//
//     final basicInfoUserModel = basicInfoUserModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

BasicInfoUserModel basicInfoUserModelFromJson(String str) =>
    BasicInfoUserModel.fromJson(json.decode(str));

String basicInfoUserModelToJson(BasicInfoUserModel data) =>
    json.encode(data.toJson());

class BasicInfoUserModel {
  BasicInfoUserModel({
    required this.data,
  });

  Data data;

  factory BasicInfoUserModel.fromJson(Map<String, dynamic> json) =>
      BasicInfoUserModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.userId,
    required this.userFullName,
    required this.userMobileNo,
    required this.userProfileImage,
    required this.dob,
    required this.about,
    required this.age,
    required this.userAddress,
    required this.bloodGroup,
    required this.tenthPassed,
    this.aadharCardNo,
    this.adhardCardImage,
    required this.adhardCardImageIsUploaded,
    required this.medicalCertificate,
    this.tenthMarksheet,
    required this.tenthMarkSheetUploaded,
    this.twelthMarksheet,
    required this.twelthMarkSheetUploaded,
    this.clgTc,
    required this.clgTcIsUploaded,
    required this.gender,
    required this.height,
    required this.language,
    required this.martialStatus,
    required this.eatingHabit,
    required this.complexion,
    required this.isDisable,
    required this.profileBasicFilledStatus,
    required this.profileReligionFilledStatus,
    required this.profileLocationFilledStatus,
    required this.profileProInfoFilledStatus,
    required this.profileFamInfoFilledStatus,
    required this.profileJaktInfoFilledStatus,
    required this.profilePrefInfoFilledStatus,
  });

  int userId;
  String userFullName;
  String userMobileNo;
  String? userProfileImage;
  DateTime dob;
  String? about;
  String? age;
  String? userAddress;
  String? bloodGroup;
  String? tenthPassed;
  String? aadharCardNo;
  dynamic adhardCardImage;
  String adhardCardImageIsUploaded;
  String medicalCertificate;
  dynamic tenthMarksheet;
  String tenthMarkSheetUploaded;
  dynamic twelthMarksheet;
  String twelthMarkSheetUploaded;
  dynamic clgTc;
  String clgTcIsUploaded;
  Gender gender;
  Height height;
  Language language;
  MartialStatus martialStatus;
  EatingHabit eatingHabit;
  Complexion complexion;
  String? isDisable;
  String profileBasicFilledStatus;
  String profileReligionFilledStatus;
  String profileLocationFilledStatus;
  String profileProInfoFilledStatus;
  String profileFamInfoFilledStatus;
  String profileJaktInfoFilledStatus;
  String profilePrefInfoFilledStatus;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        userFullName: json["user_full_name"],
        userMobileNo: json["user_mobile_no"],
        userProfileImage: json["user_profile_image"],
        dob: DateTime.parse(json["dob"]),
        about: json["about"],
        age: json["age"],
        userAddress: json["user_address"],
        bloodGroup: json["blood_group"],
        tenthPassed: json["tenth_passed"],
        aadharCardNo: json["aadhar_card_no"],
        adhardCardImage: json["adhard_card_image"],
        adhardCardImageIsUploaded: json["adhard_card_image_status"],
        medicalCertificate: json["medical_certificate_status"],
        tenthMarksheet: json["tenth_marksheet"],
        tenthMarkSheetUploaded: json["tenth_mark_sheet_status"],
        twelthMarksheet: json["twelth_marksheet"],
        twelthMarkSheetUploaded: json["twelth_mark_sheet_status "],
        clgTc: json["clg_tc"],
        clgTcIsUploaded: json["clg_tc_status"],
        gender: Gender.fromJson(json["gender"]),
        height: Height.fromJson(json["height"]),
        language: Language.fromJson(json["language"]),
        martialStatus: MartialStatus.fromJson(json["martial_status"]),
        eatingHabit: EatingHabit.fromJson(json["eating_habit"]),
        complexion: Complexion.fromJson(json["complexion"]),
        isDisable: json["is_disable"],
        profileBasicFilledStatus: json["profile_basic_filled_status"],
        profileReligionFilledStatus: json["profile_religion_filled_status"],
        profileLocationFilledStatus: json["profile_location_filled_status"],
        profileProInfoFilledStatus: json["profile_pro_info_filled_status"],
        profileFamInfoFilledStatus: json["profile_fam_info_filled_status"],
        profileJaktInfoFilledStatus: json["profile_jakt_info_filled_status"],
        profilePrefInfoFilledStatus: json["profile_pref_info_filled_status"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_full_name": userFullName,
        "user_mobile_no": userMobileNo,
        "user_profile_image": userProfileImage,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "about": about,
        "age": age,
        "user_address": userAddress,
        "blood_group": bloodGroup,
        "tenth_passed": tenthPassed,
        "aadhar_card_no": aadharCardNo,
        "adhard_card_image": adhardCardImage,
        "adhard_card_image_is_uploaded": adhardCardImageIsUploaded,
        "medical_certificate ": medicalCertificate,
        "tenth_marksheet": tenthMarksheet,
        "tenth_mark_sheet_uploaded": tenthMarkSheetUploaded,
        "twelth_marksheet": twelthMarksheet,
        "twelth_mark_sheet_uploaded ": twelthMarkSheetUploaded,
        "clg_tc": clgTc,
        "clg_tc_is_uploaded": clgTcIsUploaded,
        "gender": gender.toJson(),
        "height": height.toJson(),
        "language": language.toJson(),
        "martial_status": martialStatus.toJson(),
        "eating_habit": eatingHabit.toJson(),
        "complexion": complexion.toJson(),
        "is_disable": isDisable,
        "profile_basic_filled_status": profileBasicFilledStatus,
        "profile_religion_filled_status": profileReligionFilledStatus,
        "profile_location_filled_status": profileLocationFilledStatus,
        "profile_pro_info_filled_status": profileProInfoFilledStatus,
        "profile_fam_info_filled_status": profileFamInfoFilledStatus,
        "profile_jakt_info_filled_status": profileJaktInfoFilledStatus,
        "profile_pref_info_filled_status": profilePrefInfoFilledStatus,
      };
}

class Complexion {
  Complexion({
    required this.id,
    required this.complexion,
  });

  dynamic id;
  String complexion;

  factory Complexion.fromJson(Map<String, dynamic> json) => Complexion(
        id: json["id"],
        complexion: json["complexion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "complexion": complexion,
      };
}

class EatingHabit {
  EatingHabit({
    required this.id,
    required this.habit,
  });

  dynamic id;
  String habit;

  factory EatingHabit.fromJson(Map<String, dynamic> json) => EatingHabit(
        id: json["id"],
        habit: json["habit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "habit": habit,
      };
}

class Gender {
  Gender({
    required this.id,
    required this.gender,
  });

  int id;
  String gender;

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
        id: json["id"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gender": gender,
      };
}

class Height {
  Height({
    required this.id,
    required this.height,
  });

  dynamic id;
  String height;

  factory Height.fromJson(Map<String, dynamic> json) => Height(
        id: json["id"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "height": height,
      };
}

class Language {
  Language({
    required this.id,
    required this.language,
  });

  dynamic id;
  String language;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json["id"],
        language: json["language"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "language": language,
      };
}

class MartialStatus {
  MartialStatus({
    required this.id,
    required this.martialStatus,
  });

  dynamic id;
  String martialStatus;

  factory MartialStatus.fromJson(Map<String, dynamic> json) => MartialStatus(
        id: json["id"],
        martialStatus: json["martial_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "martial_status": martialStatus,
      };
}
