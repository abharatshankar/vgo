import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MobileNumberRequest {
  String? mobileNumber;

  MobileNumberRequest({this.mobileNumber});

  factory MobileNumberRequest.fromJson(Map<String, dynamic> json) =>
      MobileNumberRequest(mobileNumber: json["mobile_number"]);

  Map<String, dynamic> toJson() => {"mobile_number": mobileNumber};

@override
  String toString() {
    return jsonEncode(this);
  }
}
