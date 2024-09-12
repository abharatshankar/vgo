import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class TeamResponse{

  bool? success;
  String? message;
  List<Team>? teamList;

  TeamResponse({this.message,this.success, this.teamList});

  factory TeamResponse.fromJson(Map<String, dynamic> json) => TeamResponse(
    success: json["success"],
    message: json["message"],
    teamList: json["data"] == null
        ? []
        : List<Team>.from(
        json["data"]!.map((x) => Team.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": teamList,
  };

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class Team{
  String? desig;
  List<TeamDetail>? teamDetailList;

  Team({this.desig, this.teamDetailList});

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    desig: json["desig"],
    teamDetailList: json["list"] == null
        ? []
        : List<TeamDetail>.from(
        json["list"]!.map((x) => TeamDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "desig": desig,
    "list": teamDetailList,
  };

}

class TeamDetail{
  String? gapId;
  String? name;
  String? location;
  String? desig;
  String? dept;
  String? createdAt;
  List<TeamDetail>? subTeamList;
  List<Earnings>? earningsList;

  TeamDetail({this.gapId, this.name, this.location, this.desig,this.dept, this.createdAt, this.subTeamList, this.earningsList});

  factory TeamDetail.fromJson(Map<String, dynamic> json) => TeamDetail(
    gapId: json["gap_id"],
    name: json["name"],
    location: json["location"],
    desig: json["desig"],
    dept: json["dept"],
    createdAt: json["created_at"],
    subTeamList: json["sub_list"] == null
        ? []
        : List<TeamDetail>.from(
        json["sub_list"]!.map((x) => TeamDetail.fromJson(x))),
    earningsList: json["earnings"] == null
        ? []
        : List<Earnings>.from(
        json["earnings"]!.map((x) => Earnings.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "gap_id": gapId,
    "name": name,
    "location": location,
    "desig": desig,
    "dept": dept,
    "created_at": createdAt,
    "sub_list": subTeamList,
    "earnings": earningsList,
  };

}

class Earnings{
  int? transactionNumber;
  String? transactionDate;
  String? customerName;
  String? storeName;
  String? transAmount;
  String? loyaltyCoins;

  Earnings({this.transactionNumber, this.transactionDate, this.customerName, this.storeName,this.transAmount, this.loyaltyCoins});

  factory Earnings.fromJson(Map<String, dynamic> json) => Earnings(
    transactionNumber: json["transaction_no"],
    transactionDate: json["transaction_date"],
    customerName: json["customer_name"],
    storeName: json["store_name"],
    transAmount: json["trans_amount"],
    loyaltyCoins: json["loyalty_coins"],
  );

  Map<String, dynamic> toJson() => {
    "transaction_no": transactionNumber,
    "transaction_date": transactionDate,
    "customer_name": customerName,
    "store_name": storeName,
    "trans_amount": transAmount,
    "loyalty_coins": loyaltyCoins,
  };
}