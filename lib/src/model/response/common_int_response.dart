import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CommonIntResponse {
  bool? success;
  String? message;
  int? data;

  CommonIntResponse({this.message, this.success, this.data});

  factory CommonIntResponse.fromJson(Map<String, dynamic> json) => CommonIntResponse(
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
