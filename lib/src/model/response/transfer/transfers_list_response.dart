import 'dart:convert';
import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:vgo_flutter_app/src/model/transfers.dart';

@JsonSerializable()
class TransfersListResponse {
  bool? success;
  String? message;
  int? statusCode;
  List<Transfers>? transferList;

  TransfersListResponse(
      {this.success, this.message, this.transferList, this.statusCode});

  factory TransfersListResponse.fromJson(Map<String, dynamic> json) =>
      TransfersListResponse(
          success: json["success"],
          message: json["message"],
          statusCode: json["status_code"],
          transferList: List<Transfers>.from(
              json["data"].map((x) => Transfers.fromJson(x))));

  Map<String, dynamic> toJson() =>
      {
        "success": success,
        "message": message,
        "status_code": statusCode,
        "data": transferList,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
