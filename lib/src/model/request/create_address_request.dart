import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CreateAddressRequest {
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
  String? gap_id;
  String? city_town;
  String? lat_location;
  String? lng_location;
  String? current_location;

  CreateAddressRequest(
      {this.username,
      this.address_type,
      this.house_no,
      this.address1,
      this.address2,
      this.land_mark,
      this.city,
      this.postal_code,
      this.state,
      this.country,
      this.gap_id,
      this.city_town,
      this.lat_location,
      this.lng_location,
      this.current_location});

  factory CreateAddressRequest.fromJson(Map<String, dynamic> json) =>
      CreateAddressRequest(
        username: json["username"],
        address_type: json["address_type"],
        house_no: json["house_no"],
        address1: json["address1"],
        address2: json["address2"],
        land_mark: json["land_mark"],
        city: json["city"],
        postal_code: json["postal_code"],
        state: json["state"],
        gap_id: json["gap_id"],
        city_town: json["city_town"],
        lat_location: json["lat_location"],
        lng_location: json["lng_location"],
        current_location: json["current_location"],
      );

  Map<String, dynamic> toJson() => {
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
        "gap_id": gap_id,
        "city_town": city_town,
        "lat_location": lat_location,
        "lng_location": lng_location,
        "current_location": current_location,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
