import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class RegistrationRequest {
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? countryCode;
  String? emailId;
  String? currency;
  String? profession;
  String? gapId;
  String? location;
  String? userImagePath;
  String? userStatus;
  String? userType;
  String? userSubType;

  RegistrationRequest(
      {this.firstName,
      this.lastName,
      this.mobileNumber,
      this.countryCode,
      this.emailId,
      this.currency,
      this.profession,
      this.gapId,
      this.location,
      this.userImagePath,
      this.userStatus,
      this.userType,
      this.userSubType});

  factory RegistrationRequest.fromJson(Map<String, dynamic> json) =>
      RegistrationRequest(
          firstName: json["first_name"],
          lastName: json["last_name"],
          mobileNumber: json["mobile_number"],
          countryCode: json["country_code"],
          emailId: json["email_id"],
          currency: json["currency"],
          profession: json["profession"],
          gapId: json["gap_id"],
          location: json["location"],
          userImagePath: json["user_image_path"],
          userStatus: json["user_status"],
          userType: json["user_type"],
          userSubType: json["user_sub_type"]);

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "mobile_number": mobileNumber,
    "country_code": countryCode,
    "email_id": emailId,
    "currency": currency,
    "profession": profession,
    "location": location,
    "gap_id": gapId,
    "user_image_path": userImagePath,
    "user_status": userStatus,
    "user_type": userType,
    "user_sub_type": userSubType,
  };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
