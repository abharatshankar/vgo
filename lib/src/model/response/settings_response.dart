import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:vgo_flutter_app/src/model/transgent_category.dart';

@JsonSerializable()
class SettingsResponse {
  List<TransferCategory>? transferCategoriesList;

  List<TransAgent>? transAgentList;

  List<SearchItem>? searchItems;

  List<MoreMenu>? moreMenuList;

  List<MoreMenu>? teamList;

  List<ServicesMenu>? servicesMenuList;

  List<Banks>? banks;

  List<UPIs>? upis;

  List<String>? bot_categories;

  SettingsResponse(
      {this.transAgentList,
      this.moreMenuList,
      this.transferCategoriesList,
        this.searchItems,
      this.servicesMenuList,
      this.teamList,
      this.banks,
      this.upis,
      this.bot_categories});

  factory SettingsResponse.fromJson(Map<String, dynamic> json) =>
      SettingsResponse(
        transAgentList: json["trans_agent"] == null
            ? []
            : List<TransAgent>.from(
                json["trans_agent"]!.map((x) => TransAgent.fromJson(x))),
        searchItems: json["search_items"] == null ? [] :
        List<SearchItem>.from(json["search_items"].map((x) => SearchItem.fromJson(x))),

        moreMenuList: json["more_menu"] == null
            ? []
            : List<MoreMenu>.from(
                json["more_menu"]!.map((x) => MoreMenu.fromJson(x))),
        transferCategoriesList: json["transfer_categories"] == null
            ? []
            : List<TransferCategory>.from(json["transfer_categories"]!
                .map((x) => TransferCategory.fromJson(x))),
        servicesMenuList: json["services_menu"] == null
            ? []
            : List<ServicesMenu>.from(
                json["services_menu"]!.map((x) => ServicesMenu.fromJson(x))),
        teamList: json["team"] == null
            ? []
            : List<MoreMenu>.from(
                json["team"]!.map((x) => MoreMenu.fromJson(x))),
        banks: json["banks"] == null
            ? []
            : List<Banks>.from(json["banks"]!.map((x) => Banks.fromJson(x))),
        upis: json["upis"] == null
            ? []
            : List<UPIs>.from(json["upis"]!.map((x) => UPIs.fromJson(x))),
        bot_categories: json["bot_categories"] == null
            ? []
            : List<String>.from(json["bot_categories"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() =>
      {
        "trans_agent": transAgentList,
        "search_items": List<dynamic>.from(searchItems!.map((x) => x.toJson())),
        "more_menu": moreMenuList,
        "transfer_categories": transferCategoriesList,
        "services_menu": servicesMenuList,
        "team": teamList,
        "banks": banks,
        "upis": upis,
        "bot_categories": bot_categories,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class SearchItem {
  String category;
  String subCategory;
  List<String> items;

  SearchItem({
    required this.category,
    required this.subCategory,
    required this.items,
  });

  factory SearchItem.fromJson(Map<String, dynamic> json) => SearchItem(
    category: json["category"],
    subCategory: json["sub_category"],
    items: List<String>.from(json["items"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "sub_category": subCategory,
    "items": List<dynamic>.from(items.map((x) => x)),
  };
}

class TransAgent {
  String? categoryCode;
  String? categoryName;
  String? categoryIconPath;

  TransAgent({this.categoryCode, this.categoryName, this.categoryIconPath});

  factory TransAgent.fromJson(Map<String, dynamic> json) => TransAgent(
        categoryCode: json["category_code"],
        categoryName: json["category_name"],
        categoryIconPath: json["category_icon_path"],
      );

  Map<String, dynamic> toJson() => {
        "category_code": categoryCode,
        "category_name": categoryName,
        "category_icon_path": categoryIconPath,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class MoreMenu {
  String? menuCode;
  String? menuName;
  String? menuDesc;
  String? menuIconPath;
  List<String>? categories;
  List<MoreMenu>? subMenuList;

  MoreMenu({this.menuCode, this.menuName, this.menuDesc, this.menuIconPath, this.subMenuList, this.categories});

  factory MoreMenu.fromJson(Map<String, dynamic> json) => MoreMenu(
        menuCode: json["menu_code"],
        menuName: json["menu_name"],
        menuDesc: json["menu_desc"],
        menuIconPath: json["menu_icon_path"],
    categories: json["categories"] == null
      ? []
      : List<String>.from(json["categories"]!.map((x) => x)),
      subMenuList: json["sub_menu"] == null
          ? []
          : List<MoreMenu>.from(
          json["sub_menu"]!.map((x) => MoreMenu.fromJson(x))),
  );

  Map<String, dynamic> toJson() =>
      {
        "menu_code": menuCode,
        "menu_name": menuName,
        "menu_desc": menuDesc,
        "menu_icon_path": menuIconPath,
        "categories": categories,
        "sub_menu": subMenuList,

      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class ServicesMenu {
  String? title;
  List<MoreMenu>? servicesMenu;

  ServicesMenu({this.title, this.servicesMenu});

  factory ServicesMenu.fromJson(Map<String, dynamic> json) => ServicesMenu(
        title: json["title"],
        servicesMenu: json["menu"] == null
            ? []
            : List<MoreMenu>.from(
                json["menu"]!.map((x) => MoreMenu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "menu": servicesMenu,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class Banks {
  String? currency_code;
  List<String>? banks_list;

  Banks({this.currency_code, this.banks_list});

  factory Banks.fromJson(Map<String, dynamic> json) => Banks(
        currency_code: json["currency_code"],
        banks_list: json["banks_list"] == null
            ? []
            : List<String>.from(json["banks_list"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "currency_code": currency_code,
        "banks_list": banks_list,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class UPIs {
  String? currency_code;
  List<String>? upis_list;

  UPIs({this.currency_code, this.upis_list});

  factory UPIs.fromJson(Map<String, dynamic> json) => UPIs(
        currency_code: json["currency_code"],
        upis_list: json["upis_list"] == null
            ? []
            : List<String>.from(json["upis_list"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "currency_code": currency_code,
        "upis_list": upis_list,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}