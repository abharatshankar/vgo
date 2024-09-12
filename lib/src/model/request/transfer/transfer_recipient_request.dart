import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class TransferRecipientRequest {
  String? recipientId;
  String? username;

  TransferRecipientRequest({this.recipientId, this.username});

  factory TransferRecipientRequest.fromJson(Map<String, dynamic> json) =>
      TransferRecipientRequest(
          username: json["mobile_number"], recipientId: json["recipient_id"]);

  Map<String, dynamic> toJson() =>
      {"username": username, "recipient_id": recipientId};

  @override
  String toString() {
    return jsonEncode(this);
  }
}
