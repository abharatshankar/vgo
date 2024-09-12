import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class EducationRequest {
  String? cityTown;
  String? collegeUniversity;
  String? course;
  String? country;
  String? currentLocation;
  String? gapId;
  String? duration;
  int? yearOfPass;
  String? latLocation;
  String? lngLocation;
  int? postalCode;
  String? state;

  EducationRequest(
      {this.cityTown,
      this.country,
      this.currentLocation,
      this.gapId,
      this.latLocation,
      this.lngLocation,
      this.postalCode,
      this.state,
      this.collegeUniversity,
      this.course,
      this.duration,
      this.yearOfPass});

  factory EducationRequest.fromJson(Map<String, dynamic> json) => EducationRequest(
        course: json["course"],
        duration: json["duration"],
        cityTown: json["city_town"],
        country: json["country"],
        currentLocation: json["current_location"],
        gapId: json["gap_id"],
        yearOfPass: json["year_of_pass"],
        latLocation: json["lat_location"],
        lngLocation: json["lng_location"],
        postalCode: json["postal_code"],
        state: json["state"],
        collegeUniversity: json["college_university"],
      );

  Map<String, dynamic> toJson() => {
        "course": course,
        "duration": duration,
        "city_town": cityTown,
        "country": country,
        "current_location": currentLocation,
        "gap_id": gapId,
        "year_of_pass": yearOfPass,
        "college_university": collegeUniversity,
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
