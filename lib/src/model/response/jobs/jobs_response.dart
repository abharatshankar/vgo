import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../job.dart';

@JsonSerializable()
class JobsResponse {
  bool? success;
  String? message;
  Job? job;

  JobsResponse({this.success, this.message, this.job});

  factory JobsResponse.fromJson(Map<String, dynamic> json) => JobsResponse(
        success: json["success"],
        message: json["message"],
        job: json["data"] != null ? Job.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": job,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
