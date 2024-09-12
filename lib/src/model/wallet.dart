import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Wallet {
  int? walletId;
  String? userName;
  String? symbol;
  String? quantity;
  String? quantityHold;
  String? stockProfit;
  String? createdAt;
  String? updatedAt;

  Wallet(
      {this.walletId,
      this.userName,
      this.symbol,
      this.quantity,
      this.quantityHold,
      this.stockProfit,
      this.createdAt,
      this.updatedAt});

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    walletId: json["wallet_id"],
        userName: json["username"],
        symbol: json["symbol"],
        quantity: json["quantity"],
        quantityHold: json["quantity_hold"],
        stockProfit: json["stock_profits"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() =>
      {
        "wallet_id": walletId,
        "username": userName,
        "symbol": symbol,
        "quantity": quantity,
        "quantity_hold": quantityHold,
        "stock_profits": stockProfit,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
