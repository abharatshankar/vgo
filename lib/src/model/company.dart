import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Company {
  int? id;
  int? companyCode;
  String? companyName;
  String? industry;
  String? locations;
  int? conceptId;
  String? symbol;
  String? iioCategory;
  String? seedPrice;
  String? preListingPrice;
  String? stockPrice;
  String? growthValue;
  String? companyIconPath;
  String? companyStatus;
  String? aboutCompanyPath;
  String? comments;
  String? commentProgress;
  String? department;
  String? createdAt;
  String? updatedAt;
  String? serviceName;
  String? aboutService;
  String? serviceIconPath;
  String? investmentAmount;
  String? stockQuantity;
  String? buyingPrice;
  String? currentPrice;
  String? lowStockPrice;
  String? highStockPrice;
  String? volume;
  String? userName;
  String? units;
  String? status;


  Company(
      {this.id,
      this.companyCode,
      this.companyName,
      this.industry,
      this.locations,
      this.conceptId,
      this.symbol,
      this.iioCategory,
      this.seedPrice,
      this.preListingPrice,
      this.stockPrice,
      this.growthValue,
      this.companyIconPath,
      this.companyStatus,
      this.aboutCompanyPath,
      this.comments,
      this.commentProgress,
      this.department,
      this.createdAt,
      this.updatedAt,
      this.aboutService,
      this.serviceIconPath,
      this.serviceName,
      this.investmentAmount,
      this.stockQuantity,
      this.buyingPrice,
      this.currentPrice,
      this.lowStockPrice,
      this.highStockPrice,
      this.volume,
      this.userName,
      this.units,
      this.status});

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        companyCode: json["company_code"],
        companyName: json["company_name"],
        industry: json["industry"],
        locations: json["locations"],
        conceptId: json["concept_id"],
        symbol: json["symbol"],
        iioCategory: json["iio_category"],
        seedPrice: json["seed_price"],
        preListingPrice: json["pre_listing_price"],
        stockPrice: json["stock_price"],
        growthValue: json["growth_value"],
        companyIconPath: json["company_icon_path"],
        companyStatus: json["about_company_path"],
        aboutCompanyPath: json["receipt_image_path"],
        comments: json["company_status"],
        commentProgress: json["comments"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        aboutService: json["about_service"],
        serviceIconPath: json["service_icon_path"],
        serviceName: json["service_name"],
        investmentAmount: json["investment_amount"],
        stockQuantity: json["stock_quantity"],
        buyingPrice: json["buying_price"],
        currentPrice: json["current_price"] ?? '',
        lowStockPrice: json["low_stock_price"] ?? '',
        highStockPrice: json["high_stock_price"] ?? '',
        volume: json["volume"] ?? '',
        department: json["department"] ?? '',
        userName: json["username"] ?? '',
        units: json["units"] ?? '',
        status: json["status"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_code": companyCode,
        "company_name": companyName,
        "industry": industry,
        "locations": locations,
        "concept_id": conceptId,
        "symbol": symbol,
        "iio_category": iioCategory,
        "seed_price": seedPrice,
        "pre_listing_price": preListingPrice,
        "stock_price": stockPrice,
        "growth_value": growthValue,
        "company_icon_path": companyIconPath,
        "about_company_path": aboutCompanyPath,
        "receipt_image_path": preListingPrice,
        "company_status": comments,
        "comments": commentProgress,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "about_service": aboutService,
        "service_icon_path": serviceIconPath,
        "service_name": serviceName,
        "investment_amount": investmentAmount,
        "stock_quantity": stockQuantity,
        "buying_price": buyingPrice,
        "current_price": currentPrice,
        "low_stock_price": lowStockPrice,
        "high_stock_price": highStockPrice,
        "volume": volume,
        "department": department,
        "username": userName,
        "units": units,
    "status": status,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
