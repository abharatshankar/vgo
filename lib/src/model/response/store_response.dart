import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../store.dart';

@JsonSerializable()
class StoreResponse {
  bool? success;
  String? message;
  Store? store;

  StoreResponse({this.message, this.store, this.success});

  factory StoreResponse.fromJson(Map<String, dynamic> json) => StoreResponse(
        success: json["success"],
        message: json["message"],
        store: json["data"] != null ? Store.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": store,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
