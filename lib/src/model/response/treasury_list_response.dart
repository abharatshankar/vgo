import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../company.dart';


@JsonSerializable()
class TreasuryListResponse {
  bool? success;
  String? message;
  List<Company>? allTreasuryList;

  TreasuryListResponse({this.success,this.message,this.allTreasuryList});

  factory TreasuryListResponse.fromJson(Map<String, dynamic> json) => TreasuryListResponse(
    success: json["success"],
    message: json["message"],
      allTreasuryList: List<Company>.from(
        json["data"].map((x) => Company.fromJson(x))));

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": allTreasuryList,
  };

  @override
  String toString() {
    return jsonEncode(this);
  }
}

