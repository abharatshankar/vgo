import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class StatusCodeResponse {
  bool? success;
  String? message;
  int? statusCode;
  String? data;

  StatusCodeResponse({this.message, this.success, this.statusCode, this.data});

  factory StatusCodeResponse.fromJson(Map<String, dynamic> json) =>
      StatusCodeResponse(
        success: json["success"],
        message: json["message"],
        statusCode: json["status_code"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "status_code": statusCode,
        "data": data,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
