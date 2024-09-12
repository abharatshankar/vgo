import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../timer_menu.dart';

@JsonSerializable()
class TimerListResponse {
  List<TimerMenu>? bankList;
  List<TimerMenu>? timerWalletList;

  TimerListResponse({this.bankList, this.timerWalletList});

  factory TimerListResponse.fromJson(Map<String, dynamic> json) =>
      TimerListResponse(
          bankList: List<TimerMenu>.from(
              json["banks"].map((x) => TimerMenu.fromJson(x))),
          timerWalletList: List<TimerMenu>.from(
              json["wallets"].map((x) => TimerMenu.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "banks": bankList,
        "wallets": timerWalletList,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
