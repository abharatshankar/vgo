import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CreateTeamRequest {
  String? resp_gap_id;
  String? input_gap_id;

  CreateTeamRequest({
    this.resp_gap_id,
    this.input_gap_id,
  });

  factory CreateTeamRequest.fromJson(Map<String, dynamic> json) =>
      CreateTeamRequest(
        resp_gap_id: json["resp_gap_id"],
        input_gap_id: json["input_gap_id"],
      );

  Map<String, dynamic> toJson() => {
        "resp_gap_id": resp_gap_id,
        "input_gap_id": input_gap_id,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
