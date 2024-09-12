import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class StatusDataIntResponse {
  bool? success;
  String? message;
  int? data;

  StatusDataIntResponse({this.message, this.success, this.data});

  factory StatusDataIntResponse.fromJson(Map<String, dynamic> json) =>
      StatusDataIntResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
