import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Kyc {
  String? gapId;
  String? houseNo;
  String? address1;
  String? address2;
  String? landMark;
  String? cityTown;
  String? state;
  int? postalCode;
  String? country;
  String? latLocation;
  String? lngLocation;
  String? currentLocation;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? id;
  String? orgCompany;
  String? desig;
  String? dept;
  String? workingYears;
  String? course;
  String? duration;
  int? yearOfPass;
  String? collegeUniversity;
  String? profilePicture;
  String? profileName;
  String? category;
  String? refGapId;
  String? comments;

  Kyc(
      {this.gapId,
      this.houseNo,
      this.address1,
      this.address2,
      this.landMark,
      this.cityTown,
      this.state,
      this.postalCode,
      this.country,
      this.latLocation,
      this.lngLocation,
      this.currentLocation,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.id,
      this.dept,
      this.desig,
      this.orgCompany,
      this.workingYears,
      this.collegeUniversity,
      this.duration,
      this.course,
      this.yearOfPass,
      this.profilePicture,
      this.profileName,
      this.category,
      this.refGapId,
      this.comments});

  factory Kyc.fromJson(Map<String, dynamic> json) => Kyc(
        gapId: json["gap_id"],
        houseNo: json["house_no"],
        address1: json["address1"],
        address2: json["address2"],
        landMark: json["land_mark"],
        cityTown: json["city_town"],
        state: json["state"],
        postalCode: json["postal_code"],
        country: json["country"],
        latLocation: json["lat_location"],
        lngLocation: json["lng_location"],
        currentLocation: json["current_location"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        orgCompany: json["org_company"],
        desig: json["desig"],
        dept: json["dept"],
        workingYears: json["working_years"],
        collegeUniversity: json["college_university"],
        duration: json["duration"],
        course: json["course"],
        yearOfPass: json["year_of_pass"],
        profilePicture: json["profile_pic"],
        profileName: json["profile_name"],
        category: json["category"],
        refGapId: json["ref_gap_id"],
        comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "gap_id": gapId,
        "house_no": houseNo,
        "address1": address1,
        "address2": address2,
        "land_mark": landMark,
        "city_town": cityTown,
        "state": state,
        "postal_code": postalCode,
        "country": country,
        "lat_location": latLocation,
        "lng_location": lngLocation,
        "current_location": currentLocation,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "id": id,
        "college_university": collegeUniversity,
        "duration": duration,
        "course": course,
        "year_of_pass": yearOfPass,
        "profile_pic": profilePicture,
        "profile_name": profileName,
        "category": category,
        "ref_gap_id": refGapId,
        "comments": comments,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
