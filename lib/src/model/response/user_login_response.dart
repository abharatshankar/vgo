import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserLoginResponse {
  bool? success;
  String? message;
  int? otp;

  UserLoginResponse({this.message,this.otp,this.success});

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) => UserLoginResponse(
    success: json["success"],
    message: json["message"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "otp": otp,
  };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
