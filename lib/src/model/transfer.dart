import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()

class Transfer{
  String? transferMenu;
  String? iconPath;
  String? partnerTitle;
  String? visible;

  Transfer({this.transferMenu,this.iconPath,this.partnerTitle,this.visible});

  factory Transfer.fromJson(Map<String, dynamic> json) => Transfer(
    transferMenu: json["transfer_menu"],
    iconPath: json["icon_path"],
    partnerTitle: json["partner_title"],
    visible: json["visible"],

  );

  Map<String, dynamic> toJson() => {
    "transfer_menu": transferMenu,
    "icon_path": iconPath,
    "partner_title": partnerTitle,
    "visible": visible,
  };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
