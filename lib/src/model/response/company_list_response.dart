import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:vgo_flutter_app/src/model/company.dart';

@JsonSerializable()
class CompanyListResponse {
  bool? success;
  String? message;
  List<Company>? companyList;

  CompanyListResponse({this.message, this.companyList, this.success});

  factory CompanyListResponse.fromJson(Map<String, dynamic> json) =>

      CompanyListResponse(
          success: json["success"],
          message: json["message"],
          companyList: List<Company>.from(json["data"].map((x) => Company.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": companyList,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
