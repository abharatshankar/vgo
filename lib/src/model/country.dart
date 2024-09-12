import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Country {
  String? countryCode;
  String? currencyCode;
  String? countryIconPath;
  String? currency;

  Country(
      {this.countryCode,
      this.currencyCode,
      this.countryIconPath,
      this.currency});

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        countryCode: json["country_code"],
        currencyCode: json["currency_code"],
        countryIconPath: json["country_icon_path"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() =>
      {
        "countryCode": countryCode,
        "currencyCode": currencyCode,
        "countryIconPath": countryIconPath,
        "currency": currency,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
