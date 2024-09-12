import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ExperienceRequest {
  String? cityTown;
  String? country;
  String? currentLocation;
  String? gapId;
  String? latLocation;
  String? lngLocation;
  int? postalCode;
  String? state;

  String? dept;
  String? desig;
  String? orgCompany;
  String? workingYears;

  ExperienceRequest(
      {this.cityTown,
      this.country,
      this.currentLocation,
      this.gapId,
      this.latLocation,
      this.lngLocation,
      this.postalCode,
      this.state,
      this.dept,
      this.desig,
      this.workingYears,
      this.orgCompany});

  factory ExperienceRequest.fromJson(Map<String, dynamic> json) =>
      ExperienceRequest(
        dept: json["dept"],
        desig: json["desig"],
        cityTown: json["city_town"],
        country: json["country"],
        currentLocation: json["current_location"],
        gapId: json["gap_id"],
        orgCompany: json["org_company"],
        latLocation: json["lat_location"],
        lngLocation: json["lng_location"],
        postalCode: json["postal_code"],
        state: json["state"],
        workingYears: json["working_years"],
      );

  Map<String, dynamic> toJson() => {
        "working_years": workingYears,
        "org_company": orgCompany,
        "city_town": cityTown,
        "country": country,
        "current_location": currentLocation,
        "gap_id": gapId,
        "dept": dept,
        "desig": desig,
        "lat_location": latLocation,
        "lng_location": lngLocation,
        "postal_code": postalCode,
        "state": state,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
