import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:vgo_flutter_app/src/model/bank_upi.dart';

@JsonSerializable()
class BankUpiListResponse {
  bool? success;
  String? message;
  List<BankUPI>? bankUpiList;

  BankUpiListResponse(
      {this.success, this.message, this.bankUpiList});

  factory BankUpiListResponse.fromJson(Map<String, dynamic> json) =>
      BankUpiListResponse(
          success: json["success"],
          message: json["message"],
          bankUpiList: List<BankUPI>.from(json["data"].map((x) => BankUPI.fromJson(x))));

  Map<String, dynamic> toJson() =>
      {
        "success": success,
        "message": message,
        "data": bankUpiList,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
