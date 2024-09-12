import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:vgo_flutter_app/src/model/job.dart';

@JsonSerializable()
class JobsListResponse {
  bool? success;
  String? message;
  List<Job>? jobList;

  JobsListResponse({this.success, this.message, this.jobList});

  factory JobsListResponse.fromJson(Map<String, dynamic> json) =>
      JobsListResponse(
          success: json["success"],
          message: json["message"],
          jobList: List<Job>.from(json["data"].map((x) => Job.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": jobList,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
