import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CreateTransferRequest {
  String? receiveUserName;
  String? transferAmount;
  String? transferPurpose;
  String? transferType;
  String? userName;
  String? accountNumber;
  String? bankName;
  String? bankerUserName;
  String? exchangeAmount;
  String? recipientImagePath;
  String? receiveAmount;
  String? recipientId;
  String? transactionFees;
  String? transferAccountType;
  String? transferCurrency;

  CreateTransferRequest(
      {this.receiveUserName,
      this.transferAmount,
      this.transferPurpose,
      this.transferType,
    this.userName,
    this.accountNumber,
    this.recipientId,
    this.bankName,
    this.bankerUserName,
    this.exchangeAmount,
    this.receiveAmount,
    this.recipientImagePath,
    this.transactionFees,
    this.transferAccountType,
    this.transferCurrency,
  });

  factory CreateTransferRequest.fromJson(Map<String, dynamic> json) =>
      CreateTransferRequest(
        receiveUserName: json["receive_username"],
        transferAmount: json["transfer_amount"],
        transferPurpose: json["transfer_purpose"],
        transferType: json["transfer_type"],
        userName: json["username"],
        accountNumber: json["account_number"],
        bankName: json["bank_name"],
        bankerUserName: json["banker_username"],
        exchangeAmount: json["exchange_amount"],
        recipientImagePath: json["receipt_image_path"],
        recipientId: json["recipient_id"],
        receiveAmount: json["receive_amount"],
        transactionFees: json["transaction_fees"],
        transferAccountType: json["transfer_account_type"],
        transferCurrency: json["transfer_currency"],
      );

  Map<String, dynamic> toJson() => {
        "receive_username": receiveUserName,
        "transfer_amount": transferAmount,
        "transfer_purpose": transferPurpose,
        "transfer_type": transferType,
        "username": userName,
        "account_number": accountNumber,
        "bank_name": bankName,
        "banker_username": bankerUserName,
        "exchange_amount": exchangeAmount,
        "receipt_image_path": recipientImagePath,
        "receive_amount": receiveAmount,
        "recipient_id": recipientId,
        "transaction_fees": transactionFees,
        "transfer_account_type": transferAccountType,
        "transfer_currency": transferCurrency,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
