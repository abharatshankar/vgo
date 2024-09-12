import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Transfers {
  int? id;
  String? transferUserName;
  String? receiverUserName;
  String? transfererName;
  String? receiverName;
  String? transfererMobileNumber;
  String? receiverMobileNumber;
  String? transCurrency;
  String? transAmount;
  String? transferAmount;
  String? createdAt;
  String? recipientId;
  String? recipientType;
  String? currencyCode;
  String? bankName;
  String? accountNumber;
  String? accountHolderName;
  String? mobileNumber;
  String? updatedAt;
  int? transactionRefNo;
  int? transactionNumber;
  String? name;
  String? amount;
  String? createdDate;
  int? colorCode;
  String? transfer_order;
  String? comments;
  List<Transfers>? childTransferList;

  Transfers(
      {this.id,
      this.transferUserName,
      this.receiverUserName,
      this.transfererName,
      this.receiverName,
      this.transfererMobileNumber,
      this.receiverMobileNumber,
      this.transCurrency,
      this.transAmount,
      this.transferAmount,
      this.createdAt,
      this.currencyCode,
      this.recipientId,
      this.recipientType,
      this.bankName,
      this.accountNumber,
      this.accountHolderName,
      this.mobileNumber,
      this.transactionRefNo,
      this.transactionNumber,
      this.name,
      this.amount,
      this.createdDate,
      this.updatedAt,
      this.transfer_order,
        this.comments,
      this.childTransferList});

  factory Transfers.fromJson(Map<String, dynamic> json) => Transfers(
        id: json["id"],
        transferUserName: json["transfer_username"],
        receiverUserName: json["receive_username"],
        transfererName: json["transferer_name"],
        receiverName: json["receiver_name"],
        transfererMobileNumber: json["transferer_mobile_number"],
        receiverMobileNumber: json["receiver_mobile_number"],
        transCurrency: json["trans_currency"],
        transAmount: json["trans_amount"],
        transferAmount: json["transfer_amount"],
        createdAt: json["created_at"],
        recipientId: json["recipient_id"],
        recipientType: json["recipient_type"],
        currencyCode: json["currency_code"],
      bankName: json["bank_name"],
      accountNumber: json["account_number"],
      accountHolderName: json["account_holder_name"],
      mobileNumber: json["mobile_number"],
      updatedAt: json["updated_at"],
      transactionRefNo: json["transaction_ref_no"],
      transactionNumber: json["transaction_no"],
      name: json["name"],
      amount: json["amount"],
      createdDate: json["created_date"],
      transfer_order: json["transfer_order"],
      comments: json["comments"],
      childTransferList: json["childs"] != null
          ? List<Transfers>.from(
              json["childs"].map((x) => Transfers.fromJson(x)))
          : []);

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "transfer_username": transferUserName,
        "receive_username": receiverUserName,
        "transferer_name": transfererName,
        "receiver_name": receiverName,
        "transferer_mobile_number": transfererMobileNumber,
        "receiver_mobile_number": receiverMobileNumber,
        "trans_currency": transCurrency,
        "trans_amount": transAmount,
        "transfer_amount": transferAmount,
        "created_at": createdAt,
        "recipient_id": recipientId,
        "recipient_type": recipientType,
        "currency_code": currencyCode,
        "bank_name": bankName,
        "account_number": accountNumber,
        "account_holder_name": accountHolderName,
        "mobile_number": mobileNumber,
        "updated_at": updatedAt,
        "transaction_ref_no": transactionRefNo,
        "transaction_no": transactionNumber,
        "name": name,
        "amount": amount,
        "created_date": createdDate,
        "childs": childTransferList,
        "transfer_order": transfer_order,
        "comments": comments,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
