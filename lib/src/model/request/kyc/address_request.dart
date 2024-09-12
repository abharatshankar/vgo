import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AddressRequest {
  String? address1;
  String? address2;
  String? cityTown;
  String? country;
  String? currentLocation;
  String? gapId;
  String? houseNo;
  String? landMark;
  String? latLocation;
  String? lngLocation;
  String? postalCode;
  String? state;

  AddressRequest(
      {this.address1,
      this.address2,
      this.cityTown,
      this.country,
      this.currentLocation,
      this.gapId,
      this.houseNo,
      this.landMark,
      this.latLocation,
      this.lngLocation,
      this.postalCode,
      this.state});

  factory AddressRequest.fromJson(Map<String, dynamic> json) => AddressRequest(
        address1: json["address1"],
        address2: json["address2"],
        cityTown: json["city_town"],
        country: json["country"],
        currentLocation: json["current_location"],
        gapId: json["gap_id"],
        houseNo: json["house_no"],
        landMark: json["land_mark"],
        latLocation: json["lat_location"],
        lngLocation: json["lng_location"],
        postalCode: json["postal_code"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "address1": address1,
        "address2": address2,
        "city_town": cityTown,
        "country": country,
        "current_location": currentLocation,
        "gap_id": gapId,
        "house_no": houseNo,
        "land_mark": landMark,
        "lat_location": latLocation,
        "lng_location": lngLocation,
        "postal_code": postalCode,
        "state": state,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
