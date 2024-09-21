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
  int orderNo;
  DateTime orderDate;
  String orderType;
  String category;
  String subCategory;
  String orderPriority;
  dynamic name;
  dynamic gapId;
  String itemName;
  String orderItems;
  String? orderAmount;
  String? gstAmount;
  String? totalAmount;
  String username;
  int? storeId;
  dynamic loyaltyCoins;
  DateTime? orderConfirmDate;
  DateTime? paymentDate;
  DateTime? orderDeliveryDate;
  DateTime? deliveryConfirmDate;
  DateTime? orderCancelDate;
  List<OrderDetail> orderDetails;

  Order({
    required this.orderNo,
    required this.orderDate,
    required this.orderType,
    required this.category,
    required this.subCategory,
    required this.orderPriority,
    required this.name,
    required this.gapId,
    required this.itemName,
    required this.orderItems,
    required this.orderAmount,
    required this.gstAmount,
    required this.totalAmount,
    required this.username,
    required this.storeId,
    required this.loyaltyCoins,
    required this.orderConfirmDate,
    required this.paymentDate,
    required this.orderDeliveryDate,
    required this.deliveryConfirmDate,
    required this.orderCancelDate,
    required this.orderDetails,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    orderNo: json["order_no"],
    orderDate: DateTime.parse(json["order_date"]),
    orderType: json["order_type"],
    category: json["category"],
    subCategory: json["sub_category"],
    orderPriority: json["order_priority"],
    name: json["name"],
    gapId: json["gap_id"],
    itemName: json["item_name"],
    orderItems: json["order_items"],
    orderAmount: json["order_amount"],
    gstAmount: json["gst_amount"],
    totalAmount: json["total_amount"],
    username: json["username"],
    storeId: json["store_id"],
    loyaltyCoins: json["loyalty_coins"],
    orderConfirmDate: json["order_confirm_date"] == null ? null : DateTime.parse(json["order_confirm_date"]),
    paymentDate: json["payment_date"] == null ? null : DateTime.parse(json["payment_date"]),
    orderDeliveryDate: json["order_delivery_date"] == null ? null : DateTime.parse(json["order_delivery_date"]),
    deliveryConfirmDate: json["delivery_confirm_date"] == null ? null : DateTime.parse(json["delivery_confirm_date"]),
    orderCancelDate: json["order_cancel_date"] == null ? null : DateTime.parse(json["order_cancel_date"]),
    orderDetails: List<OrderDetail>.from(json["order_details"].map((x) => OrderDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "order_no": orderNo,
    "order_date": orderDate.toIso8601String(),
    "order_type": orderType,
    "category": category,
    "sub_category": subCategory,
    "order_priority": orderPriority,
    "name": name,
    "gap_id": gapId,
    "item_name": itemName,
    "order_items": orderItems,
    "order_amount": orderAmount,
    "gst_amount": gstAmount,
    "total_amount": totalAmount,
    "username": username,
    "store_id": storeId,
    "loyalty_coins": loyaltyCoins,
    "order_confirm_date": orderConfirmDate?.toIso8601String(),
    "payment_date": paymentDate?.toIso8601String(),
    "order_delivery_date": orderDeliveryDate?.toIso8601String(),
    "delivery_confirm_date": deliveryConfirmDate?.toIso8601String(),
    "order_cancel_date": orderCancelDate?.toIso8601String(),
    "order_details": List<dynamic>.from(orderDetails.map((x) => x.toJson())),
  };
}

class OrderDetail {
  String userType;
  String comments;
  DateTime date;

  OrderDetail({
    required this.userType,
    required this.comments,
    required this.date,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    userType: json["user_type"],
    comments: json["comments"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "user_type": userType,
    "comments": comments,
    "date": date.toIso8601String(),
  };
}

