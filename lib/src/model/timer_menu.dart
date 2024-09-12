import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class TimerMenu {
  String? walletName;
  String? bankName;
  String? currency;
  int? timeDuration;

  TimerMenu({this.bankName, this.currency, this.timeDuration, this.walletName});

  factory TimerMenu.fromJson(Map<String, dynamic> json) => TimerMenu(
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

