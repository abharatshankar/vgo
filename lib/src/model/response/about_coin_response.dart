import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AboutCoinResponse {
  List<String>? aboutCoinList;
  List<String>? aboutPointsList;

  AboutCoinResponse({this.aboutCoinList, this.aboutPointsList});

  factory AboutCoinResponse.fromJson(Map<String, dynamic> json) =>
      AboutCoinResponse(
        aboutCoinList: json["about"] == null
            ? []
            : List<String>.from(json["about"]!.map((x) => x)),
        aboutPointsList: json["points"] == null
            ? []
            : List<String>.from(json["points"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "about": aboutCoinList,
        "points": aboutPointsList,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
