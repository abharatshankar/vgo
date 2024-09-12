import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UpiTransferRequest {
  String? transferAmount;
  String? transferPurpose;
  String? transferType;
  String? userName;
  String? exchangeAmount;
  String? receiveAmount;
  String? recipientId;
  String? transactionFees;

  UpiTransferRequest({
    this.transferAmount,
    this.transferPurpose,
    this.transferType,
    this.userName,
    this.recipientId,
    this.exchangeAmount,
    this.receiveAmount,
    this.transactionFees,
  });

  factory UpiTransferRequest.fromJson(Map<String, dynamic> json) =>
      UpiTransferRequest(
        transferAmount: json["transfer_amount"],
        transferPurpose: json["transfer_purpose"],
        transferType: json["transfer_type"],
        userName: json["username"],
        exchangeAmount: json["exchange_amount"],
        recipientId: json["recipient_id"],
        receiveAmount: json["receive_amount"],
        transactionFees: json["transaction_fees"],
      );

  Map<String, dynamic> toJson() => {
        "transfer_amount": transferAmount,
        "transfer_purpose": transferPurpose,
        "transfer_type": transferType,
        "username": userName,
        "exchange_amount": exchangeAmount,
        "receive_amount": receiveAmount,
        "recipient_id": recipientId,
        "transaction_fees": transactionFees,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
