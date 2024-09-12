import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../store.dart';

@JsonSerializable()
class StoreListResponse {
  bool? success;
  String? message;
  List<Industry>? industryList;

  StoreListResponse({this.message, this.industryList, this.success});

  factory StoreListResponse.fromJson(Map<String, dynamic> json) =>
      StoreListResponse(
          success: json["success"],
          message: json["message"],
          industryList: json["data"] != null
              ? List<Industry>.from(
                  json["data"].map((x) => Industry.fromJson(x)))
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

class Industry {
  String? industry;
  String? category;
  String? created_at;
  List<Store>? storeList;

  Industry({this.industry, this.category, this.created_at, this.storeList});

  factory Industry.fromJson(Map<String, dynamic> json) => Industry(
      industry: json["industry"],
      category: json["category"],
      created_at: json["created_at"],
      storeList: json["stores"] != null
          ? List<Store>.from(json["stores"].map((x) => Store.fromJson(x)))
          : []);

  Map<String, dynamic> toJson() =>
      {
        "success": industry,
        "category": category,
        "message": created_at,
        "stores": storeList,
      };
}
