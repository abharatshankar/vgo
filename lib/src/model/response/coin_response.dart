import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:vgo_flutter_app/src/model/coin.dart';

import 'coin_detail.dart';

@JsonSerializable()
class CoinResponse {
  bool? success;
  String? message;
  CoinDetail? coin;

  CoinResponse({this.message, this.coin, this.success});

  factory CoinResponse.fromJson(Map<String, dynamic> json) => CoinResponse(
        success: json["success"],
        message: json["message"],
        coin: json["data"] != null ? CoinDetail.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": coin,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
