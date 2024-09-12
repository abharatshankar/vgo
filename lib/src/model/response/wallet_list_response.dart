import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../wallet.dart';

@JsonSerializable()
class WalletListResponse {
  bool? success;
  String? message;
  List<Wallet>? walletList;

  WalletListResponse({this.success, this.message, this.walletList});

  factory WalletListResponse.fromJson(Map<String, dynamic> json) => WalletListResponse(
      success: json["success"],
      message: json["message"],
      walletList: List<Wallet>.from(
          json["data"].map((x) => Wallet.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": walletList,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
