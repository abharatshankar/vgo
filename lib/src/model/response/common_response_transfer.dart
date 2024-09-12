import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CommonResponseTransfer {
  bool? success;
  String? message;
  int? data;

  CommonResponseTransfer({this.message, this.success, this.data});

  factory CommonResponseTransfer.fromJson(Map<String, dynamic> json) => CommonResponseTransfer(
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
