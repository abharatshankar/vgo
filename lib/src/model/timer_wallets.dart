import 'dart:convert';
import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()

class TimerWallet{
  String? walletName;
  String? currency;
  int? timeDuration;

  TimerWallet({this.walletName,this.currency,this.timeDuration});

  factory TimerWallet.fromJson(Map<String, dynamic> json) => TimerWallet(
    walletName: json["wallet_name"],
    currency: json["currency"],
    timeDuration: json["time_duration"],
  );

  Map<String, dynamic> toJson() => {
    "wallet_name": walletName,
    "currency": currency,
    "time_duration": timeDuration,

  };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
