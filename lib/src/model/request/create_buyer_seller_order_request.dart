import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CreateBuyerSellerOrderRequest {
  String? userName;
  String? symbol;
  String? units;
  String? stockPrice;

  CreateBuyerSellerOrderRequest(
      {this.userName,
        this.symbol,
        this.units,
        this.stockPrice,});

  factory CreateBuyerSellerOrderRequest.fromJson(Map<String, dynamic> json) =>
      CreateBuyerSellerOrderRequest(
        userName: json["username"],
        symbol: json["symbol"],
        units: json["units"],
        stockPrice: json["stock_price"],
      );

  Map<String, dynamic> toJson() => {
    "username": userName,
    "symbol": symbol,
    "units": units,
    "stock_price": stockPrice,
  };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
