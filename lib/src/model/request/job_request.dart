import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class JobRequest {
  int? job_id;
  String? username;
  String? job_status;
  String? job_title;
  String? industry;
  String? category;
  String? key_skills;
  String? job_desc;
  String? budget_amount;
  String? company_name;
  String? message;
  String? user_type;
  String? status;

  JobRequest(
      {this.job_id,
      this.username,
      this.job_status,
      this.job_title,
      this.industry,
      this.category,
      this.key_skills,
      this.job_desc,
      this.budget_amount,
      this.company_name,
      this.message,
      this.user_type,
      this.status});

  factory JobRequest.fromJson(Map<String, dynamic> json) => JobRequest(
        job_id: json["job_id"],
        username: json["username"],
        job_status: json["job_status"],
        job_title: json["job_title"],
        industry: json["industry"],
        category: json["category"],
        key_skills: json["key_skills"],
        job_desc: json["job_desc"],
        budget_amount: json["budget_amount"],
        company_name: json["company_name"],
        message: json["message"],
        user_type: json["user_type"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "job_id": job_id,
        "username": username,
        "job_status": job_status,
        "job_title": job_title,
        "industry": industry,
        "category": category,
        "key_skills": key_skills,
        "job_desc": job_desc,
        "budget_amount": budget_amount,
        "company_name": company_name,
        "message": message,
        "user_type": user_type,
        "status": status
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
