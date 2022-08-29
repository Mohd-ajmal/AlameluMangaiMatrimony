// To parse this JSON data, do
//
//     final matchesBasedOnPreference = matchesBasedOnPreferenceFromJson(jsonString);

import 'dart:convert';

MatchesBasedOnPreference matchesBasedOnPreferenceFromJson(String str) =>
    MatchesBasedOnPreference.fromJson(json.decode(str));

String matchesBasedOnPreferenceToJson(MatchesBasedOnPreference data) =>
    json.encode(data.toJson());

class MatchesBasedOnPreference {
  MatchesBasedOnPreference({
    required this.data,
  });

  List<Datum1> data;

  factory MatchesBasedOnPreference.fromJson(Map<String, dynamic> json) =>
      MatchesBasedOnPreference(
        data: List<Datum1>.from(json["data"].map((x) => Datum1.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum1 {
  Datum1(
      {required this.id,
      required this.username,
      required this.email,
      required this.phonenumber,
      required this.userProfileId,
      required this.profileStatusId,
      required this.isAdmin,
      required this.isVerified,
      required this.isPaid,
      this.emailVerifiedAt,
      this.token,
      this.deletedAt,
      required this.createdAt,
      required this.updatedAt,
      required this.userBasicInfo,
      required this.userFamilyInfo,
      required this.userReligeonInfo,
      required this.userNativeInfo,
      required this.status,
      required this.userProfessionInfo,
      required this.basicPartnerInfo,
      required this.userHoroScopeInfo});

  int id;
  String username;
  String email;
  String phonenumber;
  String userProfileId;
  String profileStatusId;
  String isAdmin;
  String isVerified;
  String isPaid;
  dynamic emailVerifiedAt;
  dynamic token;
  dynamic deletedAt;
  String createdAt;
  DateTime updatedAt;
  UserBasicInfo userBasicInfo;
  UserFamilyInfo userFamilyInfo;
  UserReligeonInfo userReligeonInfo;
  UserNativeInfo userNativeInfo;
  Status status;
  UserProfessionInfo userProfessionInfo;
  BasicPartnerInfo basicPartnerInfo;
  UserHoroScopeInfo userHoroScopeInfo;

  factory Datum1.fromJson(Map<String, dynamic> json) => Datum1(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        phonenumber: json["phonenumber"],
        userProfileId: json["user_profile_id"],
        profileStatusId: json["profile_status_id"],
        isAdmin: json["is_admin"],
        isVerified: json["is_verified"],
        isPaid: json["is_paid"],
        emailVerifiedAt: json["email_verified_at"],
        token: json["token"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        userBasicInfo: UserBasicInfo.fromJson(json["user_basic_info"]),
        userFamilyInfo: UserFamilyInfo.fromJson(json["user_family_info"]),
        userReligeonInfo: UserReligeonInfo.fromJson(json["user_religeon_info"]),
        userNativeInfo: UserNativeInfo.fromJson(json["user_native_info"]),
        status: Status.fromJson(json["status"]),
        userProfessionInfo:
            UserProfessionInfo.fromJson(json["user_profession_info"]),
        basicPartnerInfo: BasicPartnerInfo.fromJson(json["basic_partner_info"]),
        userHoroScopeInfo:
            UserHoroScopeInfo.fromJson(json["user_horo_scope_info"]),
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
        "email_verified_at": emailVerifiedAt,
        "token": token,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
        "user_basic_info": userBasicInfo.toJson(),
        "user_family_info": userFamilyInfo.toJson(),
        "user_religeon_info": userReligeonInfo.toJson(),
        "user_native_info": userNativeInfo.toJson(),
        "status": status.toJson(),
        "user_profession_info": userProfessionInfo.toJson(),
        "basic_partner_info": basicPartnerInfo.toJson(),
      };
}

class UserHoroScopeInfo {
  UserHoroScopeInfo({required this.image});
  String? image;

  factory UserHoroScopeInfo.fromJson(Map<String, dynamic> json) =>
      UserHoroScopeInfo(image: json["image_full_path"]);
}

class BasicPartnerInfo {
  BasicPartnerInfo({
    required this.id,
    required this.userId,
    required this.partnerAgeFrom,
    required this.partnerAgeTo,
    required this.partnerHeightTo,
    required this.partnerHeightFrom,
    required this.partnerMartialStatus,
    required this.partnerComplexion,
    required this.partnerMotherTongue,
    required this.partnerJob,
    required this.partnerEducation,
    this.partnerJobDetails,
    required this.partnerJobCountry,
    this.partnerJobState,
    this.partnerJobCity,
    required this.partnerEducationDetails,
    required this.partnerSalary,
    required this.partnerReligion,
    required this.partnerCaste,
    this.partnerStar,
    required this.partnerRasi,
    required this.partnerCountry,
    this.partnerState,
    this.partnerCity,
    required this.casteNoBar,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  int userId;
  String? partnerAgeFrom;
  String? partnerAgeTo;
  String? partnerHeightTo;
  String? partnerHeightFrom;
  String? partnerMartialStatus;
  List<Complex> partnerComplexion;
  List<MotherTongue> partnerMotherTongue;
  List<PartnerJob> partnerJob;
  List<PartnerEducation> partnerEducation;
  dynamic partnerJobDetails;
  List<Country> partnerJobCountry;
  dynamic partnerJobState;
  dynamic partnerJobCity;
  String? partnerEducationDetails;
  String partnerSalary;
  String? partnerReligion;
  String? partnerCaste;
  dynamic partnerStar;
  List<Rasi> partnerRasi;
  List<Country> partnerCountry;
  dynamic partnerState;
  dynamic partnerCity;
  String? casteNoBar;
  DateTime createdAt;
  DateTime updatedAt;

  factory BasicPartnerInfo.fromJson(Map<String, dynamic> json) =>
      BasicPartnerInfo(
        id: json["id"],
        userId: json["user_id"],
        partnerAgeFrom: json["partner_age_from"],
        partnerAgeTo: json["partner_age_to"],
        partnerHeightTo: json["partner_height_to"],
        partnerHeightFrom: json["partner_height_from"],
        partnerMartialStatus: json["partner_martial_status"],
        partnerComplexion: List<Complex>.from(
            json["partner_complexion"].map((x) => Complex.fromJson(x))),
        partnerMotherTongue: List<MotherTongue>.from(
            json["partner_mother_tongue"].map((x) => MotherTongue.fromJson(x))),
        partnerJob: List<PartnerJob>.from(
            json["partner_job"].map((x) => PartnerJob.fromJson(x))),
        partnerEducation: List<PartnerEducation>.from(
            json["partner_education"].map((x) => PartnerEducation.fromJson(x))),
        partnerJobDetails: json["partner_job_details"],
        partnerJobCountry: List<Country>.from(
            json["partner_job_country"].map((x) => Country.fromJson(x))),
        partnerJobState: json["partner_job_state"],
        partnerJobCity: json["partner_job_city"],
        partnerEducationDetails: json["partner_education_details"],
        partnerSalary: json["partner_salary"],
        partnerReligion: json["partner_religion"],
        partnerCaste: json["partner_caste"],
        partnerStar: json["partner_star"],
        partnerRasi:
            List<Rasi>.from(json["partner_rasi"].map((x) => Rasi.fromJson(x))),
        partnerCountry: List<Country>.from(
            json["partner_country"].map((x) => Country.fromJson(x))),
        partnerState: json["partner_state"],
        partnerCity: json["partner_city"],
        casteNoBar: json["caste_no_bar"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "partner_age_from": partnerAgeFrom,
        "partner_age_to": partnerAgeTo,
        "partner_height_to": partnerHeightTo,
        "partner_height_from": partnerHeightFrom,
        "partner_martial_status": partnerMartialStatus,
        "partner_complexion":
            List<dynamic>.from(partnerComplexion.map((x) => x.toJson())),
        "partner_mother_tongue":
            List<dynamic>.from(partnerMotherTongue.map((x) => x.toJson())),
        "partner_job": List<dynamic>.from(partnerJob.map((x) => x.toJson())),
        "partner_education":
            List<dynamic>.from(partnerEducation.map((x) => x.toJson())),
        "partner_job_details": partnerJobDetails,
        "partner_job_country":
            List<dynamic>.from(partnerJobCountry.map((x) => x.toJson())),
        "partner_job_state": partnerJobState,
        "partner_job_city": partnerJobCity,
        "partner_education_details": partnerEducationDetails,
        "partner_salary": partnerSalary,
        "partner_religion": partnerReligion,
        "partner_caste": partnerCaste,
        "partner_star": partnerStar,
        "partner_rasi": List<dynamic>.from(partnerRasi.map((x) => x.toJson())),
        "partner_country":
            List<dynamic>.from(partnerCountry.map((x) => x.toJson())),
        "partner_state": partnerState,
        "partner_city": partnerCity,
        "caste_no_bar": casteNoBar,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Complex {
  Complex({
    this.id,
    this.complexionName,
    required this.complexionStatus,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  ComplexionName? complexionName;
  String complexionStatus;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Complex.fromJson(Map<String, dynamic> json) => Complex(
        id: json["id"],
        complexionName: complexionNameValues.map[json["complexion_name"]],
        complexionStatus: json["complexion_status"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "complexion_name": complexionNameValues.reverse[complexionName],
        "complexion_status": complexionStatus,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

enum ComplexionName { chocolate, average, white }

final complexionNameValues = EnumValues({
  "average": ComplexionName.average,
  "chocolate": ComplexionName.chocolate,
  "white": ComplexionName.white
});

class Country {
  Country({
    this.id,
    this.countryName,
    required this.countryStatus,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  CountryName? countryName;
  String countryStatus;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        countryName: countryNameValues.map[json["country_name"]],
        countryStatus: json["country_status"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country_name": countryNameValues.reverse[countryName],
        "country_status": countryStatus,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

enum CountryName { india, usa }

final countryNameValues =
    EnumValues({"India": CountryName.india, "USA": CountryName.usa});

class PartnerEducation {
  PartnerEducation({
    this.id,
    required this.educationName,
    required this.educationStatus,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  String educationName;
  String educationStatus;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory PartnerEducation.fromJson(Map<String, dynamic> json) =>
      PartnerEducation(
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

class PartnerJob {
  PartnerJob({
    this.id,
    required this.jobName,
    required this.jobStatus,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  String jobName;
  String jobStatus;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory PartnerJob.fromJson(Map<String, dynamic> json) => PartnerJob(
        id: json["id"],
        jobName: json["job_name"],
        jobStatus: json["job_status"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_name": jobName,
        "job_status": jobStatus,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class MotherTongue {
  MotherTongue({
    this.id,
    required this.languageName,
    required this.languageStatus,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  LanguageName? languageName;
  String languageStatus;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory MotherTongue.fromJson(Map<String, dynamic> json) => MotherTongue(
        id: json["id"],
        languageName: languageNameValues.map[json["language_name"]],
        languageStatus: json["language_status"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "language_name": languageNameValues.reverse[languageName],
        "language_status": languageStatus,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

enum LanguageName { tamil, kannada, english }

final languageNameValues = EnumValues({
  "English": LanguageName.english,
  "Kannada": LanguageName.kannada,
  "Tamil": LanguageName.tamil
});

class Rasi {
  Rasi({
    this.id,
    this.rasiName,
    required this.rasiStatus,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  String? rasiName;
  String rasiStatus;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Rasi.fromJson(Map<String, dynamic> json) => Rasi(
        id: json["id"],
        rasiName: json["rasi_name"],
        rasiStatus: json["rasi_status"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rasi_name": rasiName,
        "rasi_status": rasiStatus,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Status {
  Status({
    this.id,
    required this.statusName,
    required this.statusStatus,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  String statusName;
  String statusStatus;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
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
    required this.gender,
    required this.height,
    required this.motherTongue,
    required this.martialStatus,
    required this.eatingHabit,
    required this.complex,
  });

  String id;
  int userId;
  String userFullName;
  String userMobileNo;
  dynamic userProfileImage;
  DateTime dob;
  String bloodGroup;
  dynamic about;
  String userAddress;
  String age;
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
  Height height;
  MotherTongue motherTongue;
  MartialStatus martialStatus;
  EatingHabit eatingHabit;
  Complex complex;

  factory UserBasicInfo.fromJson(Map<String, dynamic> json) => UserBasicInfo(
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
        gender: Gender.fromJson(json["gender"]),
        height: Height.fromJson(json["height"]),
        motherTongue: MotherTongue.fromJson(json["mother_tongue"]),
        martialStatus: MartialStatus.fromJson(json["martial_status"]),
        eatingHabit: EatingHabit.fromJson(json["eating_habit"]),
        complex: Complex.fromJson(json["complex"]),
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
        "gender": gender.toJson(),
        "height": height.toJson(),
        "mother_tongue": motherTongue.toJson(),
        "martial_status": martialStatus.toJson(),
        "eating_habit": eatingHabit.toJson(),
        "complex": complex.toJson(),
      };
}

class EatingHabit {
  EatingHabit({
    this.id,
    required this.habitTypeName,
    required this.habitStatus,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  String habitTypeName;
  String habitStatus;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory EatingHabit.fromJson(Map<String, dynamic> json) => EatingHabit(
        id: json["id"],
        habitTypeName: json["habit_type_name"],
        habitStatus: json["habit_status"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "habit_type_name": habitTypeName,
        "habit_status": habitStatus,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Gender {
  Gender({
    this.id,
    required this.genderName,
    required this.genderStatus,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  String genderName;
  String genderStatus;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
        id: json["id"],
        genderName: json["gender_name"],
        genderStatus: json["gender_status"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gender_name": genderName,
        "gender_status": genderStatus,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Height {
  Height({
    this.id,
    required this.heightFeetCm,
    required this.heightStatus,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  String heightFeetCm;
  String heightStatus;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Height.fromJson(Map<String, dynamic> json) => Height(
        id: json["id"],
        heightFeetCm: json["height_feet_cm"],
        heightStatus: json["height_status"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "height_feet_cm": heightFeetCm,
        "height_status": heightStatus,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class MartialStatus {
  MartialStatus({
    this.id,
    required this.martialStatusName,
    required this.martialStatusStatus,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  String martialStatusName;
  String martialStatusStatus;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory MartialStatus.fromJson(Map<String, dynamic> json) => MartialStatus(
        id: json["id"],
        martialStatusName: json["martial_status_name"],
        martialStatusStatus: json["martial_status_status"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "martial_status_name": martialStatusName,
        "martial_status_status": martialStatusStatus,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class UserFamilyInfo {
  UserFamilyInfo({
    required this.id,
    required this.userId,
    required this.userFatherName,
    required this.userFatherJobDetails,
    required this.userMotherName,
    required this.userMotherJobDetails,
    required this.userFamilyStatus,
    required this.noOfSibling,
    this.noOfBrothers,
    this.noOfSisters,
    this.noOfBrothersMarried,
    this.noOfSistersMarried,
    required this.userSiblingDetails,
    required this.paternalUncleAddress,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String userId;
  String userFatherName;
  String userFatherJobDetails;
  String userMotherName;
  String userMotherJobDetails;
  String userFamilyStatus;
  String noOfSibling;
  dynamic noOfBrothers;
  dynamic noOfSisters;
  dynamic noOfBrothersMarried;
  dynamic noOfSistersMarried;
  String? userSiblingDetails;
  String paternalUncleAddress;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserFamilyInfo.fromJson(Map<String, dynamic> json) => UserFamilyInfo(
        id: json["id"],
        userId: json["user_id"],
        userFatherName: json["user_father_name"],
        userFatherJobDetails: json["user_father_job_details"],
        userMotherName: json["user_mother_name"],
        userMotherJobDetails: json["user_mother_job_details"],
        userFamilyStatus: json["user_family_status"],
        noOfSibling: json["no_of_sibling"],
        noOfBrothers: json["no_of_brothers"],
        noOfSisters: json["no_of_sisters"],
        noOfBrothersMarried: json["no_of_brothers_married"],
        noOfSistersMarried: json["no_of_sisters_married"],
        userSiblingDetails: json["user_sibling_details"],
        paternalUncleAddress: json["paternal_uncle_address"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_father_name": userFatherName,
        "user_father_job_details": userFatherJobDetails,
        "user_mother_name": userMotherName,
        "user_mother_job_details": userMotherJobDetails,
        "user_family_status": userFamilyStatus,
        "no_of_sibling": noOfSibling,
        "no_of_brothers": noOfBrothers,
        "no_of_sisters": noOfSisters,
        "no_of_brothers_married": noOfBrothersMarried,
        "no_of_sisters_married": noOfSistersMarried,
        "user_sibling_details": userSiblingDetails,
        "paternal_uncle_address": paternalUncleAddress,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class UserNativeInfo {
  UserNativeInfo({
    required this.id,
    required this.userId,
    required this.userCountryId,
    required this.userStateId,
    required this.userCityId,
    required this.createdAt,
    required this.updatedAt,
    required this.country,
    required this.state,
    required this.city,
  });

  int id;
  String userId;
  String userCountryId;
  String userStateId;
  String userCityId;
  DateTime createdAt;
  DateTime updatedAt;
  Country country;
  State2 state;
  City city;

  factory UserNativeInfo.fromJson(Map<String, dynamic> json) => UserNativeInfo(
        id: json["id"],
        userId: json["user_id"],
        userCountryId: json["user_country_id"],
        userStateId: json["user_state_id"],
        userCityId: json["user_city_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        country: Country.fromJson(json["country"]),
        state: State2.fromJson(json["state"]),
        city: City.fromJson(json["city"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_country_id": userCountryId,
        "user_state_id": userStateId,
        "user_city_id": userCityId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "country": country.toJson(),
        "state": state.toJson(),
        "city": city.toJson(),
      };
}

class City {
  City({
    required this.id,
    required this.stateId,
    required this.cityName,
    required this.cityStatus,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String stateId;
  String cityName;
  String cityStatus;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        stateId: json["state_id"],
        cityName: json["city_name"],
        cityStatus: json["city_status"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "state_id": stateId,
        "city_name": cityName,
        "city_status": cityStatus,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class State2 {
  State2({
    this.id,
    required this.countryId,
    required this.stateName,
    required this.stateStatus,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  String countryId;
  String stateName;
  String stateStatus;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory State2.fromJson(Map<String, dynamic> json) => State2(
        id: json["id"],
        countryId: json["country_id"],
        stateName: json["state_name"],
        stateStatus: json["state_status"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country_id": countryId,
        "state_name": stateName,
        "state_status": stateStatus,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class UserProfessionInfo {
  UserProfessionInfo({
    required this.id,
    required this.userId,
    this.userEducationId,
    required this.userEducationDetails,
    required this.userJobId,
    this.userJobDetails,
    required this.userJobCountry,
    required this.userJobState,
    required this.userJobCity,
    this.userAnnualIncome,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  int userId;
  List<PartnerEducation>? userEducationId;
  String? userEducationDetails;
  String userJobId;
  dynamic userJobDetails;
  String userJobCountry;
  String userJobState;
  String userJobCity;
  String? userAnnualIncome;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserProfessionInfo.fromJson(Map<String, dynamic> json) =>
      UserProfessionInfo(
        id: json["id"],
        userId: json["user_id"],
        userEducationId: List<PartnerEducation>.from(
            json["user_education_id"].map((x) => PartnerEducation.fromJson(x))),
        userEducationDetails: json["user_education_details"],
        userJobId: json["user_job_id"],
        userJobDetails: json["user_job_details"],
        userJobCountry: json["user_job_country"],
        userJobState: json["user_job_state"],
        userJobCity: json["user_job_city"],
        userAnnualIncome: json["user_annual_income"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_education_id":
            List<dynamic>.from(userEducationId!.map((x) => x.toJson())),
        "user_education_details": userEducationDetails,
        "user_job_id": userJobId,
        "user_job_details": userJobDetails,
        "user_job_country": userJobCountry,
        "user_job_state": userJobState,
        "user_job_city": userJobCity,
        "user_annual_income": userAnnualIncome,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class UserReligeonInfo {
  UserReligeonInfo({
    required this.id,
    required this.userId,
    required this.userReligionId,
    required this.userCasteId,
    required this.subCaste,
    required this.userRasiId,
    required this.userStarId,
    required this.dhosam,
    this.dhosamDetails,
    this.userBirthTime,
    this.userBirthPlace,
    required this.createdAt,
    required this.updatedAt,
    required this.belognsToReligion,
    required this.belongsToCaste,
    required this.belongsToRasi,
    required this.belongsToStar,
  });

  int id;
  String userId;
  String userReligionId;
  String userCasteId;
  String? subCaste;
  String userRasiId;
  String userStarId;
  String dhosam;
  dynamic dhosamDetails;
  String? userBirthTime;
  String? userBirthPlace;
  DateTime createdAt;
  DateTime updatedAt;
  BelognsToReligion belognsToReligion;
  BelongsToCaste belongsToCaste;
  Rasi belongsToRasi;
  BelongsToStar belongsToStar;

  factory UserReligeonInfo.fromJson(Map<String, dynamic> json) =>
      UserReligeonInfo(
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
        belognsToReligion:
            BelognsToReligion.fromJson(json["belogns_to_religion"]),
        belongsToCaste: BelongsToCaste.fromJson(json["belongs_to_caste"]),
        belongsToRasi: Rasi.fromJson(json["belongs_to_rasi"]),
        belongsToStar: BelongsToStar.fromJson(json["belongs_to_star"]),
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
        "belogns_to_religion": belognsToReligion.toJson(),
        "belongs_to_caste": belongsToCaste.toJson(),
        "belongs_to_rasi": belongsToRasi.toJson(),
        "belongs_to_star": belongsToStar.toJson(),
      };
}

class BelognsToReligion {
  BelognsToReligion({
    this.id,
    required this.religionName,
    required this.religionStatus,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  String religionName;
  String religionStatus;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory BelognsToReligion.fromJson(Map<String, dynamic> json) =>
      BelognsToReligion(
        id: json["id"],
        religionName: json["religion_name"],
        religionStatus: json["religion_status"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "religion_name": religionName,
        "religion_status": religionStatus,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class BelongsToCaste {
  BelongsToCaste({
    required this.id,
    required this.casteName,
    required this.casteStatus,
    required this.casteReligion,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String casteName;
  String casteStatus;
  String casteReligion;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory BelongsToCaste.fromJson(Map<String, dynamic> json) => BelongsToCaste(
        id: json["id"],
        casteName: json["caste_name"],
        casteStatus: json["caste_status"],
        casteReligion: json["caste_religion"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "caste_name": casteName,
        "caste_status": casteStatus,
        "caste_religion": casteReligion,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class BelongsToStar {
  BelongsToStar({
    this.id,
    required this.starName,
    required this.starStatus,
    required this.starRasiId,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  String? starName;
  String starStatus;
  String starRasiId;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory BelongsToStar.fromJson(Map<String, dynamic> json) => BelongsToStar(
        id: json["id"],
        starName: json["star_name"],
        starStatus: json["star_status"],
        starRasiId: json["star_rasi_id"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "star_name": starName,
        "star_status": starStatus,
        "star_rasi_id": starRasiId,
        "deleted_at": deletedAt,
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
