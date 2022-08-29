// ignore_for_file: file_names
// To parse this JSON data, do
//
//     final ppBasicInfo = ppBasicInfoFromJson(jsonString);

import 'dart:convert';

PpBasicInfo ppBasicInfoFromJson(String str) =>
    PpBasicInfo.fromJson(json.decode(str));

String ppBasicInfoToJson(PpBasicInfo data) => json.encode(data.toJson());

class PpBasicInfo {
  PpBasicInfo({
    required this.data,
  });

  Data data;

  factory PpBasicInfo.fromJson(Map<String, dynamic> json) => PpBasicInfo(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.userId,
    this.partnerAgeFrom,
    this.partnerAgeTo,
    required this.partnerHeightFrom,
    required this.partnerHeightTo,
    required this.partnerMartialStatusPrefer,
    required this.partnerComplexion,
    required this.partnerMotherTongue,
    required this.partnerCountry,
  });

  int userId;
  dynamic partnerAgeFrom;
  dynamic partnerAgeTo;
  PartnerHeight partnerHeightFrom;
  PartnerHeight partnerHeightTo;
  PartnerMartialStatusPrefer partnerMartialStatusPrefer;
  List<dynamic> partnerComplexion;
  List<dynamic> partnerMotherTongue;
  List<dynamic> partnerCountry;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        partnerAgeFrom: json["partner_age_from"],
        partnerAgeTo: json["partner_age_to"],
        partnerHeightFrom: PartnerHeight.fromJson(json["partner_height_from"]),
        partnerHeightTo: PartnerHeight.fromJson(json["partner_height_to"]),
        partnerMartialStatusPrefer: PartnerMartialStatusPrefer.fromJson(
            json["partner_martial_status_prefer"]),
        partnerComplexion:
            List<dynamic>.from(json["partner_complexion"].map((x) => x)),
        partnerMotherTongue:
            List<dynamic>.from(json["partner_mother_tongue"].map((x) => x)),
        partnerCountry:
            List<dynamic>.from(json["partner_country"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "partner_age_from": partnerAgeFrom,
        "partner_age_to": partnerAgeTo,
        "partner_height_from": partnerHeightFrom.toJson(),
        "partner_height_to": partnerHeightTo.toJson(),
        "partner_martial_status_prefer": partnerMartialStatusPrefer.toJson(),
        "partner_complexion":
            List<dynamic>.from(partnerComplexion.map((x) => x)),
        "partner_mother_tongue":
            List<dynamic>.from(partnerMotherTongue.map((x) => x)),
        "partner_country": List<dynamic>.from(partnerCountry.map((x) => x)),
      };
}

class PartnerHeight {
  PartnerHeight({
    required this.id,
    required this.height,
  });

  dynamic id;
  String height;

  factory PartnerHeight.fromJson(Map<String, dynamic> json) => PartnerHeight(
        id: json["id"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "height": height,
      };
}

class PartnerMartialStatusPrefer {
  PartnerMartialStatusPrefer({
    required this.id,
    required this.martialStatus,
  });

  dynamic id;
  String martialStatus;

  factory PartnerMartialStatusPrefer.fromJson(Map<String, dynamic> json) =>
      PartnerMartialStatusPrefer(
        id: json["id"],
        martialStatus: json["martial_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "martial_status": martialStatus,
      };
}
