// ignore_for_file: file_names
// To parse this JSON data, do
//
//     final ppProffestionalModel = ppProffestionalModelFromJson(jsonString);

import 'dart:convert';

PpProffestionalModel ppProffestionalModelFromJson(String str) =>
    PpProffestionalModel.fromJson(json.decode(str));

String ppProffestionalModelToJson(PpProffestionalModel data) =>
    json.encode(data.toJson());

class PpProffestionalModel {
  PpProffestionalModel({
    required this.data,
  });

  Data data;

  factory PpProffestionalModel.fromJson(Map<String, dynamic> json) =>
      PpProffestionalModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.partnerEducation,
    this.partnerEducationDetails,
    required this.partnerJob,
    this.partnerJobDetails,
    required this.partnerJobCountry,
    required this.partnerSalary,
  });

  List<dynamic> partnerEducation;
  dynamic partnerEducationDetails;
  List<dynamic> partnerJob;
  dynamic partnerJobDetails;
  List<dynamic> partnerJobCountry;
  dynamic partnerSalary;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        partnerEducation:
            List<dynamic>.from(json["partner_education"].map((x) => x)),
        partnerEducationDetails: json["partner_education_details"],
        partnerJob: List<dynamic>.from(json["partner_job"].map((x) => x)),
        partnerJobDetails: json["partner_job_details"],
        partnerJobCountry:
            List<dynamic>.from(json["partner_job_country"].map((x) => x)),
        partnerSalary: json["partner_salary"],
      );

  Map<String, dynamic> toJson() => {
        "partner_education": List<dynamic>.from(partnerEducation.map((x) => x)),
        "partner_education_details": partnerEducationDetails,
        "partner_job": List<dynamic>.from(partnerJob.map((x) => x)),
        "partner_job_details": partnerJobDetails,
        "partner_job_country":
            List<dynamic>.from(partnerJobCountry.map((x) => x)),
        "partner_salary": partnerSalary,
      };
}
