import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:vgo_flutter_app/src/model/company.dart';

@JsonSerializable()
class CompanyResponse {
  bool? success;
  String? message;
  Company? company;

  CompanyResponse({this.message, this.company, this.success});

  factory CompanyResponse.fromJson(Map<String, dynamic> json) =>
      CompanyResponse(
        success: json["success"],
        message: json["message"],
        company: json["data"] != null ? Company.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": company,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
