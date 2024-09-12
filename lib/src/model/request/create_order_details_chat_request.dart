import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CreateOrderDetailsChatRequest {
  String? order_no;
  String? user_type;
  String? comments;

  CreateOrderDetailsChatRequest({
    this.order_no,
    this.user_type,
    this.comments,
  });

  factory CreateOrderDetailsChatRequest.fromJson(Map<String, dynamic> json) =>
      CreateOrderDetailsChatRequest(
        order_no: json["order_no"],
        user_type: json["user_type"],
        comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "order_no": order_no,
        "user_type": user_type,
        "comments": comments,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
