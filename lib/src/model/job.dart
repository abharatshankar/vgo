import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Job {
  int? id;
  int? job_id;
  String? username;
  String? job_title;
  String? industry;
  String? category;
  String? sub_category;
  String? key_skills;
  String? job_desc;
  String? budget_amount;
  String? company_name;
  String? pickup_location;
  String? pickup_lat;
  String? pickup_lng;
  String? delivery_lat;
  String? delivery_lng;
  String? delivery_location;
  String? otp;
  String? accept_username;
  String? job_status;
  int? direction;
  String? created_at;
  String? updated_at;
  String? date;
  String? message;
  String? user_type;

  Job(
      {this.id,
      this.job_id,
      this.username,
      this.job_title,
      this.industry,
      this.category,
      this.sub_category,
      this.key_skills,
      this.job_desc,
      this.budget_amount,
      this.company_name,
      this.pickup_location,
      this.pickup_lat,
      this.pickup_lng,
      this.delivery_lat,
      this.delivery_lng,
      this.delivery_location,
      this.otp,
      this.accept_username,
      this.job_status,
      this.direction,
      this.created_at,
      this.updated_at,
      this.date,
      this.message,
      this.user_type});

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"],
        job_id: json["job_id"],
        username: json["username"],
        job_title: json["job_title"],
        industry: json["industry"],
        category: json["category"],
        sub_category: json["sub_category"],
        key_skills: json["key_skills"],
        job_desc: json["job_desc"],
        budget_amount: json["budget_amount"],
        company_name: json["company_name"],
        pickup_location: json["pickup_location"],
        pickup_lat: json["pickup_lat"],
        pickup_lng: json["pickup_lng"],
        delivery_lat: json["delivery_lat"],
        delivery_lng: json["delivery_lng"],
        delivery_location: json["delivery_location"],
        otp: json["otp"],
        accept_username: json["accept_username"],
        job_status: json["job_status"],
        direction: json["direction"],
        created_at: json["created_at"],
        updated_at: json["updated_at"],
        date: json["date"],
        message: json["message"],
        user_type: json["user_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_id": job_id,
        "username": username,
        "job_title": job_title,
        "industry": industry,
        "category": category,
        "sub_category": sub_category,
        "budget_amount": budget_amount,
        "company_name": company_name,
        "pickup_location": pickup_location,
        "pickup_lat": pickup_lat,
        "pickup_lng": pickup_lng,
        "delivery_lat": delivery_lat,
        "delivery_lng": delivery_lng,
        "delivery_location": delivery_location,
        "otp": otp,
        "accept_username": accept_username,
        "job_status": job_status,
        "direction": direction,
        "created_at": created_at,
        "updated_at": updated_at,
        "date": date,
        "message": message,
        "user_type": user_type,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
