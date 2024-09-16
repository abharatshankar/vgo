// To parse this JSON data, do
//
//     final userHistoryResponse = userHistoryResponseFromJson(jsonString);

import 'dart:convert';

UserHistoryResponse userHistoryResponseFromJson(String str) => UserHistoryResponse.fromJson(json.decode(str));

String userHistoryResponseToJson(UserHistoryResponse data) => json.encode(data.toJson());

class UserHistoryResponse {
  bool? success;
  String? message;
  List<Datum>? data;

  UserHistoryResponse({
     this.success,
     this.message,
     this.data,
  });

  factory UserHistoryResponse.fromJson(Map<String, dynamic> json) => UserHistoryResponse(
    success: json["success"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? username;
  String? searchItem;
  String? itemCategory;
  String? itemSubCategory;
  String? itemIconPath;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
     this.id,
     this.username,
     this.searchItem,
     this.itemCategory,
     this.itemSubCategory,
     this.itemIconPath,
     this.createdAt,
     this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    username: json["username"],
    searchItem: json["search_item"],
    itemCategory: json["item_category"],
    itemSubCategory: json["item_sub_category"],
    itemIconPath: json["item_icon_path"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "search_item": searchItem,
    "item_category": itemCategory,
    "item_sub_category": itemSubCategory,
    "item_icon_path": itemIconPath,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
