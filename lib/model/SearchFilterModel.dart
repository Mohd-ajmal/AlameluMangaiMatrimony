// To parse this JSON data, do
//
//     final searchFilterModel = searchFilterModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

SearchFilterModel searchFilterModelFromJson(String str) =>
    SearchFilterModel.fromJson(json.decode(str));

String searchFilterModelToJson(SearchFilterModel data) =>
    json.encode(data.toJson());

class SearchFilterModel {
  SearchFilterModel({
    required this.data,
  });

  Data data;

  factory SearchFilterModel.fromJson(Map<String, dynamic> json) =>
      SearchFilterModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.userId,
    required this.username,
    required this.email,
    required this.phoneNo,
    required this.profileId,
    required this.match,
    required this.userBasicInfo,
    required this.createdAt,
  });

  int userId;
  String username;
  String email;
  String phoneNo;
  String profileId;
  int? match;
  UserBasicInfo userBasicInfo;
  String createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        username: json["username"],
        email: json["email"],
        phoneNo: json["phone_no"],
        profileId: json["profile_id"],
        match: json["match"],
        userBasicInfo: UserBasicInfo.fromJson(json["user_basic_info"]),
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "username": username,
        "email": email,
        "phone_no": phoneNo,
        "profile_id": profileId,
        "match": match,
        "user_basic_info": userBasicInfo.toJson(),
        "created_at": createdAt,
      };
}

class UserBasicInfo {
  UserBasicInfo({
    required this.id,
    required this.userId,
    required this.userFullName,
    required this.userMobileNo,
    required this.userProfileImage,
    required this.dob,
    required this.about,
    required this.age,
    required this.genderId,
    this.userHeightId,
    this.userMotherTongue,
    this.martialId,
    this.userEatingHabitId,
    this.userComplexionId,
    this.isDisable,
    required this.profileBasicStatus,
    required this.profileReligionStatus,
    required this.profileLocationStatus,
    required this.profileProInfoStatus,
    required this.profileFamInfoStatus,
    required this.profileJaktInfoStatus,
    required this.profilePrefInfoStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.imageWithPath,
  });

  String? id;
  int userId;
  String userFullName;
  String userMobileNo;
  dynamic userProfileImage;
  DateTime dob;
  dynamic about;
  dynamic age;
  String? genderId;
  dynamic userHeightId;
  dynamic userMotherTongue;
  dynamic martialId;
  dynamic userEatingHabitId;
  dynamic userComplexionId;
  dynamic isDisable;
  String? profileBasicStatus;
  String? profileReligionStatus;
  String? profileLocationStatus;
  String? profileProInfoStatus;
  String? profileFamInfoStatus;
  String? profileJaktInfoStatus;
  String? profilePrefInfoStatus;
  String? createdAt;
  String? updatedAt;
  dynamic imageWithPath;

  factory UserBasicInfo.fromJson(Map<String, dynamic> json) => UserBasicInfo(
        id: json["id"],
        userId: json["user_id"],
        userFullName: json["user_full_name"],
        userMobileNo: json["user_mobile_no"],
        userProfileImage: json["user_profile_image"],
        dob: DateTime.parse(json["dob"]),
        about: json["about"],
        age: json["age"],
        genderId: json["gender_id"],
        userHeightId: json["user_height_id"],
        userMotherTongue: json["user_mother_tongue"],
        martialId: json["martial_id"],
        userEatingHabitId: json["user_eating_habit_id"],
        userComplexionId: json["user_complexion_id"],
        isDisable: json["is_disable"],
        profileBasicStatus: json["profile_basic_status"],
        profileReligionStatus: json["profile_religion_status"],
        profileLocationStatus: json["profile_location_status"],
        profileProInfoStatus: json["profile_pro_info_status"],
        profileFamInfoStatus: json["profile_fam_info_status"],
        profileJaktInfoStatus: json["profile_jakt_info_status"],
        profilePrefInfoStatus: json["profile_pref_info_status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        imageWithPath: json["image_with_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_full_name": userFullName,
        "user_mobile_no": userMobileNo,
        "user_profile_image": userProfileImage,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "about": about,
        "age": age,
        "gender_id": genderId,
        "user_height_id": userHeightId,
        "user_mother_tongue": userMotherTongue,
        "martial_id": martialId,
        "user_eating_habit_id": userEatingHabitId,
        "user_complexion_id": userComplexionId,
        "is_disable": isDisable,
        "profile_basic_status": profileBasicStatus,
        "profile_religion_status": profileReligionStatus,
        "profile_location_status": profileLocationStatus,
        "profile_pro_info_status": profileProInfoStatus,
        "profile_fam_info_status": profileFamInfoStatus,
        "profile_jakt_info_status": profileJaktInfoStatus,
        "profile_pref_info_status": profilePrefInfoStatus,
        "created_at": createdAt!,
        "updated_at": updatedAt,
        "image_with_path": imageWithPath,
      };
}
