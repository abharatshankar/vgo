import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Coin {
  String? transUserName;
  String? receiveUsername;
  String? transType;
  String? subTransType;
  int? transactionRefNo;
  String? recipientTransNo;
  String? transferOrder;
  String? transferAmount;
  String? transAmount;
  String? transCurrency;
  String? orderCoins;
  String? orderId;
  String? paymentConfirm;
  String? loyaltyCoins;
  String? transDesc;
  String? receiptImagePath;
  String? createdAt;
  String? updatedAt;
  int? id;
  String? transImage;
  String? transfererName;
  String? receiverName;
  String? transDate;
  String? ledgerAmount;
  String? totalAmount;
  String? coinVolume;
  String? totalCoinVolume;
  String? coinValue;
  String? currency;
  int? status;
  String? teamCoins;
  String? totalCoins;
  String? ledgerCurrency;
  String? currencyDepresiationAmount;
  String? transfererMobileNumber;
  String? receiverMobileNumber;
  String? bankName;
  String? upiName;
  String? accountNumber;
  String? transferOrderStatus;
  String? bankerUserName;
  String? accountHolderName;
  String? userName;
  String? country;
  String? balance;
  String? bankIconPath;
  String? tableName;
  int? colorCode;
  String? transaction_id;

  Coin(
      {this.coinValue,
      this.updatedAt,
      this.coinVolume,
      this.createdAt,
      this.currency,
      this.id,
      this.ledgerAmount,
      this.loyaltyCoins,
      this.orderCoins,
      this.orderId,
      this.paymentConfirm,
      this.receiptImagePath,
      this.receiverName,
      this.receiveUsername,
      this.recipientTransNo,
      this.status,
      this.subTransType,
      this.totalAmount,
      this.totalCoinVolume,
      this.transactionRefNo,
      this.transAmount,
      this.transCurrency,
      this.transDate,
      this.transDesc,
      this.transfererName,
      this.transferOrder,
      this.transImage,
      this.transType,
      this.transUserName,
      this.teamCoins,
      this.totalCoins,
      this.ledgerCurrency,
      this.currencyDepresiationAmount,
      this.accountNumber,
      this.bankerUserName,
      this.bankName,
      this.upiName,
      this.receiverMobileNumber,
      this.transfererMobileNumber,
      this.transferOrderStatus,
      this.accountHolderName,
      this.userName,
      this.country,
      this.balance,
      this.bankIconPath,
      this.tableName,
      this.transferAmount,
      this.transaction_id});

  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
        transUserName: json["transfer_username"],
        receiveUsername: json["receive_username"],
        transType: json["trans_type"],
        subTransType: json["sub_trans_type"],
        transactionRefNo: json["transaction_ref_no"],
        recipientTransNo: json["recipient_trans_no"],
        transferOrder: json["transfer_order"],
        transAmount: json["trans_amount"],
        transCurrency: json["trans_currency"],
        orderCoins: json["order_coins"],
        orderId: json["order_id"],
        paymentConfirm: json["payment_confirm"],
        loyaltyCoins: json["loyalty_coins"],
        transDesc: json["trans_desc"],
        receiptImagePath: json["receipt_image_path"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        id: json["id"],
        transImage: json["trans_logo_path"],
        transfererName: json["transferer_name"],
        receiverName: json["receiver_name"],
        transDate: json["trans_date"],
        ledgerAmount: json["ledger_amount"],
        totalAmount: json["total_amount"],
        coinVolume: json["coin_volume"],
        totalCoinVolume: json["total_coin_volume"],
        coinValue: json["coin_value"],
        currency: json["currency"],
        status: json["status"],
        teamCoins: json["team_coins"],
        totalCoins: json["total_coins"],
        ledgerCurrency: json["ledger_currency"],
        currencyDepresiationAmount: json["currency_depresiation_amount"],
        transfererMobileNumber: json["transferer_mobile_number"],
        receiverMobileNumber: json["receiver_mobile_number"],
        bankName: json["bank_name"],
        upiName: json["upi_name"],
        accountNumber: json["account_number"],
        transferOrderStatus: json["transfer_order_status"],
        bankerUserName: json["banker_username"],
        accountHolderName: json["account_holder_name"],
        userName: json["username"],
        country: json["country"],
        balance: json["balance"],
        bankIconPath: json["bank_icon_path"],
        tableName: json["table_name"],
        transferAmount: json["transfer_amount"],
        transaction_id: json["transaction_id"],
      );

  Map<String, dynamic> toJson() => {
        "transfer_username": transUserName,
        "receive_username": receiveUsername,
        "trans_type": transType,
        "sub_trans_type": subTransType,
        "transaction_ref_no": transactionRefNo,
        "recipient_trans_no": recipientTransNo,
        "transfer_order": transferOrder,
        "trans_amount": transAmount,
        "trans_currency": transCurrency,
        "order_coins": orderCoins,
        "order_id": orderId,
        "payment_confirm": paymentConfirm,
        "loyalty_coins": loyaltyCoins,
        "trans_desc": transDesc,
        "receipt_image_path": receiptImagePath,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "id": id,
        "trans_logo_path": transImage,
        "transferer_name": transfererName,
        "receiver_name": receiverName,
        "trans_date": transDate,
        "ledger_amount": ledgerAmount,
        "total_amount": totalAmount,
        "coin_volume": coinVolume,
        "total_coin_volume": totalCoinVolume,
        "coin_value": coinValue,
        "currency": currency,
        "status": status,
        "team_coins": teamCoins,
        "total_coins": totalCoins,
        "ledger_currency": ledgerCurrency,
        "currency_depresiation_amount": currencyDepresiationAmount,
        "transferer_mobile_number": transfererMobileNumber,
        "receiver_mobile_number": receiverMobileNumber,
        "bank_name": bankName,
        "upi_name": upiName,
        "account_number": accountNumber,
        "transfer_order_status": transferOrderStatus,
        "banker_username": bankerUserName,
        "account_holder_name": accountHolderName,
        "username": userName,
        "country": country,
        "balance": balance,
        "table_name": tableName,
        "bank_icon_path": bankIconPath,
        "transfer_amount": transferAmount,
        "transaction_id": transaction_id,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
