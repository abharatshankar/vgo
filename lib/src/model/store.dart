import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'response/product_list_response.dart';

@JsonSerializable()
class Store {
  int? id;
  int? store_id;
  String? username;
  String? store_name;
  String? store_username;
  String? store_type;
  String? industry;
  String? category;
  String? supply_items;
  String? location;
  String? lat_location;
  String? lng_location;
  String? status;
  List<Product>? productList;

  Store(
      {this.id,
      this.store_id,
      this.username,
      this.store_name,
      this.store_username,
      this.store_type,
      this.industry,
      this.category,
      this.supply_items,
      this.location,
      this.lat_location,
      this.lng_location,
      this.status,
      this.productList});

  factory Store.fromJson(Map<String, dynamic> json) => Store(
      id: json["id"],
      store_id: json["store_id"],
      username: json["username"],
      store_name: json["store_name"],
      store_username: json["store_username"],
      store_type: json["store_type"],
      industry: json["industry"],
      category: json["category"],
      supply_items: json["supply_items"],
      location: json["location"],
      lat_location: json["lat_location"],
      lng_location: json["lng_location"],
      status: json["status"],
      productList: json["products"] != null
          ? List<Product>.from(json["products"].map((x) => Product.fromJson(x)))
          : []);

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": store_id,
        "username": username,
        "store_name": store_name,
        "store_username": store_username,
        "store_type": store_type,
        "industry": industry,
        "category": category,
        "supply_items": supply_items,
        "location": location,
        "lat_location": lat_location,
        "lng_location": lng_location,
        "status": status,
        "products": productList,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}