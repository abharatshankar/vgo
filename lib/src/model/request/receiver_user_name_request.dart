import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ReceiverUserNameRequest {
  String? receiverUserName;

  ReceiverUserNameRequest({this.receiverUserName});

  factory ReceiverUserNameRequest.fromJson(Map<String, dynamic> json) =>
      ReceiverUserNameRequest(receiverUserName: json["receive_username"]);

  Map<String, dynamic> toJson() => {"receive_username": receiverUserName};

  @override
  String toString() {
    return jsonEncode(this);
  }
}
