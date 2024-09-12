import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../country.dart';

@JsonSerializable()
class CurrencyListResponse {
  List<Country>? currencyList;

  CurrencyListResponse({this.currencyList});

  factory CurrencyListResponse.fromJson(Map<String, dynamic> json) =>
      CurrencyListResponse(
          currencyList: List<Country>.from(json["data"].map((x) => Country.fromJson(x))));

  Map<String, dynamic> toJson() => {
    "data": currencyList,
  };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
