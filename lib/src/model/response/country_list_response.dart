import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../country.dart';

@JsonSerializable()
class CountryListResponse {
  List<Country>? countryList;

  CountryListResponse({this.countryList});

  factory CountryListResponse.fromJson(Map<String, dynamic> json) =>
      CountryListResponse(
          countryList: List<Country>.from(json["country_codes"].map((x) => Country.fromJson(x))));

  Map<String, dynamic> toJson() => {
    "country_codes": countryList,
  };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
