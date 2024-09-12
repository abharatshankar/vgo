import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CommonDataResponse {
  bool? success;
  String? message;

  CommonDataResponse({this.message, this.success});

  factory CommonDataResponse.fromJson(Map<String, dynamic> json) => CommonDataResponse(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
