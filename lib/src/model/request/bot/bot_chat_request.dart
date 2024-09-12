import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BotChatRequest {
  String? category;
  String? message;

  BotChatRequest({
    this.category,
    this.message,
  });

  factory BotChatRequest.fromJson(Map<String, dynamic> json) => BotChatRequest(
        category: json["category"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "message": message,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
