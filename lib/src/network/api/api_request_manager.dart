import 'package:image_cropper/image_cropper.dart';
import 'package:vgo_flutter_app/src/model/request/bot/bot_chat_request.dart';
import 'package:vgo_flutter_app/src/model/request/create_address_request.dart';
import 'package:vgo_flutter_app/src/model/request/create_bank_request.dart';
import 'package:vgo_flutter_app/src/model/request/create_buyer_seller_order_request.dart';
import 'package:vgo_flutter_app/src/model/request/create_order_details_chat_request.dart';
import 'package:vgo_flutter_app/src/model/request/create_order_request.dart';
import 'package:vgo_flutter_app/src/model/request/create_product_request.dart';
import 'package:vgo_flutter_app/src/model/request/create_store_request.dart';
import 'package:vgo_flutter_app/src/model/request/create_transfer_request.dart';
import 'package:vgo_flutter_app/src/model/request/job_request.dart';
import 'package:vgo_flutter_app/src/model/request/kyc/education_request.dart';
import 'package:vgo_flutter_app/src/model/request/kyc/experience_request.dart';
import 'package:vgo_flutter_app/src/model/request/mobile_number_request.dart';
import 'package:vgo_flutter_app/src/model/request/otp_request.dart';
import 'package:vgo_flutter_app/src/model/request/registration_request.dart';
import 'package:vgo_flutter_app/src/model/request/status_code_request.dart';
import 'package:vgo_flutter_app/src/model/request/transfers_order_receipt_request.dart';
import 'package:vgo_flutter_app/src/model/request/transfers_request.dart';
import 'package:vgo_flutter_app/src/model/request/update_order_request.dart';
import 'package:vgo_flutter_app/src/model/request/update_transfer_request.dart';
import 'package:vgo_flutter_app/src/model/request/username_request.dart';
import 'package:vgo_flutter_app/src/model/response/banner_list_response.dart';
import 'package:vgo_flutter_app/src/model/response/coin_response.dart';
import 'package:vgo_flutter_app/src/model/response/common_response.dart';
import 'package:vgo_flutter_app/src/model/response/company_response.dart';
import 'package:vgo_flutter_app/src/model/response/country_list_response.dart';
import 'package:vgo_flutter_app/src/model/response/jobs/jobs_list_response.dart';
import 'package:vgo_flutter_app/src/model/response/jobs/jobs_response.dart';
import 'package:vgo_flutter_app/src/model/response/order_list_response.dart';
import 'package:vgo_flutter_app/src/model/response/status_code_response.dart';
import 'package:vgo_flutter_app/src/model/response/store_chat_list_response.dart';
import 'package:vgo_flutter_app/src/model/response/store_response.dart';
import 'package:vgo_flutter_app/src/model/response/team_response.dart';
import 'package:vgo_flutter_app/src/model/response/timer_list_response.dart';
import 'package:vgo_flutter_app/src/model/response/transfer/bank_upi_list_response.dart';
import 'package:vgo_flutter_app/src/model/response/transfer/exchange_response.dart';
import 'package:vgo_flutter_app/src/model/response/transfer/transfers_list_response.dart';
import 'package:vgo_flutter_app/src/model/response/transfer_list_response.dart';
import 'package:vgo_flutter_app/src/model/response/treasury_list_response.dart';
import 'package:vgo_flutter_app/src/model/response/user_login_response.dart';
import 'package:vgo_flutter_app/src/model/response/user_register_response.dart';
import 'package:vgo_flutter_app/src/model/response/user_type_response.dart';
import 'package:vgo_flutter_app/src/model/response/wallet_list_response.dart';
import 'package:vgo_flutter_app/src/network/api/services.dart';
import 'package:vgo_flutter_app/src/view/activity/kyc/profile/profile_response.dart';

import '../../model/request/create_recipient_request.dart';
import '../../model/request/create_team_request.dart';
import '../../model/request/transfer/transfer_recipient_request.dart';
import '../../model/request/transfer/upi_transfer_request.dart';
import '../../model/response/about_coin_response.dart';
import '../../model/response/address_list_response.dart';
import '../../model/response/address_response.dart';
import '../../model/response/coin_list_response.dart';
import '../../model/response/common_data_response.dart';
import '../../model/response/common_int_response.dart';
import '../../model/response/company_list_response.dart';
import '../../model/response/currency_list_response.dart';
import '../../model/response/iio_categories_response.dart';
import '../../model/response/kyc/kyc_list_response.dart';
import '../../model/response/kyc/kyc_response.dart';
import '../../model/response/product_list_response.dart';
import '../../model/response/settings_response.dart';
import '../../model/response/status_data_int_response.dart';
import '../../model/response/status_response.dart';
import '../../model/response/store_chat_response.dart';
import '../../model/response/store_list_response.dart';
import '../../model/response/transfer/bank_upi_account_response.dart';
import '../../model/response/transfer/transfers_response.dart';
import '../../utils/utils.dart';
import 'api_constants.dart';

class ApiRequestManager {
  static final ApiRequestManager instance = ApiRequestManager();

  void settingConfig(
      {required Function(SettingsResponse? response) completion}) {
    Services.instance.getRequest(APIConstant.apiSettings,
        completion: (response) {
      loggerNoStack.i(response?.data);
      SettingsResponse responseModel =
          SettingsResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void countryList(
      {required Function(CountryListResponse? response) completion}) {
    Services.instance.getRequest(APIConstant.apiCountryList,
        completion: (response) {
      loggerNoStack.i(response?.data);
      CountryListResponse responseModel =
          CountryListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void doUserLogin(MobileNumberRequest request,
      {required Function(UserLoginResponse? response) completion}) {
    loggerNoStack.i("request ${request.toJson()}");
    Services.instance.postRequest(APIConstant.apiLogin, request,
        completion: (response) {
      loggerNoStack.i(response?.data);
      UserLoginResponse responseModel =
          UserLoginResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void doUserOTPAuthenticate(OTPRequest request,
      {required Function(UserLoginResponse? response) completion}) {
    loggerNoStack.i("request ${request.toJson()}");
    Services.instance.postRequest(APIConstant.apiOTPValidation, request,
        completion: (response) {
      loggerNoStack.i(response?.data);
      UserLoginResponse responseModel =
          UserLoginResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void doRegister(RegistrationRequest request,
      {required Function(UserRegisterResponse? response) completion}) {
    loggerNoStack.i("request ${request.toJson()}");
    Services.instance.postRequest(APIConstant.apiRegister, request,
        completion: (response) {
      loggerNoStack.i(response?.data);
      UserRegisterResponse responseModel =
          UserRegisterResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void checkUserExistsOrNot(MobileNumberRequest request,
      {required Function(UserRegisterResponse? response) completion}) {
    loggerNoStack.i("request ${request.toJson()}");
    Services.instance.postRequest(APIConstant.apiCheckUserExists, request,
        completion: (response) {
      loggerNoStack.i(response?.data);
      UserRegisterResponse responseModel =
          UserRegisterResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void coinDetails({required Function(CoinResponse? response) completion}) {
    Services.instance.getRequest(APIConstant.apiGetCoinValue,
        completion: (response) {
      loggerNoStack.i(response?.data);
      CoinResponse responseModel = CoinResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void iioCategoriesList(
      {required Function(IIOCategoriesResponse? response) completion}) {
    Services.instance.getRequest(APIConstant.apiGetIioCategories,
        completion: (response) {
      loggerNoStack.i(response?.data);
      IIOCategoriesResponse responseModel =
          IIOCategoriesResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void startUpsList(
      {required Function(CompanyListResponse? response) completion}) {
    Services.instance.getRequest(APIConstant.apiGetStartUps,
        completion: (response) {
      loggerNoStack.i(response?.data);
      CompanyListResponse responseModel =
          CompanyListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void aboutCoinList(
      {required Function(AboutCoinResponse? response) completion}) {
    Services.instance.getRequest(APIConstant.apiAboutCoin,
        completion: (response) {
      loggerNoStack.i(response?.data);
      AboutCoinResponse responseModel =
          AboutCoinResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void allCoinTreasuryList(
      {required Function(CoinListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(APIConstant.apiAllCoinTreasury,
        completion: (response) {
      loggerNoStack.i(response?.data);
      CoinListResponse responseModel =
          CoinListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getTreasuryAllInvestmentsList(
      {required Function(TreasuryListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetTreasuryAllInvestments, completion: (response) {
      loggerNoStack.i(response?.data);
      TreasuryListResponse responseModel =
          TreasuryListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getStartUpServices(int companyCode,
      {required Function(CompanyListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetStartUpServices(companyCode), completion: (response) {
      loggerNoStack.i(response?.data);
      CompanyListResponse responseModel =
          CompanyListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getStartUpProgressLogs(int companyCode,
      {required Function(CompanyListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetStartUpProgressLogs(companyCode),
        completion: (response) {
      loggerNoStack.i(response?.data);
      CompanyListResponse responseModel =
          CompanyListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getWalletList(String userName,
      {required Function(WalletListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiWallets(userName), completion: (response) {
      loggerNoStack.i(response?.data);
      WalletListResponse responseModel =
          WalletListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getTransferMenu(
      {required Function(TransferListResponse? response) completion}) {
    Services.instance.getRequest(APIConstant.apiGetTransferMenu,
        completion: (response) {
      loggerNoStack.i(response?.data);
      TransferListResponse responseModel =
          TransferListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getAllCoinsTrans(String userName,
      {required Function(CoinListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetAllCoinTrans(userName), completion: (response) {
      loggerNoStack.i(response?.data);
      CoinListResponse responseModel =
          CoinListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getAllBanners(
      {required Function(BannerListResponse? response) completion}) {
    Services.instance.getRequest(APIConstant.apiGetAllBanners,
        completion: (response) {
      loggerNoStack.i(response?.data);
      BannerListResponse responseModel =
          BannerListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getMobileTransaction(TransfersRequest request,
      {required Function(TransfersListResponse? response) completion}) {
    loggerNoStack.i("request ${request.toJson()}");
    Services.instance.postRequest(APIConstant.apiGetMobileTransaction, request,
        completion: (response) {
      loggerNoStack.i(response?.data);
      TransfersListResponse responseModel =
          TransfersListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getCreateTransfer(CreateTransferRequest request,
      {required Function(TransfersResponse? response) completion}) {
    loggerNoStack.i("request ${request.toJson()}");
    Services.instance.postRequest(APIConstant.apiCreateTransfer, request,
        completion: (response) {
      loggerNoStack.i(response?.data);
      TransfersResponse responseModel =
          TransfersResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void createUserCategory(StatusCodeRequest request,
      {required Function(StatusCodeResponse? response) completion}) {
    loggerNoStack.i("request ${request.toJson()}");
    Services.instance.postRequest(APIConstant.apiCreateUserCategory, request,
        completion: (response) {
      loggerNoStack.i(response?.data);
      StatusCodeResponse responseModel =
          StatusCodeResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getUserType({required Function(UserTypeResponse? response) completion}) {
    Services.instance.getRequest(APIConstant.apiGetUserTypes,
        completion: (response) {
      loggerNoStack.i(response?.data);
      UserTypeResponse responseModel =
          UserTypeResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void lowStockPrice(String symbol,
      {required Function(CompanyResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiLowStockPrice(symbol), completion: (response) {
      loggerNoStack.i(response?.data);
      CompanyResponse responseModel = CompanyResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void highStockPrice(String symbol,
      {required Function(CompanyResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiHighStockPrice(symbol), completion: (response) {
      loggerNoStack.i(response?.data);
      CompanyResponse responseModel = CompanyResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void stockTransfersVolume(String symbol,
      {required Function(CompanyResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiStockTransfersVolume(symbol), completion: (response) {
      loggerNoStack.i(response?.data);
      CompanyResponse responseModel = CompanyResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getNewOutboundTransferOrders(TransfersRequest request,
      {required Function(CoinListResponse? response) completion}) {
    Services.instance
        .postRequest(APIConstant.apiGetNewOutboundTransferOrders, request,
            completion: (response) {
      loggerNoStack.i(response?.data);
      CoinListResponse responseModel =
          CoinListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getBankerOutboundTransferOrders(TransfersRequest request,
      {required Function(CoinListResponse? response) completion}) {
    Services.instance
        .postRequest(APIConstant.apiGetBankerOutboundTransferOrders, request,
            completion: (response) {
      loggerNoStack.i(response?.data);
      CoinListResponse responseModel =
          CoinListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getUserBanks(String userName, String category,
      {required Function(CoinListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetUserBanks(userName, category),
        completion: (response) {
      loggerNoStack.i(response?.data);
      CoinListResponse responseModel =
          CoinListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getUserUPIs(String userName,
      {required Function(CoinListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetUserUPIs(userName), completion: (response) {
      loggerNoStack.i(response?.data);
      CoinListResponse responseModel =
          CoinListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getCreateBank(CreateBankRequest request,
      {required Function(CommonDataResponse? response) completion}) {
    Services.instance.postRequest(APIConstant.apiCreateBank, request,
        completion: (response) {
      loggerNoStack.i(response?.data);
      CommonDataResponse responseModel =
          CommonDataResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getCreateUPI(CreateBankRequest request,
      {required Function(CommonDataResponse? response) completion}) {
    Services.instance.postRequest(APIConstant.apiCreateUPI, request,
        completion: (response) {
      loggerNoStack.i(response?.data);
      CommonDataResponse responseModel =
          CommonDataResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getMobileRecipientTransactions(TransferRecipientRequest request,
      {required Function(TransfersListResponse? response) completion}) {
    Services.instance
        .postRequest(APIConstant.apiGetMobileRecipientTransactions, request,
            completion: (response) {
      loggerNoStack.i(response?.data);
      TransfersListResponse responseModel =
          TransfersListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  // Get currencies list
  void currenciesList(
      {required Function(CurrencyListResponse? response) completion}) {
    Services.instance.getRequest(APIConstant.apiCurrencies,
        completion: (response) {
      loggerNoStack.i(response?.data);
      CurrencyListResponse responseModel =
          CurrencyListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  // Get banks list
  void banksList(String category, String currencyType,
      {required Function(BankUpiListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiAllBanks(category, currencyType),
        completion: (response) {
      loggerNoStack.i(response?.data);
      BankUpiListResponse responseModel =
          BankUpiListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void upiList(String currencyType,
      {required Function(BankUpiListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiAllUPIs(currencyType), completion: (response) {
      loggerNoStack.i(response?.data);
      BankUpiListResponse responseModel =
          BankUpiListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getSelectedUpiAccountDetails(
      String currencyType, String bank, String amount,
      {required Function(BankUpiAccountResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetSelectedUpiAccountDetails(currencyType, bank, amount),
        completion: (response) {
      loggerNoStack.i(response?.data);
      BankUpiAccountResponse responseModel =
          BankUpiAccountResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getSelectedBankAccountDetails(
      String currencyType, String bank, String amount,
      {required Function(BankUpiAccountResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetSelectedBankAccountDetails(
            currencyType, bank, amount), completion: (response) {
      loggerNoStack.i(response?.data);
      BankUpiAccountResponse responseModel =
          BankUpiAccountResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getBankerInboundTransferOrders(TransfersRequest request,
      {required Function(CoinListResponse? response) completion}) {
    Services.instance
        .postRequest(APIConstant.apiGetBankerInboundTransferOrders, request,
            completion: (response) {
      loggerNoStack.i(response?.data);
      CoinListResponse responseModel =
          CoinListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getUserNewInboundTransferOrders(String userName,
      {required Function(CoinListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetUserNewInboundTransferOrders(userName),
        completion: (response) {
      loggerNoStack.i(response?.data);
      CoinListResponse responseModel =
          CoinListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void updateTransfer(String transactionId, String receipt_image_path,
      String status, UpdateTransferRequest request,
      {required Function(TransfersResponse? response) completion}) {
    Services.instance.postRequest(
        APIConstant.apiUpdateTransfer(
            transactionId, receipt_image_path, status),
        request, completion: (response) {
      loggerNoStack.i(response?.data);
      TransfersResponse responseModel =
          TransfersResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void createTransferWallet(UpdateTransferRequest request,
      {required Function(CommonIntResponse? response) completion}) {
    Services.instance.postRequest(
        APIConstant.apiCreateTransferWallet(), request, completion: (response) {
      loggerNoStack.i(response?.data);
      CommonIntResponse responseModel =
          CommonIntResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void recipientImageUpload(CroppedFile imageData,
      {required Function(CommonResponse? response) completion}) {
    Services.instance.uploadImage(APIConstant.apiReceiptSnapUpload, imageData,
        completion: (response) {
      loggerNoStack.i(response?.data);
      CommonResponse responseModel = CommonResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void bankGetUserRecipients(String userName,
      {required Function(TransfersListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiBankGetUserRecipients(userName), completion: (response) {
      loggerNoStack.i(response?.data);
      TransfersListResponse responseModel =
          TransfersListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void upiGetUserRecipients(String userName,
      {required Function(TransfersListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiUpiGetUserRecipients(userName), completion: (response) {
      loggerNoStack.i(response?.data);
      TransfersListResponse responseModel =
          TransfersListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getUserOutboundTransferOrders(TransfersRequest request,
      {required Function(TransfersListResponse? response) completion}) {
    Services.instance
        .postRequest(APIConstant.apiGetUserOutboundTransferOrders, request,
            completion: (response) {
      loggerNoStack.i(response?.data);
      TransfersListResponse responseModel =
          TransfersListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void createRecipient(CreateRecipientRequest request,
      {required Function(StatusCodeResponse? response) completion}) {
    Services.instance.postRequest(APIConstant.apiCreateRecipient, request,
        completion: (response) {
      loggerNoStack.i(response?.data);
      StatusCodeResponse responseModel =
          StatusCodeResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void bankCreateTransfer(CreateTransferRequest request,
      {required Function(TransfersResponse? response) completion}) {
    Services.instance.postRequest(APIConstant.apiBankCreateTransfer, request,
        completion: (response) {
      loggerNoStack.i(response?.data);
      TransfersResponse responseModel =
          TransfersResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void upiCreateTransfer(UpiTransferRequest request,
      {required Function(TransfersResponse? response) completion}) {
    Services.instance.postRequest(APIConstant.apiUpiCreateTransfer, request,
        completion: (response) {
      loggerNoStack.i(response?.data);
      TransfersResponse responseModel =
          TransfersResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

//get

  void getTransferTimer(
      {required Function(TimerListResponse? response) completion}) {
    Services.instance.getRequest(APIConstant.apiGetTransferTimer,
        completion: (response) {
      loggerNoStack.i(response?.data);
      TimerListResponse responseModel =
          TimerListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void transferOrderReceipt(
      TransfersOrderReceiptRequest request,
      final String id,
      String tableName,
      final String bankerUserName,
      final String imagePath,
      {required Function(StatusDataIntResponse? response) completion}) {
    Services.instance.postRequest(
        APIConstant.apiTransferOrderReceipt(
            id, tableName, bankerUserName, imagePath),
        request, completion: (response) {
      loggerNoStack.i(response?.data);
      StatusDataIntResponse responseModel =
          StatusDataIntResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void transferOrderStatus(TransfersOrderReceiptRequest request,
      {required Function(StatusCodeResponse? response) completion}) {
    Services.instance.postRequest(APIConstant.apiTransferOrderStatus, request,
        completion: (response) {
      loggerNoStack.i(response?.data);
      StatusCodeResponse responseModel =
          StatusCodeResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getSellerOrders(String companyName,
      {required Function(CompanyListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetSellerOrders(companyName), completion: (response) {
      loggerNoStack.i(response?.data);
      CompanyListResponse responseModel =
          CompanyListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getBuyerOrders(String companyName,
      {required Function(CompanyListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetBuyerOrders(companyName), completion: (response) {
      loggerNoStack.i(response?.data);
      CompanyListResponse responseModel =
          CompanyListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void createBuyerOrder(CreateBuyerSellerOrderRequest request,
      {required Function(StatusCodeResponse? response) completion}) {
    Services.instance.postRequest(APIConstant.apiCreateBuyerOrder, request,
        completion: (response) {
      loggerNoStack.i(response?.data);
      StatusCodeResponse responseModel =
          StatusCodeResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void createSellerOrder(CreateBuyerSellerOrderRequest request,
      {required Function(StatusCodeResponse? response) completion}) {
    Services.instance.postRequest(APIConstant.apiCreateSellerOrder, request,
        completion: (response) {
      loggerNoStack.i(response?.data);
      StatusCodeResponse responseModel =
          StatusCodeResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getRecipientTransactions(TransferRecipientRequest request,
      {required Function(TransfersListResponse? response) completion}) {
    Services.instance
        .postRequest(APIConstant.apiGetRecipientTransactions, request,
            completion: (response) {
      loggerNoStack.i(response?.data);
      TransfersListResponse responseModel =
          TransfersListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void getCurrencyExchange(String from, String to, String transferAmount,
      {required Function(ExchangeResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetCurrencyExchange(from, to, transferAmount),
        completion: (response) {
      loggerNoStack.i(response?.data);
      ExchangeResponse responseModel =
          ExchangeResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void confirmTransferOrder(String transferId, String status,
      {required Function(CoinResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiConfirmTransferOrder(transferId, status),
        completion: (response) {
      loggerNoStack.i(response?.data);
      CoinResponse responseModel = CoinResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void acceptOutboundTransferOrder(String transferId, String userName,
      {required Function(StatusCodeResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiAcceptOutboundTransferOrder(transferId, userName),
        completion: (response) {
      loggerNoStack.i(response?.data);
      StatusCodeResponse responseModel =
          StatusCodeResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void confirmOutboundTransferOrderChat(TransfersOrderReceiptRequest request,
      {required Function(TransfersResponse? response) completion}) {
    loggerNoStack.i("request ${request.toJson()}");
    Services.instance
        .postRequest(APIConstant.apiConfirmOutboundTransferOrderChat, request,
            completion: (response) {
      loggerNoStack.i(response?.data);
      TransfersResponse responseModel =
          TransfersResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void apiGetMyTeam(String gapId,
      {required Function(TeamResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(APIConstant.apiGetMyTeam(gapId),
        completion: (response) {
      loggerNoStack.i(response?.data);
      TeamResponse responseModel = TeamResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void createUserStore(CreateStoreRequest request,
      {required Function(StoreResponse? response) completion}) {
    loggerNoStack.i("request ${request.toJson()}");
    Services.instance.postRequest(APIConstant.apiCreateUserStore(), request,
        completion: (response) {
      loggerNoStack.i(response?.data);
      StoreResponse responseModel = StoreResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void apiUpdateUserStores(String storeId, CreateStoreRequest request,
      {required Function(StoreResponse? response) completion}) {
    Services.instance
        .postRequest(APIConstant.apiUpdateUserStore(storeId), request,
            completion: (response) {
      loggerNoStack.i(response?.data);
      StoreResponse responseModel = StoreResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void createProductForStore(CreateProductRequest request,
      {required Function(StoreResponse? response) completion}) {
    loggerNoStack.i("request ${request.toJson()}");
    Services.instance.postRequest(APIConstant.apiCreateUserProduct(), request,
        completion: (response) {
      loggerNoStack.i(response?.data);
      StoreResponse responseModel = StoreResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void updateProductForStore(
      CreateProductRequest request, final String productId,
      {required Function(StoreResponse? response) completion}) {
    loggerNoStack.i("request ${request.toJson()}");
    Services.instance
        .postRequest(APIConstant.apiUpdateUserProduct(productId), request,
            completion: (response) {
      loggerNoStack.i(response?.data);
      StoreResponse responseModel = StoreResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void createOrder(CreateOrderRequest request,
      {required Function(StoreResponse? response) completion}) {
    loggerNoStack.i("request ${request.toJson()}");
    Services.instance.postRequest(APIConstant.apiCreateOrder, request,
        completion: (response) {
      loggerNoStack.i(response?.data);
      StoreResponse responseModel = StoreResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void updateOrder(UpdateOrderRequest request, String orderId,
      {required Function(StatusResponse? response) completion}) {
    loggerNoStack.i("request ${request.toJson()}");
    Services.instance
        .postRequest(APIConstant.apiUpdateUserOrders(orderId), request,
            completion: (response) {
      loggerNoStack.i(response?.data);
      StatusResponse responseModel = StatusResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void createTeam(CreateTeamRequest request,
      {required Function(StatusResponse? response) completion}) {
    loggerNoStack.i("request ${request.toJson()}");
    Services.instance.postRequest(APIConstant.apiCreateTeam, request,
        completion: (response) {
      loggerNoStack.i(response?.data);
      StatusResponse responseModel = StatusResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void createOrderDetailsChat(CreateOrderDetailsChatRequest request,
      {required Function(StoreChatResponse? response) completion}) {
    loggerNoStack.i("request ${request.toJson()}");
    Services.instance.postRequest(
        APIConstant.apiCreateOrderDetailsChat, request, completion: (response) {
      loggerNoStack.i(response?.data);
      StoreChatResponse responseModel =
          StoreChatResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void apiGetUserStores(String gapId, String category,
      {required Function(StoreResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetUserStores(gapId, category), completion: (response) {
      loggerNoStack.i(response?.data);
      StoreResponse responseModel = StoreResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void apiGetProducts(String storeId,
      {required Function(ProductListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetProducts(storeId), completion: (response) {
      loggerNoStack.i(response?.data);
      ProductListResponse responseModel =
          ProductListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void apiGetStoresByCategory(String category,
      {required Function(StoreListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetAllStores(category), completion: (response) {
      loggerNoStack.i(response?.data);
      StoreListResponse responseModel =
          StoreListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  // Delivery orders
  void apiGetUserDeliveryOrders(String userName,
      {required Function(OrderListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetUserDeliveryOrders(userName), completion: (response) {
      loggerNoStack.i(response?.data);
      OrderListResponse responseModel =
          OrderListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void apiGetUserOrders(String userName,
      {required Function(OrderListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetUserOrders(userName), completion: (response) {
      loggerNoStack.i(response?.data);
      OrderListResponse responseModel =
          OrderListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void apiGetUserStoreOrders(String userName,
      {required Function(OrderListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetUserStoreOrders(userName), completion: (response) {
      loggerNoStack.i(response?.data);
      OrderListResponse responseModel =
          OrderListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void apiGetOrderDetailsChat(String userName,
      {required Function(StoreChatListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetOrderDetailsChat(userName), completion: (response) {
      loggerNoStack.i(response?.data);
      StoreChatListResponse responseModel =
          StoreChatListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void apiGetUserInboundTransferOrders(UsernameRequest request,
      {required Function(TransfersListResponse? response) completion}) {
    loggerNoStack.i("request ${request.toJson()}");
    Services.instance
        .postRequest(APIConstant.apiGetUserInboundTransferOrders, request,
            completion: (response) {
      loggerNoStack.i(response?.data);
      TransfersListResponse responseModel =
          TransfersListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void deletePaymentGateway(String gatewayId,
      {required Function(StatusCodeResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiDeleteGateways(gatewayId), completion: (response) {
      loggerNoStack.i(response?.data);
      StatusCodeResponse responseModel =
          StatusCodeResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  // Generate invoice
  void apiUpdateOrder(UpdateOrderRequest request, String orderId,
      {required Function(TransfersListResponse? response) completion}) {
    loggerNoStack.i("request ${request.toJson()}");
    Services.instance
        .postRequest(APIConstant.apiUpdateUserOrders(orderId), request,
            completion: (response) {
      loggerNoStack.i(response?.data);
      TransfersListResponse responseModel =
          TransfersListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  // Address
  void apiCreateAddress(CreateAddressRequest request,
      {required Function(AddressResponse? response) completion}) {
    loggerNoStack.i("request ${request.toJson()}");
    Services.instance.postRequest(APIConstant.apiCreateAddress, request,
        completion: (response) {
      loggerNoStack.i(response?.data);
      AddressResponse responseModel = AddressResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void apiGetDeliveryAddress(String username,
      {required Function(AddressListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetDeliveryAddress(username), completion: (response) {
      loggerNoStack.i(response?.data);
      AddressListResponse responseModel =
          AddressListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void apiDeleteDeliveryAddress(String id,
      {required Function(StatusCodeResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiDeleteDeliveryAddress(id), completion: (response) {
      loggerNoStack.i(response?.data);
      StatusCodeResponse responseModel =
          StatusCodeResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void apiVerifyDispatchOrderFromStore(
      String username, String orderId, String otp,
      {required Function(StatusCodeResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiVerifyDispatchOrderFromStore(username, orderId, otp),
        completion: (response) {
      loggerNoStack.i(response?.data);
      StatusCodeResponse responseModel =
          StatusCodeResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void apiVerifyDispatchOrderFromCustomer(
      String username, String orderId, String otp,
      {required Function(StatusCodeResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiVerifyDispatchOrderFromCustomer(username, orderId, otp),
        completion: (response) {
      loggerNoStack.i(response?.data);
      StatusCodeResponse responseModel =
          StatusCodeResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  // KYC - Experience
  void apiGetExperienceList(String gapId,
      {required Function(KycListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetExperienceProfile(gapId), completion: (response) {
      loggerNoStack.i(response?.data);
      KycListResponse responseModel = KycListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void apiCreateExperience(ExperienceRequest request,
      {required Function(KycResponse? response) completion}) {
    Services.instance
        .postRequest(APIConstant.apiCreateExperienceProfile, request,
            completion: (response) {
      loggerNoStack.i(response?.data);
      KycResponse responseModel = KycResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  // KYC - Education
  void apiGetEducationList(String gapId,
      {required Function(KycListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetEducationProfile(gapId), completion: (response) {
      loggerNoStack.i(response?.data);
      KycListResponse responseModel = KycListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void apiCreateEducation(EducationRequest request,
      {required Function(KycResponse? response) completion}) {
    Services.instance.postRequest(
        APIConstant.apiCreateEducationProfile, request, completion: (response) {
      loggerNoStack.i(response?.data);
      KycResponse responseModel = KycResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  // KYC - Profile
  void apiGetMyProfileInquiries(String gapId,
      {required Function(ProfileResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetMyProfileInquiries(gapId), completion: (response) {
      loggerNoStack.i(response?.data);
      ProfileResponse responseModel = ProfileResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void apiGetAcceptProfiles(String gapId,
      {required Function(KycListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetAcceptProfiles(gapId), completion: (response) {
      loggerNoStack.i(response?.data);
      KycListResponse responseModel = KycListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  void apiUpdateProfileStatus(String gapId, String id,
      {required Function(KycListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiUpdateProfileStatus(gapId, id), completion: (response) {
      loggerNoStack.i(response?.data);
      KycListResponse responseModel = KycListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  // KYC - Address List
  void apiGetAddressList(String gapId,
      {required Function(AddressListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetAddressProfile(gapId), completion: (response) {
      loggerNoStack.i(response?.data);
      AddressListResponse responseModel =
          AddressListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  // KYC - Add Address
  void apiAddAddressProfile(CreateAddressRequest request,
      {required Function(AddressResponse? response) completion}) {
    Services.instance.postRequest(APIConstant.apiCreateAddressProfile, request,
        completion: (response) {
      loggerNoStack.i(response?.data);
      AddressResponse responseModel = AddressResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  // Jobs - all jobs
  void apiGetAllJobOrders(String username,
      {required Function(JobsListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetAllJobOrders(username), completion: (response) {
      loggerNoStack.i(response?.data);
      JobsListResponse responseModel =
          JobsListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  // Jobs - my jobs
  void apiGetMyJobOrders(String username,
      {required Function(JobsListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetMyJobOrders(username), completion: (response) {
      loggerNoStack.i(response?.data);
      JobsListResponse responseModel =
          JobsListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  // Jobs - my posted jobs
  void apiGetMyPostedJobOrders(String username,
      {required Function(JobsListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetMyPostedJobOrders(username), completion: (response) {
      loggerNoStack.i(response?.data);
      JobsListResponse responseModel =
          JobsListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  // Jobs - accept jobs
  void apiAcceptJobOrders(String jobId, JobRequest request,
      {required Function(JobsResponse? response) completion}) {
    Services.instance.postRequest(
        APIConstant.apiAcceptJobOrders(jobId), request, completion: (response) {
      loggerNoStack.i(response?.data);
      JobsResponse responseModel = JobsResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  // Job create
  void apiCreateJobOrder(JobRequest request,
      {required Function(JobsResponse? response) completion}) {
    Services.instance.postRequest(APIConstant.apiCreateJobOrder, request,
        completion: (response) {
      loggerNoStack.i(response?.data);
      JobsResponse responseModel = JobsResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  // Job logs create
  void apiCreateJobOrderLog(String jobId, JobRequest request,
      {required Function(JobsResponse? response) completion}) {
    Services.instance.postRequest(APIConstant.apiCreateJobOrderLog, request,
        completion: (response) {
      loggerNoStack.i(response?.data);
      JobsResponse responseModel = JobsResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  // Job logs list
  void apiGetJobOrderLogs(String username,
      {required Function(JobsListResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiGetJobOrderLogs(username), completion: (response) {
      loggerNoStack.i(response?.data);
      JobsListResponse responseModel =
          JobsListResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }

  // Bot chat
  void apiBotGetChatResponse(BotChatRequest request,
      {required Function(JobsResponse? response) completion}) {
    Services.instance.postRequest(APIConstant.apiBotGetChatResponse, request,
        completion: (response) {
          loggerNoStack.i(response?.data);
          JobsResponse responseModel = JobsResponse.fromJson(response?.data);
          completion(responseModel);
        });
  }

  // Search profile
  void apiSearchProfile(String gapId,
      {required Function(ProfileResponse? response) completion}) {
    Services.instance.postRequestWithoutRequest(
        APIConstant.apiSearchProfile(gapId), completion: (response) {
      loggerNoStack.i(response?.data);
      ProfileResponse responseModel =
      ProfileResponse.fromJson(response?.data);
      completion(responseModel);
    });
  }
}
