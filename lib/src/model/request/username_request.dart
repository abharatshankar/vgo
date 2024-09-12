import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UsernameRequest {
  String? username;

  UsernameRequest({this.username});

  factory UsernameRequest.fromJson(Map<String, dynamic> json) =>
      UsernameRequest(username: json["username"]);

  Map<String, dynamic> toJson() => {"username": username};

  @override
  String toString() {
    return jsonEncode(this);
  }
}
