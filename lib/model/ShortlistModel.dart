// To parse this JSON data, do
//
//     final shortlistModel = shortlistModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

ShortlistModel shortlistModelFromJson(String str) =>
    ShortlistModel.fromJson(json.decode(str));

String shortlistModelToJson(ShortlistModel data) => json.encode(data.toJson());

class ShortlistModel {
  ShortlistModel({
    required this.data,
  });

  Data data;

  factory ShortlistModel.fromJson(Map<String, dynamic> json) => ShortlistModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  int currentPage;
  List<Datum3> data;
  String firstPageUrl;
  int? from;
  int? lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Datum3>.from(json["data"].map((x) => Datum3.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum3 {
  Datum3({
    required this.id,
    required this.userId,
    required this.shortlistedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.userShortListInfo,
    required this.shortlistBasicInfo,
  });

  int id;
  String userId;
  String shortlistedBy;
  DateTime createdAt;
  DateTime updatedAt;
  UserShortListInfo userShortListInfo;
  ShortlistBasicInfo? shortlistBasicInfo;

  factory Datum3.fromJson(Map<String, dynamic> json) => Datum3(
        id: json["id"],
        userId: json["user_id"],
        shortlistedBy: json["shortlisted_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userShortListInfo:
            UserShortListInfo.fromJson(json["user_short_list_info"]),
        shortlistBasicInfo: json["shortlist_basic_info"] == null
            ? null
            : ShortlistBasicInfo.fromJson(json["shortlist_basic_info"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "shortlisted_by": shortlistedBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_short_list_info": userShortListInfo.toJson(),
        "shortlist_basic_info":
            shortlistBasicInfo == null ? null : shortlistBasicInfo!.toJson(),
      };
}

class ShortlistBasicInfo {
  ShortlistBasicInfo({
    required this.id,
    required this.userId,
    required this.userFullName,
    required this.userMobileNo,
    this.userProfileImage,
    required this.dob,
    required this.bloodGroup,
    this.about,
    required this.userAddress,
    required this.age,
    required this.isTenthPassed,
    this.adhardCardNo,
    this.adhardCardImage,
    required this.adhardCardImageIsUploaded,
    this.medicalCertificate,
    required this.medicalCertificateUploadedOn,
    this.tenthMarksheet,
    required this.tenthMarkSheetUploaded,
    this.twelthMarksheet,
    required this.twelthMarkSheetUploaded,
    this.clgTc,
    required this.clgTcIsUploaded,
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
  });

  String id;
  int userId;
  String userFullName;
  String userMobileNo;
  dynamic userProfileImage;
  DateTime dob;
  String? bloodGroup;
  dynamic about;
  String? userAddress;
  String? age;
  String isTenthPassed;
  dynamic adhardCardNo;
  dynamic adhardCardImage;
  String adhardCardImageIsUploaded;
  dynamic medicalCertificate;
  DateTime medicalCertificateUploadedOn;
  dynamic tenthMarksheet;
  String tenthMarkSheetUploaded;
  dynamic twelthMarksheet;
  String twelthMarkSheetUploaded;
  dynamic clgTc;
  String clgTcIsUploaded;
  String genderId;
  String? userHeightId;
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

  factory ShortlistBasicInfo.fromJson(Map<String, dynamic> json) =>
      ShortlistBasicInfo(
        id: json["id"],
        userId: json["user_id"],
        userFullName: json["user_full_name"],
        userMobileNo: json["user_mobile_no"],
        userProfileImage: json["user_profile_image"],
        dob: DateTime.parse(json["dob"]),
        bloodGroup: json["blood_group"],
        about: json["about"],
        userAddress: json["user_address"],
        age: json["age"],
        isTenthPassed: json["is_tenth_passed"],
        adhardCardNo: json["adhard_card_no"],
        adhardCardImage: json["adhard_card_image"],
        adhardCardImageIsUploaded: json["adhard_card_image_is_uploaded"],
        medicalCertificate: json["medical_certificate"],
        medicalCertificateUploadedOn:
            DateTime.parse(json["medical_certificate_uploaded_on"]),
        tenthMarksheet: json["tenth_marksheet"],
        tenthMarkSheetUploaded: json["tenth_mark_sheet_uploaded"],
        twelthMarksheet: json["twelth_marksheet"],
        twelthMarkSheetUploaded: json["twelth_mark_sheet_uploaded"],
        clgTc: json["clg_tc"],
        clgTcIsUploaded: json["clg_tc_is_uploaded"],
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_full_name": userFullName,
        "user_mobile_no": userMobileNo,
        "user_profile_image": userProfileImage,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "blood_group": bloodGroup,
        "about": about,
        "user_address": userAddress,
        "age": age,
        "is_tenth_passed": isTenthPassed,
        "adhard_card_no": adhardCardNo,
        "adhard_card_image": adhardCardImage,
        "adhard_card_image_is_uploaded": adhardCardImageIsUploaded,
        "medical_certificate": medicalCertificate,
        "medical_certificate_uploaded_on":
            medicalCertificateUploadedOn.toIso8601String(),
        "tenth_marksheet": tenthMarksheet,
        "tenth_mark_sheet_uploaded": tenthMarkSheetUploaded,
        "twelth_marksheet": twelthMarksheet,
        "twelth_mark_sheet_uploaded": twelthMarkSheetUploaded,
        "clg_tc": clgTc,
        "clg_tc_is_uploaded": clgTcIsUploaded,
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
      };
}

class UserShortListInfo {
  UserShortListInfo({
    required this.id,
    required this.username,
    required this.email,
    required this.phonenumber,
    required this.userProfileId,
    required this.profileStatusId,
    required this.isAdmin,
    required this.isVerified,
    required this.isPaid,
    required this.emailVerifiedAt,
    this.token,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String username;
  String email;
  String phonenumber;
  String userProfileId;
  String profileStatusId;
  String isAdmin;
  String isVerified;
  String isPaid;
  DateTime? emailVerifiedAt;
  dynamic token;
  dynamic deletedAt;
  String createdAt;
  DateTime updatedAt;

  factory UserShortListInfo.fromJson(Map<String, dynamic> json) =>
      UserShortListInfo(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        phonenumber: json["phonenumber"],
        userProfileId: json["user_profile_id"],
        profileStatusId: json["profile_status_id"],
        isAdmin: json["is_admin"],
        isVerified: json["is_verified"],
        isPaid: json["is_paid"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        token: json["token"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "phonenumber": phonenumber,
        "user_profile_id": userProfileId,
        "profile_status_id": profileStatusId,
        "is_admin": isAdmin,
        "is_verified": isVerified,
        "is_paid": isPaid,
        "email_verified_at":
            emailVerifiedAt == null ? null : emailVerifiedAt!.toIso8601String(),
        "token": token,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
