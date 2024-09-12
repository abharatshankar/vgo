import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class OTPRequest {
  String? mobileNumber;
  String? otp;

  OTPRequest({this.mobileNumber, this.otp});

  factory OTPRequest.fromJson(Map<String, dynamic> json) =>
      OTPRequest(mobileNumber: json["mobile_number"], otp: json["otp"]);

  Map<String, dynamic> toJson() => {"mobile_number": mobileNumber, "otp": otp};

  @override
  String toString() {
    return jsonEncode(this);
  }
}
