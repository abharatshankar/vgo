import 'package:flutter/cupertino.dart';
import 'package:vgo_flutter_app/src/model/request/create_buyer_seller_order_request.dart';
import 'package:vgo_flutter_app/src/model/request/mobile_number_request.dart';
import 'package:vgo_flutter_app/src/model/response/banner_list_response.dart';
import 'package:vgo_flutter_app/src/model/response/coin_list_response.dart';
import 'package:vgo_flutter_app/src/model/response/coin_response.dart';
import 'package:vgo_flutter_app/src/model/response/company_list_response.dart';
import 'package:vgo_flutter_app/src/model/response/company_response.dart';
import 'package:vgo_flutter_app/src/model/response/iio_categories_response.dart';
import 'package:vgo_flutter_app/src/model/response/status_code_response.dart';
import 'package:vgo_flutter_app/src/model/response/user_register_response.dart';

import '../model/response/about_coin_response.dart';
import '../model/response/treasury_list_response.dart';
import '../network/api/api_request_manager.dart';

class HomeViewModel {
  static final HomeViewModel instance = HomeViewModel();

  void doLoginValidate(MobileNumberRequest request, BuildContext context,
      {required Function(String? message, bool) completion}) {
    if (request.mobileNumber?.isEmpty ?? false ) {
      completion("Please enter mobile number!", false);
    } else if (request.mobileNumber!.length < 10) {
      completion("Please enter valid mobile number!", false);
    } else {
      completion('', true);
    }
  }

  void apiCoinDetails({required Function(CoinResponse? response) completion}) {
    ApiRequestManager.instance.coinDetails(completion: (response) {
      completion(response);
    });
  }

  void apiAboutCoinList(
      {required Function(AboutCoinResponse? response) completion}) {
    ApiRequestManager.instance.aboutCoinList(completion: (response) {
      completion(response);
    });
  }

  void apiAllCoinTreasuryList(
      {required Function(CoinListResponse? response) completion}) {
    ApiRequestManager.instance.allCoinTreasuryList(completion: (response) {
      completion(response);
    });
  }

  void apiIIOCategories(
      {required Function(IIOCategoriesResponse? response) completion}) {
    ApiRequestManager.instance.iioCategoriesList(completion: (response) {
      completion(response);
    });
  }

  void apiStartUps(
      {required Function(CompanyListResponse? response) completion}) {
    ApiRequestManager.instance.startUpsList(completion: (response) {
      completion(response);
    });
  }

  void callUserExistsOrNot(MobileNumberRequest request,
      {required Function(UserRegisterResponse? response) completion}) {
    ApiRequestManager.instance.checkUserExistsOrNot(request,
        completion: (response) {
      completion(response);
    });
  }

  void callGetTreasuryAllInvestmentsList(
      {required Function(TreasuryListResponse? response) completion}) {
    ApiRequestManager.instance.getTreasuryAllInvestmentsList(
        completion: (response) {
          completion(response);
        });
  }

  void callGetStartUpServicesList(int companyCode,
      {required Function(CompanyListResponse? response) completion}) {
    ApiRequestManager.instance.getStartUpServices(companyCode,
        completion: (response) {
          completion(response);
        });
  }

  void callGetStartUpProgressLogs(int companyCode,
      {required Function(CompanyListResponse? response) completion}) {
    ApiRequestManager.instance.getStartUpProgressLogs(companyCode,
        completion: (response) {
          completion(response);
        });
  }

  void callGetAllBanners(
      {required Function(BannerListResponse? response) completion}) {
    ApiRequestManager.instance.getAllBanners(
        completion: (response) {
          completion(response);
        });
  }

  void getLowStockPrice(String symbol,
      {required Function(CompanyResponse? response) completion}) {
    ApiRequestManager.instance.lowStockPrice(symbol,
        completion: (response) {
          completion(response);
        });
  }

  void getHighStockPrice(String symbol,
      {required Function(CompanyResponse? response) completion}) {
    ApiRequestManager.instance.highStockPrice(symbol,
        completion: (response) {
          completion(response);
        });
  }

  void getStockTransfersVolume(String symbol,
      {required Function(CompanyResponse? response) completion}) {
    ApiRequestManager.instance.stockTransfersVolume(symbol,
        completion: (response) {
          completion(response);
        });
  }

  void getSellerOrders(String companyName,
      {required Function(CompanyListResponse? response) completion}) {
    ApiRequestManager.instance.getSellerOrders(companyName,
        completion: (response) {
          completion(response);
        });
  }

  void getBuyerOrders(String companyName,
      {required Function(CompanyListResponse? response) completion}) {
    ApiRequestManager.instance.getBuyerOrders(companyName,
        completion: (response) {
          completion(response);
        });
  }

  void callCreateBuyerOrder(CreateBuyerSellerOrderRequest request,
      {required Function(StatusCodeResponse? response) completion}) {
    ApiRequestManager.instance.createBuyerOrder(request,
        completion: (response) {
          completion(response);
        });
  }

  void callCreateSellerOrder(CreateBuyerSellerOrderRequest request,
      {required Function(StatusCodeResponse? response) completion}) {
    ApiRequestManager.instance.createSellerOrder(request,
        completion: (response) {
          completion(response);
        });
  }
}
