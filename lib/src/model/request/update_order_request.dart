import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UpdateOrderRequest {
  String? order_items;
  String? order_amount;
  String? gst_amount;
  String? total_amount;
  String? order_status;
  String? username;
  String? delivery_address_id;
  String? store_id;

  UpdateOrderRequest(
      {this.order_amount,
      this.gst_amount,
      this.order_items,
      this.total_amount,
      this.order_status,
      this.username,
      this.delivery_address_id,
      this.store_id});

  factory UpdateOrderRequest.fromJson(Map<String, dynamic> json) =>
      UpdateOrderRequest(
        order_items: json["order_items"],
        order_amount: json["order_amount"],
        gst_amount: json["gst_amount"],
        total_amount: json["total_amount"],
        order_status: json["order_status"],
        username: json["username"],
        delivery_address_id: json["delivery_address_id"],
        store_id: json["store_id"],
      );

  Map<String, dynamic> toJson() => {
        "order_items": order_items,
        "order_amount": order_amount,
        "gst_amount": gst_amount,
        "total_amount": total_amount,
        "order_status": order_status,
        "username": username,
        "delivery_address_id": delivery_address_id,
        "store_id": store_id,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
