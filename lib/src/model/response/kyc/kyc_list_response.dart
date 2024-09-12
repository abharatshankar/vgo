import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../Kyc.dart';



@JsonSerializable()
class KycListResponse {
  bool? success;
  String? message;
  List<Kyc>? kycList;

  KycListResponse({this.success, this.message, this.kycList});

  factory KycListResponse.fromJson(Map<String, dynamic> json) =>
      KycListResponse(
          success: json["success"],
          message: json["message"],
          kycList:
              List<Kyc>.from(json["data"].map((x) => Kyc.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": kycList,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
