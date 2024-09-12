import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BannerListResponse {
  List<String>? bannerList;


  BannerListResponse({this.bannerList});

  factory BannerListResponse.fromJson(Map<String, dynamic> json) =>
      BannerListResponse(
        bannerList: json["banners"] == null
            ? []
            : List<String>.from(json["banners"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
    "about": bannerList,
  };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
