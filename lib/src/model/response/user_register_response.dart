import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../user.dart';

@JsonSerializable()
class UserRegisterResponse {
  bool? success;
  String? message;
  User? user;

  UserRegisterResponse({this.message,this.success, this.user});

  factory UserRegisterResponse.fromJson(Map<String, dynamic> json) => UserRegisterResponse(
    success: json["success"],
    message: json["message"],
    user: json["data"] != null ? User.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": user,
  };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
