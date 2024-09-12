import 'package:vgo_flutter_app/src/model/request/create_bank_request.dart';
import 'package:vgo_flutter_app/src/model/request/transfers_request.dart';
import 'package:vgo_flutter_app/src/model/response/coin_list_response.dart';
import 'package:vgo_flutter_app/src/model/response/common_data_response.dart';

import '../model/request/transfers_order_receipt_request.dart';
import '../model/response/status_code_response.dart';
import '../model/response/status_data_int_response.dart';
import '../model/response/timer_list_response.dart';
import '../network/api/api_request_manager.dart';

class ActivityViewModel {
  static final ActivityViewModel instance = ActivityViewModel();

  void apiGetNewOutboundTransfersOrders(TransfersRequest request,
      {required Function(CoinListResponse? response) completion}) {
    ApiRequestManager.instance.getNewOutboundTransferOrders(request,
        completion: (response) {
      completion(response);
    });
  }

  void callGetBankerOutboundTransferOrders(TransfersRequest request,
      {required Function(CoinListResponse? response) completion}) {
    ApiRequestManager.instance.getBankerOutboundTransferOrders(request,
        completion: (response) {
          completion(response);
        });
  }


  void callGetUserBank(String userName,String category,
      {required Function(CoinListResponse? response) completion}) {
    ApiRequestManager.instance.getUserBanks(userName,category, completion: (response) {
      completion(response);
    });
  }

  void callGetUserUPIs(String userName,
      {required Function(CoinListResponse? response) completion}) {
    ApiRequestManager.instance.getUserUPIs(userName, completion: (response) {
      completion(response);
    });
  }


  void callGetCreateBank(CreateBankRequest request,
      {required Function(CommonDataResponse? response) completion}) {
    ApiRequestManager.instance.getCreateBank(request,
        completion: (response) {
          completion(response);
        });
  }

  void callCreateUPI(CreateBankRequest request,
      {required Function(CommonDataResponse? response) completion}) {
    ApiRequestManager.instance.getCreateUPI(request,
        completion: (response) {
          completion(response);
        });
  }

  void callGetBankerInboundTransferOrders(TransfersRequest request,
      {required Function(CoinListResponse? response) completion}) {
    ApiRequestManager.instance.getBankerInboundTransferOrders(request,
        completion: (response) {
          completion(response);
        });
  }

  void callGetUserNewInboundTransferOrders(String userName,
      {required Function(CoinListResponse? response) completion}) {
    ApiRequestManager.instance.getUserNewInboundTransferOrders(userName,
        completion: (response) {
          completion(response);
        });
  }

  void callTransferOrderReceipt(TransfersOrderReceiptRequest request,final String id, String tableName, final String bankerUserName, final String imagePath,
      {required Function(StatusDataIntResponse? response) completion}) {
    ApiRequestManager.instance.transferOrderReceipt(request, id, tableName, bankerUserName, imagePath,
        completion: (response) {
          completion(response);
        });
  }


  void callGetTransferTimer({required Function(TimerListResponse? response) completion}) {
    ApiRequestManager.instance.getTransferTimer(
        completion: (response) {
          completion(response);
        });
  }

  void callTransferOrderStatus(TransfersOrderReceiptRequest request,
      {required Function(StatusCodeResponse? response) completion}) {
    ApiRequestManager.instance.transferOrderStatus(request,
        completion: (response) {
          completion(response);
        });
  }


}
