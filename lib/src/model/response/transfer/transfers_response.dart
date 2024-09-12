import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:vgo_flutter_app/src/model/transfers.dart';

@JsonSerializable()
class TransfersResponse {
  bool? success;
  String? message;
  int? statusCode;
  Transfers? transfers;

  TransfersResponse(
      {this.success, this.message, this.statusCode, this.transfers});

  factory TransfersResponse.fromJson(Map<String, dynamic> json) =>
      TransfersResponse(
        success: json["success"],
        message: json["message"],
        statusCode: json["status_code"],
        transfers:
            json["data"] != null ? Transfers.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() =>
      {
        "success": success,
        "message": message,
        "status_code": statusCode,
        "transfers": statusCode,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
