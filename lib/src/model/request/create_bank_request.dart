import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CreateBankRequest {
  String? accountHolderName;
  String? accountNumber;
  String? bankIconPath;
  String? bankName;
  String? country;
  String? currency;
  String? userName;
  String? category;

  CreateBankRequest(
      {this.accountHolderName,
      this.accountNumber,
      this.country,
      this.bankName,
      this.bankIconPath,
      this.userName,
      this.currency,
      this.category});

  factory CreateBankRequest.fromJson(Map<String, dynamic> json) =>
      CreateBankRequest(
        accountHolderName: json["account_holder_name"],
        accountNumber: json["account_number"],
        country: json["country"],
        bankName: json["bank_name"],
        bankIconPath: json["bank_icon_path"],
        userName: json["username"],
        currency: json["currency"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() =>
      {
        "account_holder_name": accountHolderName,
        "account_number": accountNumber,
        "country": country,
        "bank_name": bankName,
        "bank_icon_path": bankIconPath,
        "username": userName,
        "currency": currency,
        "category": category,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
