import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class IIOCategoriesResponse {
  List<String>? iioCategoriesList;

  IIOCategoriesResponse({this.iioCategoriesList});

  factory IIOCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      IIOCategoriesResponse(
          iioCategoriesList: json["iio_categories"] == null
              ? []
              : List<String>.from(json["iio_categories"]!.map((x) => x)));

  Map<String, dynamic> toJson() => {
        "iio_categories": iioCategoriesList,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
