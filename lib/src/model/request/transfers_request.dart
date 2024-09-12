import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class TransfersRequest {
  String? tableName;
  String? userName;

  TransfersRequest({this.tableName, this.userName});

  factory TransfersRequest.fromJson(Map<String, dynamic> json) =>
      TransfersRequest(tableName: json["table_name"],userName: json["username"]);

  Map<String, dynamic> toJson() => {"table_name": tableName, "username": userName,};

  @override
  String toString() {
    return jsonEncode(this);
  }
}
