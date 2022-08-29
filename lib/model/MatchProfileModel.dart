// ignore_for_file: file_names, constant_identifier_names

// To parse this JSON data, do
//
//     final profileMatchModel = profileMatchModelFromJson(jsonString);

import 'dart:convert';

List<ProfileMatchModel> profileMatchModelFromJson(String str) =>
    List<ProfileMatchModel>.from(json.decode(str));

String profileMatchModelToJson(List<ProfileMatchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfileMatchModel {
  ProfileMatchModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.phoneNo,
    required this.profileId,
    required this.match,
    required this.statusInfo,
    required this.userBasicInfo,
    required this.userReligionInfo,
    required this.userNativeInfo,
    required this.createdAt,
  });

  int userId;
  String username;
  String email;
  String phoneNo;
  String profileId;
  int match;
  StatusInfo statusInfo;
  UserBasicInfo userBasicInfo;
  UserReligionInfo userReligionInfo;
  UserNativeInfo userNativeInfo;
  CreatedAt? createdAt;

  factory ProfileMatchModel.fromJson(Map<String, dynamic> json) =>
      ProfileMatchModel(
        userId: json["user_id"],
        username: json["username"],
        email: json["email"],
        phoneNo: json["phone_no"],
        profileId: json["profile_id"],
        match: json["match"],
        statusInfo: StatusInfo.fromJson(json["status_info"]),
        userBasicInfo: UserBasicInfo.fromJson(json["user_basic_info"]),
        userReligionInfo: UserReligionInfo.fromJson(json["user_religion_info"]),
        userNativeInfo: UserNativeInfo.fromJson(json["user_native_info"]),
        createdAt: createdAtValues.map[json["created_at"]],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "username": username,
        "email": email,
        "phone_no": phoneNo,
        "profile_id": profileId,
        "match": match,
        "status_info": statusInfo.toJson(),
        "user_basic_info": userBasicInfo.toJson(),
        "user_religion_info": userReligionInfo.toJson(),
        "user_native_info": userNativeInfo.toJson(),
        "created_at": createdAtValues.reverse[createdAt],
      };
}

enum CreatedAt { THE_240522 }

final createdAtValues = EnumValues({"24-05-22": CreatedAt.THE_240522});

class StatusInfo {
  StatusInfo({
    required this.id,
    required this.statusName,
    required this.statusStatus,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String statusName;
  String statusStatus;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory StatusInfo.fromJson(Map<String, dynamic> json) => StatusInfo(
        id: json["id"],
        statusName: json["status_name"],
        statusStatus: json["status_status"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status_name": statusName,
        "status_status": statusStatus,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class UserBasicInfo {
  UserBasicInfo({
    required this.id,
    required this.userId,
    required this.userFullName,
    required this.userMobileNo,
    this.userProfileImage,
    required this.dob,
    this.about,
    required this.age,
    required this.genderId,
    required this.userHeightId,
    required this.userMotherTongue,
    required this.martialId,
    required this.userEatingHabitId,
    required this.userComplexionId,
    required this.isDisable,
    required this.profileBasicStatus,
    required this.profileReligionStatus,
    required this.profileLocationStatus,
    required this.profileProInfoStatus,
    required this.profileFamInfoStatus,
    required this.profileJaktInfoStatus,
    required this.profilePrefInfoStatus,
    required this.createdAt,
    required this.updatedAt,
    this.imageWithPath,
    required this.gender,
  });

  String id;
  int userId;
  String userFullName;
  String userMobileNo;
  dynamic userProfileImage;
  DateTime dob;
  dynamic about;
  String age;
  String genderId;
  String userHeightId;
  String userMotherTongue;
  String martialId;
  String userEatingHabitId;
  String userComplexionId;
  String isDisable;
  String profileBasicStatus;
  String profileReligionStatus;
  String profileLocationStatus;
  String profileProInfoStatus;
  String profileFamInfoStatus;
  String profileJaktInfoStatus;
  String profilePrefInfoStatus;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic imageWithPath;
  Gender gender;

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
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        imageWithPath: json["image_with_path"],
        gender: Gender.fromJson(json["gender"]),
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "image_with_path": imageWithPath,
        "gender": gender.toJson(),
      };
}

class Gender {
  Gender({
    required this.id,
    required this.genderName,
    required this.genderStatus,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  GenderName? genderName;
  String genderStatus;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
        id: json["id"],
        genderName: genderNameValues.map[json["gender_name"]],
        genderStatus: json["gender_status"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gender_name": genderNameValues.reverse[genderName],
        "gender_status": genderStatus,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

enum GenderName { FEMALE }

final genderNameValues = EnumValues({"Female": GenderName.FEMALE});

class UserNativeInfo {
  UserNativeInfo({
    required this.id,
    required this.userId,
    required this.userCountryId,
    required this.userStateId,
    required this.userCityId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String userId;
  String userCountryId;
  String userStateId;
  String userCityId;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserNativeInfo.fromJson(Map<String, dynamic> json) => UserNativeInfo(
        id: json["id"],
        userId: json["user_id"],
        userCountryId: json["user_country_id"],
        userStateId: json["user_state_id"],
        userCityId: json["user_city_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_country_id": userCountryId,
        "user_state_id": userStateId,
        "user_city_id": userCityId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class UserReligionInfo {
  UserReligionInfo({
    required this.id,
    required this.userId,
    required this.userReligionId,
    required this.userCasteId,
    required this.subCaste,
    required this.userRasiId,
    required this.userStarId,
    required this.dhosam,
    this.dhosamDetails,
    required this.userBirthTime,
    required this.userBirthPlace,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String userId;
  String userReligionId;
  String userCasteId;
  String subCaste;
  String userRasiId;
  String userStarId;
  String dhosam;
  dynamic dhosamDetails;
  String userBirthTime;
  String userBirthPlace;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserReligionInfo.fromJson(Map<String, dynamic> json) =>
      UserReligionInfo(
        id: json["id"],
        userId: json["user_id"],
        userReligionId: json["user_religion_id"],
        userCasteId: json["user_caste_id"],
        subCaste: json["sub_caste"],
        userRasiId: json["user_rasi_id"],
        userStarId: json["user_star_id"],
        dhosam: json["dhosam"],
        dhosamDetails: json["dhosam_details"],
        userBirthTime: json["user_birth_time"],
        userBirthPlace: json["user_birth_place"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_religion_id": userReligionId,
        "user_caste_id": userCasteId,
        "sub_caste": subCaste,
        "user_rasi_id": userRasiId,
        "user_star_id": userStarId,
        "dhosam": dhosam,
        "dhosam_details": dhosamDetails,
        "user_birth_time": userBirthTime,
        "user_birth_place": userBirthPlace,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class EnumValues<T> {
  Map<String, T> map = {};
  Map<T, String> reverseMap = {};

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap;
    return reverseMap;
  }
}
