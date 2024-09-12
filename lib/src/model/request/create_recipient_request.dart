import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CreateRecipientRequest {
  String? accountHolderName;
  String? accountNumber;
  String? mobileNumber;
  String? bankName;
  String? recipientId;
  String? currencyCode;
  String? userName;
  String? recipientType;

  CreateRecipientRequest(
      {this.accountHolderName,
        this.accountNumber,
        this.bankName,
        this.userName,
        this.currencyCode,
        this.mobileNumber,
        this.recipientId,
        this.recipientType
       });

  factory CreateRecipientRequest.fromJson(Map<String, dynamic> json) =>
      CreateRecipientRequest(
        accountHolderName: json["account_holder_name"],
        accountNumber: json["account_number"],
        currencyCode: json["currency_code"],
        bankName: json["bank_name"],
        mobileNumber: json["mobile_number"],
        userName: json["username"],
        recipientId: json["recipient_id"],
        recipientType: json["recipient_type"],
      );

  Map<String, dynamic> toJson() => {
    "account_holder_name": accountHolderName,
    "account_number": accountNumber,
    "currency_code": currencyCode,
    "bank_name": bankName,
    "mobile_number": mobileNumber,
    "username": userName,
    "recipient_id": recipientId,
    "recipient_type": recipientType,
  };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
