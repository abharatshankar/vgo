import 'dart:convert';
import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()

class Banks{
  String? walletName;
  String? bankName;
  String? currency;
  int? timeDuration;

  Banks({this.bankName,this.currency,this.timeDuration, this.walletName
  });

  factory Banks.fromJson(Map<String, dynamic> json) => Banks(
    walletName: json["wallet_name"],
    bankName: json["bank_name"],
    currency: json["currency"],
    timeDuration: json["time_duration"],
  );

  Map<String, dynamic> toJson() => {
    "wallet_name": walletName,
    "bank_name": bankName,
    "currency": currency,
    "time_duration": timeDuration,

  };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
