// To parse this JSON data, do
//
//     final multiImage = multiImageFromJson(jsonString);

import 'dart:convert';

List<MultiImage> multiImageFromJson(String str) =>
    List<MultiImage>.from(json.decode(str).map((x) => MultiImage.fromJson(x)));

String multiImageToJson(List<MultiImage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MultiImage {
  MultiImage({
    this.id,
    required this.userId,
    required this.userPhoto,
    this.userPhotoStatus,
    this.createdAt,
    this.updatedAt,
    required this.imageFullPath,
  });

  int? id;
  String userId;
  String userPhoto;
  String? userPhotoStatus;
  String? createdAt;
  DateTime? updatedAt;
  String imageFullPath;

  factory MultiImage.fromJson(Map<String, dynamic> json) => MultiImage(
        id: json["id"],
        userId: json["user_id"],
        userPhoto: json["user_photo"],
        userPhotoStatus: json["user_photo_status"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        imageFullPath: json["image_full_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_photo": userPhoto,
        "user_photo_status": userPhotoStatus,
        "created_at": createdAt,
        "updated_at": updatedAt!.toIso8601String(),
        "image_full_path": imageFullPath,
      };
}
