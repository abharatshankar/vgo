import 'package:vgo_flutter_app/src/model/response/transfer_list_response.dart';
import 'package:vgo_flutter_app/src/model/response/wallet_list_response.dart';
import 'package:vgo_flutter_app/src/network/api/api_request_manager.dart';

import '../model/response/coin_list_response.dart';

class WalletViewModel {
  static final WalletViewModel instance = WalletViewModel();

  void callWallet(String userName,
      {required Function(WalletListResponse? response) completion}) {
    ApiRequestManager.instance.getWalletList(userName, completion: (response) {
      completion(response);
    });
  }

  void callGetTransferMenu(
      {required Function(TransferListResponse? response) completion}) {
    ApiRequestManager.instance.getTransferMenu(completion: (response) {
      completion(response);
    });
  }

  void callGetAllCoinTrans(String userName,
      {required Function(CoinListResponse? response) completion}) {
    ApiRequestManager.instance.getAllCoinsTrans(userName,
        completion: (response) {
      completion(response);
    });
  }
}