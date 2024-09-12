import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:vgo_flutter_app/src/model/exchange_amount.dart';

@JsonSerializable()
class ExchangeResponse {
  bool? success;
  String? message;
  ExchangeAmount? exchangeAmount;

  ExchangeResponse({this.message, this.success, this.exchangeAmount});

  factory ExchangeResponse.fromJson(Map<String, dynamic> json) =>
      ExchangeResponse(
        success: json["success"],
        message: json["message"],
        exchangeAmount:
            json["data"] != null ? ExchangeAmount.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": exchangeAmount,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
