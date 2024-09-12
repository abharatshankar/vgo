import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ExchangeAmount {
  String? receiveAmount;
  String? exchangeRate;
  String? transactionFees;

  ExchangeAmount({
    this.receiveAmount,
    this.exchangeRate,
    this.transactionFees,
  });

  factory ExchangeAmount.fromJson(Map<String, dynamic> json) => ExchangeAmount(
        receiveAmount: json["receive_amount"],
        exchangeRate: json["exchange_rate"],
        transactionFees: json["transaction_fees"],
      );

  Map<String, dynamic> toJson() => {
        "receive_amount": receiveAmount,
        "exchange_rate": exchangeRate,
        "transaction_fees": transactionFees,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
