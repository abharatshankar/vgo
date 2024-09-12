import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class TransferCategory{
  String? categoryCode;
  String? categoryName;
  String? categoryIconPath;

  TransferCategory({this.categoryCode, this.categoryName, this.categoryIconPath});

  factory TransferCategory.fromJson(Map<String, dynamic> json) => TransferCategory(
    categoryCode: json["category_code"],
    categoryName: json["category_name"],
    categoryIconPath: json["category_icon_path"],
  );

  Map<String, dynamic> toJson() => {
    "category_code": categoryCode,
    "category_name": categoryName,
    "category_icon_path": categoryIconPath,
  };

  @override
  String toString() {
    return jsonEncode(this);
  }
}