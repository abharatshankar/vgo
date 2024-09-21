// To parse this JSON data, do
//
//     final directOrderResponse = directOrderResponseFromJson(jsonString);

import 'dart:convert';

DirectOrderResponse directOrderResponseFromJson(String str) => DirectOrderResponse.fromJson(json.decode(str));

String directOrderResponseToJson(DirectOrderResponse data) => json.encode(data.toJson());

class DirectOrderResponse {
  bool success;
  String message;
  List<DirectOrder> data;

  DirectOrderResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DirectOrderResponse.fromJson(Map<String, dynamic> json) => DirectOrderResponse(
    success: json["success"],
    message: json["message"],
    data: List<DirectOrder>.from(json["data"].map((x) => DirectOrder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DirectOrder {
  int id;
  String orderType;
  String username;
  String? storeUsername;
  int? storeId;
  String category;
  String subCategory;
  String orderPriority;
  dynamic deliveryUsername;
  dynamic name;
  dynamic gapId;
  String itemName;
  String orderItems;
  String? orderAmount;
  String? gstAmount;
  String? totalAmount;
  dynamic loyaltyCoins;
  DateTime? orderConfirmDate;
  DateTime? paymentDate;
  dynamic orderAcceptDate;
  int? storeOtp;
  int? customerOtp;
  int? deliveryAddressId;
  dynamic trackingComments;
  DateTime? orderDeliveryDate;
  DateTime? deliveryConfirmDate;
  DateTime? orderCancelDate;
  dynamic remarks;
  String orderStatus;
  DateTime createdAt;
  DateTime updatedAt;

  DirectOrder({
    required this.id,
    required this.orderType,
    required this.username,
    required this.storeUsername,
    required this.storeId,
    required this.category,
    required this.subCategory,
    required this.orderPriority,
    required this.deliveryUsername,
    required this.name,
    required this.gapId,
    required this.itemName,
    required this.orderItems,
    required this.orderAmount,
    required this.gstAmount,
    required this.totalAmount,
    required this.loyaltyCoins,
    required this.orderConfirmDate,
    required this.paymentDate,
    required this.orderAcceptDate,
    required this.storeOtp,
    required this.customerOtp,
    required this.deliveryAddressId,
    required this.trackingComments,
    required this.orderDeliveryDate,
    required this.deliveryConfirmDate,
    required this.orderCancelDate,
    required this.remarks,
    required this.orderStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DirectOrder.fromJson(Map<String, dynamic> json) => DirectOrder(
    id: json["id"],
    orderType: json["order_type"],
    username: json["username"],
    storeUsername: json["store_username"],
    storeId: json["store_id"],
    category: json["category"],
    subCategory: json["sub_category"],
    orderPriority: json["order_priority"],
    deliveryUsername: json["delivery_username"],
    name: json["name"],
    gapId: json["gap_id"],
    itemName: json["item_name"],
    orderItems: json["order_items"],
    orderAmount: json["order_amount"],
    gstAmount: json["gst_amount"],
    totalAmount: json["total_amount"],
    loyaltyCoins: json["loyalty_coins"],
    orderConfirmDate: json["order_confirm_date"] == null ? null : DateTime.parse(json["order_confirm_date"]),
    paymentDate: json["payment_date"] == null ? null : DateTime.parse(json["payment_date"]),
    orderAcceptDate: json["order_accept_date"],
    storeOtp: json["store_otp"],
    customerOtp: json["customer_otp"],
    deliveryAddressId: json["delivery_address_id"],
    trackingComments: json["tracking_comments"],
    orderDeliveryDate: json["order_delivery_date"] == null ? null : DateTime.parse(json["order_delivery_date"]),
    deliveryConfirmDate: json["delivery_confirm_date"] == null ? null : DateTime.parse(json["delivery_confirm_date"]),
    orderCancelDate: json["order_cancel_date"] == null ? null : DateTime.parse(json["order_cancel_date"]),
    remarks: json["remarks"],
    orderStatus: json["order_status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_type": orderType,
    "username": username,
    "store_username": storeUsername,
    "store_id": storeId,
    "category": category,
    "sub_category": subCategory,
    "order_priority": orderPriority,
    "delivery_username": deliveryUsername,
    "name": name,
    "gap_id": gapId,
    "item_name": itemName,
    "order_items": orderItems,
    "order_amount": orderAmount,
    "gst_amount": gstAmount,
    "total_amount": totalAmount,
    "loyalty_coins": loyaltyCoins,
    "order_confirm_date": orderConfirmDate?.toIso8601String(),
    "payment_date": paymentDate?.toIso8601String(),
    "order_accept_date": orderAcceptDate,
    "store_otp": storeOtp,
    "customer_otp": customerOtp,
    "delivery_address_id": deliveryAddressId,
    "tracking_comments": trackingComments,
    "order_delivery_date": orderDeliveryDate?.toIso8601String(),
    "delivery_confirm_date": deliveryConfirmDate?.toIso8601String(),
    "order_cancel_date": orderCancelDate?.toIso8601String(),
    "remarks": remarks,
    "order_status": orderStatus,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
