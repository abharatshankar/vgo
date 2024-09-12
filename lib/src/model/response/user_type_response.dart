import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../user_type_menu.dart';

@JsonSerializable()
class UserTypeResponse {

  List<UserTypeMenu>? userTypeMenuList;

  UserTypeResponse({this.userTypeMenuList});

  factory UserTypeResponse.fromJson(Map<String, dynamic> json) =>
      UserTypeResponse(
          userTypeMenuList: List<UserTypeMenu>.from(
              json["user_type_menus"].map((x) => UserTypeMenu.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "user_type_menus": userTypeMenuList,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
