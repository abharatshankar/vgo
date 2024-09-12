import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ProductListResponse {
  bool? success;
  String? message;
  List<Product>? productList;

  ProductListResponse({this.message, this.productList, this.success});

  factory ProductListResponse.fromJson(Map<String, dynamic> json) =>
      ProductListResponse(
          success: json["success"],
          message: json["message"],
          productList: json["data"] != null
              ? List<Product>.from(json["data"].map((x) => Product.fromJson(x)))
              : []);

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": productList,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class Product {
  int? id;
  int? store_id;
  String? product_name;
  String? product_desc;
  String? category;
  String? price;
  String? status;
  String? created_at;
  String? updated_at;

  Product(
      {this.id,
      this.store_id,
      this.product_name,
      this.product_desc,
      this.category,
      this.price,
      this.status,
      this.created_at,
      this.updated_at});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        store_id: json["store_id"],
        product_name: json["product_name"],
        product_desc: json["product_desc"],
        category: json["category"],
        price: json["price"],
        status: json["status"],
        created_at: json["created_at"],
        updated_at: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": store_id,
        "product_name": product_name,
        "product_desc": product_desc,
        "category": category,
        "price": price,
        "status": status,
        "created_at": created_at,
        "updated_at": updated_at,
      };
}
