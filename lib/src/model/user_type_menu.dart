import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserTypeMenu {
  String? userType;
  List<String>? userSubTypeList;
  List<String>? profession;

  UserTypeMenu({this.userType, this.userSubTypeList, this.profession});

  factory UserTypeMenu.fromJson(Map<String, dynamic> json) => UserTypeMenu(
        userType: json["user_type"],
        userSubTypeList: json["user_sub_types"] == null
            ? []
            : List<String>.from(json["user_sub_types"]!.map((x) => x)),
        profession: json["profession"] == null
            ? []
            : List<String>.from(json["profession"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "user_type": userType,
        "user_sub_types": userSubTypeList,
        "profession": profession,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
