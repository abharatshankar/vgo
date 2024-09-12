import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AddressResponse {
  bool? success;
  String? message;
  Address? address;

  AddressResponse({this.message, this.success, this.address});

  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      AddressResponse(
          success: json["success"],
          message: json["message"],
          address: json["data"] != null ? Address.fromJson(json["data"]) : null,);

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": address,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class Address {
  int? id;
  String? username;
  String? address_type;
  String? house_no;
  String? address1;
  String? address2;
  String? land_mark;
  String? city;
  String? postal_code;
  String? state;
  String? country;

  Address(
      {this.id,
      this.username,
      this.address_type,
      this.house_no,
      this.address1,
      this.address2,
      this.land_mark,
      this.city,
      this.postal_code,
      this.state,
      this.country});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        username: json["username"],
        address_type: json["address_type"],
        house_no: json["house_no"],
        address1: json["address1"],
        address2: json["address2"],
        land_mark: json["land_mark"],
        city: json["city"],
        postal_code: json["postal_code"],
        state: json["state"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "address_type": address_type,
        "house_no": house_no,
        "address1": address1,
        "address2": address2,
        "land_mark": land_mark,
        "city": city,
        "postal_code": postal_code,
        "state": state,
        "country": country,
      };
}
