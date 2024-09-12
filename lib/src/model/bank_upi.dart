import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BankUPI {
  String? bankName;
  String? userName;
  String? country;
  String? currency;
  String? accountNumber;
  String? accountHolderName;
  String? balance;
  String? bankIconPath;
  String? createdAT;
  String? updatedAT;
  int? id;
  String? upiName;
  String? upiIconPath;

  BankUPI({
    this.bankName,
    this.upiName,
    this.accountNumber,
    this.accountHolderName,
    this.currency,
    this.bankIconPath,
    this.country,
    this.balance,
    this.id,
    this.updatedAT,
    this.createdAT,
    this.upiIconPath,
    this.userName,
  });

  factory BankUPI.fromJson(Map<String, dynamic> json) => BankUPI(
        bankName: json["bank_name"],
        userName: json["username"],
        country: json["country"],
        currency: json["currency"],
        upiName: json["upi_name"],
        accountHolderName: json["account_holder_name"],
        accountNumber: json["account_number"],
        balance: json["balance"],
        bankIconPath: json["bank_icon_path"],
        createdAT: json["created_at"],
        updatedAT: json["updated_at"],
        id: json["id"],
        upiIconPath: json["upi_icon_path"],
      );

  Map<String, dynamic> toJson() =>
      {
        "bank_name": bankName,
        "upi_name": upiName,
        "username": userName,
        "country": country,
        "currency": currency,
        "account_holder_name": accountHolderName,
        "account_number": accountNumber,
        "balance": balance,
        "bank_icon_path": bankIconPath,
        "created_at": createdAT,
        "updated_at": updatedAT,
        "id": id,
        "upi_icon_path": upiIconPath,

      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
