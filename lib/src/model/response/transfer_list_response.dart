import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:vgo_flutter_app/src/model/transfer.dart';

@JsonSerializable()
class TransferListResponse {
  bool? success;
  String? message;
  int? statusCode;
  List<Transfer>? transferList;

  TransferListResponse(
      {this.success, this.message, this.statusCode, this.transferList});

  factory TransferListResponse.fromJson(Map<String, dynamic> json) =>
      TransferListResponse(
          success: json["success"],
          message: json["message"],
          statusCode: json["status_code"],
          transferList: List<Transfer>.from(
              json["transfer_menu"].map((x) => Transfer.fromJson(x))));

  Map<String, dynamic> toJson() =>
      {
        "success": success,
        "message": message,
        "status_code": statusCode,
        "transfer_menu": transferList,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
