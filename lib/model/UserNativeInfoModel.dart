// To parse this JSON data, do
//
//     final userNativeInfoModel = userNativeInfoModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

UserNativeInfoModel userNativeInfoModelFromJson(String str) =>
    UserNativeInfoModel.fromJson(json.decode(str));

String userNativeInfoModelToJson(UserNativeInfoModel data) =>
    json.encode(data.toJson());

class UserNativeInfoModel {
  UserNativeInfoModel({
    required this.data,
  });

  Data data;

  factory UserNativeInfoModel.fromJson(Map<String, dynamic> json) =>
      UserNativeInfoModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.country,
    required this.state,
    required this.city,
  });

  String id;
  Country country;
  State2 state;
  City city;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        country: Country.fromJson(json["country"]),
        state: State2.fromJson(json["state"]),
        city: City.fromJson(json["city"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country.toJson(),
        "state": state.toJson(),
        "city": city.toJson(),
      };
}

class City {
  City({
    required this.id,
    required this.city,
  });

  dynamic id;
  String city;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
      };
}

class Country {
  Country({
    required this.id,
    required this.country,
  });

  dynamic id;
  String country;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
      };
}

class State2 {
  State2({
    required this.id,
    required this.state,
  });

  dynamic id;
  String state;

  factory State2.fromJson(Map<String, dynamic> json) => State2(
        id: json["id"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "state": state,
      };
}
