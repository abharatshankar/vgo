import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../Kyc.dart';



@JsonSerializable()
class KycResponse {
  bool? success;
  String? message;
  Kyc? kyc;

  KycResponse({this.success, this.message, this.kyc});

  factory KycResponse.fromJson(Map<String, dynamic> json) => KycResponse(
        success: json["success"],
        message: json["message"],
        kyc: json["data"] != null ? Kyc.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": kyc,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
