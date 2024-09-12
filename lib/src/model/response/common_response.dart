import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CommonResponse {
  bool? success;
  String? message;
  String? data;

  CommonResponse({this.message, this.success, this.data});

  factory CommonResponse.fromJson(Map<String, dynamic> json) => CommonResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] != null ? json["data"] : '',
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
