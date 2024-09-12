import 'dart:convert';
import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class TransfersOrderReceiptRequest {
  String? tableName;
  String? bankerUserName;
  String? receiptImagePath;
  String? id;
  String? transferOrderStatus;
  String? comments;

  TransfersOrderReceiptRequest({this.tableName, this.bankerUserName,this.receiptImagePath,this.id,
  this.transferOrderStatus, this.comments});

  factory TransfersOrderReceiptRequest.fromJson(Map<String, dynamic> json) =>
      TransfersOrderReceiptRequest(tableName: json["table_name"],
          bankerUserName: json["banker_username"],
          receiptImagePath: json["receipt_image_path"],
          id: json["id"],
          transferOrderStatus: json["transfer_order_status"],
          comments: json["comments"]
      );

  Map<String, dynamic> toJson() => {"table_name": tableName,
    "banker_username": bankerUserName,
    "receipt_image_path": receiptImagePath,
    "id": id,
    "transfer_order_status": transferOrderStatus,
    "comments": comments,
  };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
