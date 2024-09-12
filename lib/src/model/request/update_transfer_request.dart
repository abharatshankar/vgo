import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UpdateTransferRequest {
  String? userName;
  String? transferAccountType;
  String? bankName;
  String? accountNumber;
  String? transferCurrency;
  String? transferAmount;
  String? bankerUserName;
  String? receiptImagePath;
  String? status;

  UpdateTransferRequest(
      {this.userName,
      this.transferAccountType,
      this.bankName,
      this.accountNumber,
      this.transferCurrency,
      this.transferAmount,
      this.bankerUserName,
      this.receiptImagePath,
      this.status});

  factory UpdateTransferRequest.fromJson(Map<String, dynamic> json) =>
      UpdateTransferRequest(
        userName: json["username"],
        transferAccountType: json["transfer_account_type"],
        bankName: json["bank_name"],
        accountNumber: json["account_number"],
        transferCurrency: json["transfer_currency"],
        transferAmount: json["transfer_amount"],
        bankerUserName: json["banker_username"],
        receiptImagePath: json["receipt_image_path"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "username": userName,
        "transfer_account_type": transferAccountType,
        "bank_name": bankName,
        "account_number": accountNumber,
        "transfer_currency": transferCurrency,
        "transfer_amount": transferAmount,
        "banker_username": bankerUserName,
        "receipt_image_path": receiptImagePath,
        "status": status ,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
