import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
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
  String? username;
  String? updateAt;
  String? createdAt;
  int? id;
  int? colorCode;

  User(
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
      this.userSubType,
      this.username,
      this.updateAt,
      this.createdAt,
      this.id});

  factory User.fromJson(Map<String, dynamic> json) => User(
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
      userSubType: json["user_sub_type"],
      username: json["username"],
      updateAt: json["updated_at"],
      createdAt: json["created_at"],
      id: json["id"]);

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
        "username": username,
        "updated_at": updateAt,
        "created_at": createdAt,
        "id": id,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
