// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.data,
    required this.token,
  });

  Data data;
  String token;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: Data.fromJson(json["data"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "token": token,
      };
}

class Data {
  Data(
      {required this.userId,
      required this.username,
      required this.email,
      required this.phoneNo,
      required this.profileId,
      this.statusInfo,
      required this.createdAt,
      required this.isPaid});

  int userId;
  String username;
  String email;
  String phoneNo;
  String profileId;
  String isPaid;
  dynamic statusInfo;
  String createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        username: json["username"],
        email: json["email"],
        phoneNo: json["phone_no"],
        profileId: json["profile_id"],
        isPaid: json["is_paid"],
        statusInfo: json["status_info"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "username": username,
        "email": email,
        "phone_no": phoneNo,
        "profile_id": profileId,
        "status_info": statusInfo,
        "created_at": createdAt,
      };
}
