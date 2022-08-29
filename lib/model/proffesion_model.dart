// To parse this JSON data, do
//
//     final proffesionModel = proffesionModelFromJson(jsonString);

import 'dart:convert';

ProffesionModel proffesionModelFromJson(String str) =>
    ProffesionModel.fromJson(json.decode(str));

String proffesionModelToJson(ProffesionModel data) =>
    json.encode(data.toJson());

class ProffesionModel {
  ProffesionModel({
    required this.data,
  });

  Data data;

  factory ProffesionModel.fromJson(Map<String, dynamic> json) =>
      ProffesionModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.education,
    required this.educationDetails,
    required this.job,
    required this.jobDetails,
    required this.jobCountry,
    required this.jobState,
    required this.jobCity,
    required this.annualIncome,
  });

  int? id;
  List<Education>? education;
  String? educationDetails;
  Job? job;
  String? jobDetails;
  JobCountry? jobCountry;
  JobState? jobState;
  JobCity? jobCity;
  String? annualIncome;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        education: List<Education>.from(
            json["education"].map((x) => Education.fromJson(x))),
        educationDetails: json["education_details"],
        job: Job.fromJson(json["job"]),
        jobDetails: json["job_details"],
        jobCountry: JobCountry.fromJson(json["job_country"]),
        jobState: JobState.fromJson(json["job_state"]),
        jobCity: JobCity.fromJson(json["job_city"]),
        annualIncome: json["annual_income"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "education": List<dynamic>.from(education!.map((x) => x.toJson())),
        "education_details": educationDetails,
        "job": job!.toJson(),
        "job_details": jobDetails,
        "job_country": jobCountry!.toJson(),
        "job_state": jobState!.toJson(),
        "job_city": jobCity!.toJson(),
        "annual_income": annualIncome,
      };
}

class Education {
  Education({
    required this.id,
    required this.educationName,
    required this.educationStatus,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String educationName;
  String educationStatus;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        id: json["id"],
        educationName: json["education_name"],
        educationStatus: json["education_status"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "education_name": educationName,
        "education_status": educationStatus,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Job {
  Job({
    required this.id,
    required this.job,
  });

  int id;
  String? job;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"],
        job: json["job"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job": job,
      };
}

class JobCity {
  JobCity({
    required this.id,
    required this.city,
  });

  int id;
  String? city;

  factory JobCity.fromJson(Map<String, dynamic> json) => JobCity(
        id: json["id"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
      };
}

class JobCountry {
  JobCountry({
    required this.id,
    required this.country,
  });

  int id;
  String? country;

  factory JobCountry.fromJson(Map<String, dynamic> json) => JobCountry(
        id: json["id"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
      };
}

class JobState {
  JobState({
    required this.id,
    required this.state,
  });

  int id;
  String? state;

  factory JobState.fromJson(Map<String, dynamic> json) => JobState(
        id: json["id"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "state": state,
      };
}
