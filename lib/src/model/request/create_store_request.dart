import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CreateStoreRequest {
  String? username;
  String? store_name;
  String? store_type;
  String? industry;
  String? category;
  String? supply_items;
  String? location;
  String? lat_location;
  String? lng_location;
  String? status;

  CreateStoreRequest(
      {this.username,
      this.store_name,
      this.store_type,
      this.industry,
      this.category,
      this.supply_items,
      this.location,
      this.lat_location,
      this.lng_location,
      this.status});

  factory CreateStoreRequest.fromJson(Map<String, dynamic> json) =>
      CreateStoreRequest(
        username: json["username"],
        store_name: json["store_name"],
        store_type: json["store_type"],
        industry: json["industry"],
        category: json["category"],
        supply_items: json["supply_items"],
        location: json["location"],
        lat_location: json["lat_location"],
        lng_location: json["lng_location"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "store_name": store_name,
        "store_type": store_type,
        "industry": industry,
        "category": category,
        "supply_items": supply_items,
        "location": location,
        "lat_location": lat_location,
        "lng_location": lng_location,
        "status": status,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
