import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class StatusCodeRequest {
  String? userName;
  String? userSubType;
  String? userType;

  StatusCodeRequest({
    this.userName,
    this.userSubType,
    this.userType});

  factory StatusCodeRequest.fromJson(Map<StatusCodeRequest, dynamic> json) =>
      StatusCodeRequest(
    userName: json["userName"],
    userSubType: json["user_sub_type"],
    userType: json["user_type"]);


  Map<String, dynamic> toJson() =>
      {
        "username": userName,
        "user_sub_type": userSubType,
        "user_type": userType,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
