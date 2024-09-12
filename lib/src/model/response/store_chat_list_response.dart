import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class StoreChatListResponse {
  bool? success;
  String? message;
  List<Chat>? chatList;

  StoreChatListResponse({this.message, this.chatList, this.success});

  factory StoreChatListResponse.fromJson(Map<String, dynamic> json) =>
      StoreChatListResponse(
          success: json["success"],
          message: json["message"],
          chatList: json["data"] != null
              ? List<Chat>.from(json["data"].map((x) => Chat.fromJson(x)))
              : []);

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": chatList,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class Chat {
  int? id;
  int? order_no;
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
