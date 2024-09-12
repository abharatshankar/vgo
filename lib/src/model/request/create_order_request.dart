import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CreateOrderRequest {
  String? username;
  String? store_username;
  String? store_id;
  String? order_items;
/*  String? order_amount;
  String? gst_amount;
  String? status;*/

  CreateOrderRequest(
      {this.username,
      this.store_username,
      this.store_id,
      this.order_items,
   /*   this.order_amount,
      this.gst_amount,
      this.status*/});

  factory CreateOrderRequest.fromJson(Map<String, dynamic> json) =>
      CreateOrderRequest(
        username: json["username"],
        store_username: json["store_username"],
        store_id: json["store_id"],
        order_items: json["order_items"],
       /* order_amount: json["order_amount"],
        gst_amount: json["gst_amount"],
        status: json["status"],*/
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "store_username": store_username,
        "store_id": store_id,
        "order_items": order_items,
        // "order_amount": order_amount,
        // "gst_amount": gst_amount,
        // "status": status,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
