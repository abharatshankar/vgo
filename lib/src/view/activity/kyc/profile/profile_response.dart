import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()

class ProfileResponse {

  bool? success;
  String? message;
  List<Profile>? profileList;

  ProfileResponse({this.message, this.profileList, this.success});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
          success: json["success"],
          message: json["message"],
          profileList: json["data"] != null
              ? List<Profile>.from(
              json["data"].map((x) => Profile.fromJson(x)))
              : []);

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": profileList,
  };


  @override
  String toString() {
    return jsonEncode(this);
  }

}

class Profile{
  String? gap_id;
  String? first_name;
  String? last_name;
  String? gender;
  String? date_of_birth;
  String? fh_name;
  String? current_location;
  String? profession;
  List<Report>? reportsList;
  List<Inquiries>? inquiriesList;
  List<Accepts>? acceptList;
  List<Addresses>? addressesList;
  List<Education>? educationList;
  List<Experience>? experienceList;

  Profile(
      {this.gap_id,
      this.reportsList,
      this.inquiriesList,
      this.acceptList,
      this.addressesList,
      this.educationList,
      this.experienceList,
      this.first_name,
      this.last_name,
      this.gender,
      this.date_of_birth,
      this.fh_name,
      this.current_location,
      this.profession});

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
      gap_id: json["gap_id"],
      first_name: json["first_name"],
      last_name: json["last_name"],
      gender: json["gender"],
          date_of_birth: json["date_of_birth"],
          fh_name: json["fh_name"],
          current_location: json["current_location"],
          profession: json["profession"],
          reportsList: json["reports"] != null ? List<Report>.from(json["reports"].map((x) => Report.fromJson(x))) : [],
          inquiriesList: json["inquiries"] != null ? List<Inquiries>.from(json["inquiries"].map((x) => Inquiries.fromJson(x))) : [],
          acceptList: json["accepts"] != null ? List<Accepts>.from(json["accepts"].map((x) => Accepts.fromJson(x))) : [],
      addressesList: json["addresses"] != null ? List<Addresses>.from(json["addresses"].map((x) => Addresses.fromJson(x))) : [],
      educationList: json["educations"] != null ? List<Education>.from(json["educations"].map((x) => Education.fromJson(x))) : [],
      experienceList: json["experiences"] != null ? List<Experience>.from(json["experiences"].map((x) => Experience.fromJson(x))) : []);

  Map<String, dynamic> toJson() => {
    "gap_id": gap_id,
    "reports": reportsList,
    "inquiries": inquiriesList,
    "accepts": acceptList,
    "addresses": addressesList,
    "educations": educationList,
    "experiences": experienceList,
  };

}

class Report{
  String? profile_category;
  String? profile_report;
  String? comments;
  String? created_at;

  Report({this.profile_category, this.profile_report, this.comments, this.created_at});

  factory Report.fromJson(Map<String, dynamic> json) => Report(
      profile_category: json["profile_category"],
      profile_report: json["profile_report"],
      comments: json["comments"],
      created_at: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
    "profile_category": profile_category,
    "profile_report": profile_report,
    "comments": comments,
    "created_at": created_at,
  };
}

class Inquiries{
  String? gap_id;
  String? profile_name;
  String? profile_category;
  String? inquiry_status;
  String? comments;
  String? created_at;
  int? colorCode;

  Inquiries({this.gap_id, this.profile_name, this.profile_category, this.inquiry_status, this.comments, this.created_at});

  factory Inquiries.fromJson(Map<String, dynamic> json) => Inquiries(
    gap_id: json["gap_id"],
    profile_name: json["profile_name"],
    profile_category: json["profile_category"],
    inquiry_status: json["inquiry_status"],
    comments: json["comments"],
    created_at: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "gap_id": gap_id,
    "profile_name": profile_name,
    "profile_category": profile_category,
    "inquiry_status": inquiry_status,
    "comments": comments,
    "created_at": created_at,
  };
}


class Accepts{
  String? gap_id;
  String? profile_name;
  String? profile_category;
  String? inquiry_status;
  String? comments;
  String? created_at;
  int? colorCode;

  Accepts({this.gap_id, this.profile_name, this.profile_category, this.inquiry_status, this.comments, this.created_at});

  factory Accepts.fromJson(Map<String, dynamic> json) => Accepts(
    gap_id: json["gap_id"],
    profile_name: json["profile_name"],
    profile_category: json["profile_category"],
    inquiry_status: json["inquiry_status"],
    comments: json["comments"],
    created_at: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
        "gap_id": gap_id,
        "profile_name": profile_name,
        "profile_category": profile_category,
        "inquiry_status": inquiry_status,
        "comments": comments,
        "created_at": created_at,
      };
}

class Addresses {
  String? gap_id;
  String? house_no;
  String? address1;
  String? address2;
  String? land_mark;
  String? city_town;
  String? state;
  int? postal_code;
  String? country;
  String? created_at;

  Addresses({
    this.gap_id,
    this.house_no,
    this.address1,
    this.address2,
    this.land_mark,
    this.city_town,
    this.state,
    this.postal_code,
    this.country,
    this.created_at,
  });

  factory Addresses.fromJson(Map<String, dynamic> json) => Addresses(
        gap_id: json["gap_id"],
        house_no: json["house_no"],
        address1: json["address1"],
        address2: json["address2"],
        land_mark: json["land_mark"],
        city_town: json["city_town"],
        state: json["state"],
        postal_code: json["postal_code"],
        country: json["country"],
        created_at: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "gap_id": gap_id,
        "house_no": house_no,
        "address1": address1,
        "address2": address2,
        "land_mark": land_mark,
        "city_town": city_town,
        "state": state,
        "postal_code": postal_code,
        "country": country,
        "created_at": created_at,
      };
}

class Education {
  String? gap_id;
  String? course;
  String? duration;
  int? year_of_pass;
  String? college_university;
  String? city_town;
  String? state;
  String? postal_code;
  String? country;
  String? created_at;

  Education({
    this.gap_id,
    this.course,
    this.duration,
    this.year_of_pass,
    this.college_university,
    this.city_town,
    this.state,
    this.postal_code,
    this.country,
    this.created_at,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        gap_id: json["gap_id"],
        course: json["course"],
        duration: json["duration"],
        year_of_pass: json["year_of_pass"],
        college_university: json["college_university"],
        city_town: json["city_town"],
        state: json["state"],
        postal_code: json["postal_code"],
        country: json["country"],
        created_at: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "gap_id": gap_id,
        "course": course,
        "duration": duration,
        "year_of_pass": year_of_pass,
        "college_university": college_university,
        "city_town": city_town,
        "state": state,
        "postal_code": postal_code,
        "country": country,
        "created_at": created_at,
      };
}

class Experience {
  String? gap_id;
  String? org_company;
  String? desig;
  String? dept;
  String? working_years;
  String? city_town;
  String? state;
  String? postal_code;
  String? country;
  String? created_at;

  Experience({
    this.gap_id,
    this.org_company,
    this.desig,
    this.dept,
    this.working_years,
    this.city_town,
    this.state,
    this.postal_code,
    this.country,
    this.created_at,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        gap_id: json["gap_id"],
        org_company: json["org_company"],
        desig: json["desig"],
        dept: json["dept"],
        working_years: json["working_years"],
        city_town: json["city_town"],
        state: json["state"],
        postal_code: json["postal_code"],
        country: json["country"],
        created_at: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "gap_id": gap_id,
        "org_company": org_company,
        "desig": desig,
        "dept": dept,
        "working_years": working_years,
        "city_town": city_town,
        "state": state,
        "postal_code": postal_code,
        "country": country,
        "created_at": created_at,
      };
}