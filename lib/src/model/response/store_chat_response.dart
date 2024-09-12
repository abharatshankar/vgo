import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class StoreChatResponse {
  bool? success;
  String? message;
  Chat? chat;

  StoreChatResponse({this.message, this.chat, this.success});

  factory StoreChatResponse.fromJson(Map<String, dynamic> json) =>
      StoreChatResponse(
          success: json["success"],
          message: json["message"],
          chat: json["data"] != null ? Chat.fromJson(json["data"]) : null);

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": chat,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class Chat {
  int? id;
  String? order_no;
  String? user_type;
  String? comments;
  String? created_at;
  String? updated_at;

  Chat(
      {this.id,
      this.order_no,
      this.user_type,
      this.comments,
      this.created_at,
      this.updated_at});

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["id"],
        order_no: json["order_no"],
        user_type: json["user_type"],
        comments: json["comments"],
        created_at: json["created_at"],
        updated_at: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_no": order_no,
        "user_type": user_type,
        "comments": comments,
        "created_at": created_at,
        "updated_at": updated_at,
      };
}
