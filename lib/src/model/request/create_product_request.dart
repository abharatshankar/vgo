import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CreateProductRequest {
  String? store_id;
  String? category;
  String? product_name;
  String? product_desc;
  String? price;
  String? status;

  CreateProductRequest({
    this.store_id,
    this.category,
    this.product_name,
    this.product_desc,
    this.price,
    this.status,
  });

  factory CreateProductRequest.fromJson(Map<String, dynamic> json) =>
      CreateProductRequest(
        store_id: json["store_id"],
        category: json["category"],
        product_name: json["product_name"],
        product_desc: json["product_desc"],
        price: json["price"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "store_id": store_id,
        "category": category,
        "product_name": product_name,
        "product_desc": product_desc,
        "price": price,
        "status": status,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
