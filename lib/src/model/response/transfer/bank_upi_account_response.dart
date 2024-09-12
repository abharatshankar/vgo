import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:vgo_flutter_app/src/model/bank_upi.dart';

@JsonSerializable()
class BankUpiAccountResponse {
  bool? success;
  String? message;
  BankUPI? bankUpi;

  BankUpiAccountResponse({this.message, this.bankUpi, this.success});

  factory BankUpiAccountResponse.fromJson(Map<String, dynamic> json) => BankUpiAccountResponse(
        success: json["success"],
        message: json["message"],
        bankUpi: json["data"] != null ? BankUPI.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": bankUpi,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
