import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class OrderListResponse {
  bool? success;
  String? message;
  List<OrderStatusTab>? industryList;

  OrderListResponse({this.message, this.industryList, this.success});

  factory OrderListResponse.fromJson(Map<String, dynamic> json) =>
      OrderListResponse(
          success: json["success"],
          message: json["message"],
          industryList: json["data"] != null
              ? List<OrderStatusTab>.from(
                  json["data"].map((x) => OrderStatusTab.fromJson(x)))
              : []);

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": industryList,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class OrderStatusTab {
  String? status;
  String? date;
  List<Order>? orderList;

  OrderStatusTab({this.status, this.date, this.orderList});

  factory OrderStatusTab.fromJson(Map<String, dynamic> json) => OrderStatusTab(
      status: json["status"],
      date: json["date"],
      orderList: json["orders"] != null
          ? List<Order>.from(json["orders"].map((x) => Order.fromJson(x)))
          : []);

  Map<String, dynamic> toJson() => {
        "status": status,
        "date": date,
        "orders": orderList,
      };
}

class Order {
  int? order_no;
  String? order_date;
  String? order_items;
  String? order_amount;
  String? gst_amount;
  String? total_amount;
  String? username;
  int? store_id;
  String? loyalty_coins;
  String? order_confirm_date;
  String? payment_date;
  String? order_delivery_date;
  String? delivery_confirm_date;
  String? order_cancel_date;

  Order(
      {this.order_no,
      this.order_date,
      this.order_items,
      this.order_amount,
      this.gst_amount,
      this.total_amount,
      this.username,
      this.store_id,
      this.loyalty_coins,
      this.order_confirm_date,
      this.payment_date,
      this.order_delivery_date,
      this.delivery_confirm_date,
      this.order_cancel_date});

  factory Order.fromJson(Map<String, dynamic> json) => Order(
      order_no: json["order_no"],
      order_date: json["order_date"],
      order_items: json["order_items"],
      order_amount: json["order_amount"],
      gst_amount: json["gst_amount"],
      total_amount: json["total_amount"],
      username: json["username"],
      store_id: json["store_id"],
      loyalty_coins: json["loyalty_coins"],
      order_confirm_date: json["order_confirm_date"],
      payment_date: json["payment_date"],
      order_delivery_date: json["order_delivery_date"],
      delivery_confirm_date: json["delivery_confirm_date"],
      order_cancel_date: json["order_cancel_date"]);

  Map<String, dynamic> toJson() =>
      {
        "order_no": order_no,
        "order_date": order_date,
        "order_items": order_items,
        "order_amount": order_amount,
        "gst_amount": gst_amount,
        "total_amount": total_amount,
        "username": username,
        "store_id": store_id,
        "loyalty_coins": loyalty_coins,
        "order_confirm_date": order_confirm_date,
        "payment_date": payment_date,
        "order_delivery_date": order_delivery_date,
        "delivery_confirm_date": delivery_confirm_date,
        "order_cancel_date": order_cancel_date,
      };
}
