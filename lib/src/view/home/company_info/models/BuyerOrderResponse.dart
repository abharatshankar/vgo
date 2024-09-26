// To parse this JSON data, do
//
//     final buyerOrderResponse = buyerOrderResponseFromJson(jsonString);

import 'dart:convert';

BuyerOrderResponse buyerOrderResponseFromJson(String str) => BuyerOrderResponse.fromJson(json.decode(str));

String buyerOrderResponseToJson(BuyerOrderResponse data) => json.encode(data.toJson());

class BuyerOrderResponse {
  bool success;
  String message;
  Data data;

  BuyerOrderResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BuyerOrderResponse.fromJson(Map<String, dynamic> json) => BuyerOrderResponse(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String username;
  String symbol;
  String units;
  String stockPrice;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  Data({
    required this.username,
    required this.symbol,
    required this.units,
    required this.stockPrice,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    username: json["username"],
    symbol: json["symbol"],
    units: json["units"],
    stockPrice: json["stock_price"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "symbol": symbol,
    "units": units,
    "stock_price": stockPrice,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}
