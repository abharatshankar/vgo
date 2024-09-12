import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:vgo_flutter_app/src/model/coin.dart';


@JsonSerializable()
class CoinListResponse {
  bool? success;
  String? message;
  int? statusCode;
  List<Coin>? allCoinsList;

  CoinListResponse({this.success, this.message, this.statusCode, this.allCoinsList});

  factory CoinListResponse.fromJson(Map<String, dynamic> json) => CoinListResponse(
      success: json["success"],
      message: json["message"],
      statusCode: json["status_code"],
      allCoinsList: json["data"] != null ? List<Coin>.from(
          json["data"].map((x) => Coin.fromJson(x))) : []);
  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": allCoinsList,
  };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
