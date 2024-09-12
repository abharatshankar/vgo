import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class StatusResponse {
  bool? success;
  String? message;
  int? statusCode;

  StatusResponse({this.message, this.success, this.statusCode});

  factory StatusResponse.fromJson(Map<String, dynamic> json) =>
      StatusResponse(
        success: json["success"],
        message: json["message"],
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "status_code": statusCode,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
