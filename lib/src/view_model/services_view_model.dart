import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:vgo_flutter_app/src/model/request/create_order_request.dart';
import 'package:vgo_flutter_app/src/model/request/create_product_request.dart';
import 'package:vgo_flutter_app/src/model/request/create_store_request.dart';
import 'package:vgo_flutter_app/src/model/request/create_team_request.dart';
import 'package:vgo_flutter_app/src/model/request/create_transfer_request.dart';
import 'package:vgo_flutter_app/src/model/request/transfers_request.dart';
import 'package:vgo_flutter_app/src/model/request/update_order_request.dart';
import 'package:vgo_flutter_app/src/model/request/update_transfer_request.dart';
import 'package:vgo_flutter_app/src/model/response/common_response.dart';
import 'package:vgo_flutter_app/src/model/response/currency_list_response.dart';
import 'package:vgo_flutter_app/src/model/response/order_list_response.dart';
import 'package:vgo_flutter_app/src/model/response/settings_response.dart';
import 'package:vgo_flutter_app/src/model/response/status_code_response.dart';
import 'package:vgo_flutter_app/src/model/response/store_response.dart';
import 'package:vgo_flutter_app/src/model/response/team_response.dart';
import 'package:vgo_flutter_app/src/model/response/transfer/bank_upi_account_response.dart';
import 'package:vgo_flutter_app/src/model/response/transfer/bank_upi_list_response.dart';
import 'package:vgo_flutter_app/src/model/response/transfer/transfers_list_response.dart';

import '../model/request/create_order_details_chat_request.dart';
import '../model/request/create_recipient_request.dart';
import '../model/request/transfer/transfer_recipient_request.dart';
import '../model/request/transfer/upi_transfer_request.dart';
import '../model/request/transfers_order_receipt_request.dart';
import '../model/request/username_request.dart';
import '../model/response/coin_response.dart';
import '../model/response/common_int_response.dart';
import '../model/response/product_list_response.dart';
import '../model/response/status_response.dart';
import '../model/response/store_chat_list_response.dart';
import '../model/response/store_chat_response.dart';
import '../model/response/store_list_response.dart';
import '../model/response/transfer/exchange_response.dart';
import '../model/response/transfer/transfers_response.dart';
import '../model/response/transfer_list_response.dart';
import '../network/api/api_request_manager.dart';
import '../view/services/user_history_response.dart';

class ServicesViewModel {
  static final ServicesViewModel instance = ServicesViewModel();

  void callSettingsConfig(
      {required Function(SettingsResponse? response) completion}) {
    ApiRequestManager.instance.settingConfig(completion: (response) {
      completion(response);
    });
  }

  void callGetTransferMenu({required Function(TransferListResponse? response) completion}) {
    ApiRequestManager.instance.getTransferMenu(completion: (response) {
      completion(response);
    });
  }

  void callGetMobileTransaction(TransfersRequest request,
      {required Function(TransfersListResponse? response) completion}) {
    ApiRequestManager.instance.getMobileTransaction(request,
        completion: (response) {
          completion(response);
        });
  }

  void callCreateTransfer(CreateTransferRequest request,
      {required Function(TransfersResponse? response) completion}) {
    ApiRequestManager.instance.getCreateTransfer(request,
        completion: (response) {
          completion(response);
        });
  }

  void callGetMobileRecipientTransactions(TransferRecipientRequest request,
      {required Function(TransfersListResponse? response) completion}) {
    ApiRequestManager.instance.getMobileRecipientTransactions(request,
        completion: (response) {
      completion(response);
    });
  }

  void callGetCurrenciesList(
      {required Function(CurrencyListResponse? response) completion}) {
    ApiRequestManager.instance.currenciesList(completion: (response) {
      completion(response);
    });
  }

  void callGetBanksList(String category, String currencyType,
      {required Function(BankUpiListResponse? response) completion}) {
    ApiRequestManager.instance.banksList(category, currencyType, completion: (response) {
      completion(response);
    });
  }

  void callGetUpiList(String currencyType,
      {required Function(BankUpiListResponse? response) completion}) {
    ApiRequestManager.instance.upiList(currencyType, completion: (response) {
      completion(response);
    });
  }

  void callGetSelectedBankAccountDetails(
      String currencyType, String bank, String amount,
      {required Function(BankUpiAccountResponse? response) completion}) {
    ApiRequestManager.instance.getSelectedBankAccountDetails(
        currencyType, bank, amount, completion: (response) {
      completion(response);
    });
  }

  void callGetSelectedUpiAccountDetails(
      String currencyType, String bank, String amount,
      {required Function(BankUpiAccountResponse? response) completion}) {
    ApiRequestManager.instance.getSelectedUpiAccountDetails(
        currencyType, bank, amount, completion: (response) {
      completion(response);
    });
  }

  void callCreateTransferWallet(UpdateTransferRequest request,
      {required Function(CommonIntResponse? response) completion}) {
    ApiRequestManager.instance.createTransferWallet(request,
        completion: (response) {
      completion(response);
    });
  }

  void callUpdateTransfer(String transactionId, String receipt_image_path,
      String status, UpdateTransferRequest request,
      {required Function(TransfersResponse? response) completion}) {
    ApiRequestManager.instance
        .updateTransfer(transactionId, receipt_image_path, status, request,
            completion: (response) {
      completion(response);
    });
  }

  void recipientImageUpload(CroppedFile imageData,
      {required Function(CommonResponse? response) completion}) {
    ApiRequestManager.instance.recipientImageUpload(imageData,
        completion: (response) {
      completion(response);
    });
  }

  void callBankGetUserRecipients(String userName,
      {required Function(TransfersListResponse? response) completion}) {
    ApiRequestManager.instance.bankGetUserRecipients(userName,
        completion: (response) {
      completion(response);
    });
  }

  void callUpiGetUserRecipients(String userName,
      {required Function(TransfersListResponse? response) completion}) {
    ApiRequestManager.instance.upiGetUserRecipients(userName,
        completion: (response) {
      completion(response);
    });
  }

  void callGetUserOutboundTransferOrders(TransfersRequest request,
      {required Function(TransfersListResponse? response) completion}) {
    ApiRequestManager.instance.getUserOutboundTransferOrders(request,
        completion: (response) {
      completion(response);
    });
  }

  void callCreateRecipient(CreateRecipientRequest request,
      {required Function(StatusCodeResponse? response) completion}) {
    ApiRequestManager.instance.createRecipient(request,
        completion: (response) {
          completion(response);
        });
  }

  void callBankCreateTransfer(CreateTransferRequest request,
      {required Function(TransfersResponse? response) completion}) {
    ApiRequestManager.instance.bankCreateTransfer(request,
        completion: (response) {
          completion(response);
        });
  }

  void callUpiCreateTransfer(UpiTransferRequest request,
      {required Function(TransfersResponse? response) completion}) {
    ApiRequestManager.instance.upiCreateTransfer(request,
        completion: (response) {
      completion(response);
    });
  }

  void callGetRecipientTransactions(TransferRecipientRequest request,
      {required Function(TransfersListResponse? response) completion}) {
    ApiRequestManager.instance.getRecipientTransactions(request,
        completion: (response) {
      completion(response);
    });
  }

  void callGetCurrencyExchange(String from, String to, String transferAmount,
      {required Function(ExchangeResponse? response) completion}) {
    ApiRequestManager.instance.getCurrencyExchange(from, to, transferAmount,
        completion: (response) {
      completion(response);
    });
  }

  void callConfirmTransferOrder(String transferId,String status,
      {required Function(CoinResponse? response) completion}) {
    ApiRequestManager.instance.confirmTransferOrder(transferId,status,
        completion: (response) {
          completion(response);
        });
  }

  void callAcceptOutboundTransferOrder(String transferId, String status,
      {required Function(StatusCodeResponse? response) completion}) {
    ApiRequestManager.instance.acceptOutboundTransferOrder(transferId, status,
        completion: (response) {
      completion(response);
    });
  }

  void callConfirmOutboundTransferOrderChat(
      TransfersOrderReceiptRequest request,
      {required Function(TransfersResponse? response) completion}) {
    ApiRequestManager.instance.confirmOutboundTransferOrderChat(request,
        completion: (response) {
      completion(response);
    });
  }

  void callGetMyTeam(String gapId,
      {required Function(TeamResponse? response) completion}) {
    ApiRequestManager.instance.apiGetMyTeam(gapId, completion: (response) {
      completion(response);
    });
  }

  void validateCreateStore(CreateStoreRequest request, BuildContext context,
      {required Function(String? message, bool) completion}) {
    if (request.store_name?.isEmpty ?? false) {
      completion("Please enter store name!", false);
    } else if (request.store_type?.isEmpty ?? false) {
      completion("Please enter store type!", false);
    } else if (request.industry?.isEmpty ?? false) {
      completion("Please enter industry!", false);
    }
    /* else if (request.category?.isEmpty ?? false) {
      completion("Please enter category!", false);
    }*/
    else if (request.supply_items?.isEmpty ?? false) {
      completion("Please enter supply items!", false);
    } else if (request.location?.isEmpty ?? false) {
      completion("Please enter store location!", false);
    } else {
      completion('', true);
    }
  }

  void validateCreateProduct(CreateProductRequest request, BuildContext context,
      {required Function(String? message, bool) completion}) {
    if (request.product_name?.isEmpty ?? false) {
      completion("Please enter product name!", false);
    } else if (request.product_desc?.isEmpty ?? false) {
      completion("Please enter product description!", false);
    } else if (request.price?.isEmpty ?? false) {
      completion("Please enter product price!", false);
    } else {
      completion('', true);
    }
  }

  void validateAddTeam(CreateTeamRequest request, BuildContext context,
      {required Function(String? message, bool) completion}) {
    if (request.input_gap_id?.isEmpty ?? false) {
      completion("Please enter Gap ID!", false);
    }else {
      completion('', true);
    }
  }

  void calCreateUserStore(CreateStoreRequest request,
      {required Function(StoreResponse? response) completion}) {
    ApiRequestManager.instance.createUserStore(request, completion: (response) {
      completion(response);
    });
  }

  void calUpdateUserStore(String storeId,CreateStoreRequest request,
      {required Function(StoreResponse? response) completion}) {
    ApiRequestManager.instance.apiUpdateUserStores(storeId,request, completion: (response) {
      completion(response);
    });
  }

  void calCreateProductForStore(CreateProductRequest request,
      {required Function(StoreResponse? response) completion}) {
    ApiRequestManager.instance.createProductForStore(request,
        completion: (response) {
      completion(response);
    });
  }

  void calUpdateProductForStore(
      CreateProductRequest request, final String productId,
      {required Function(StoreResponse? response) completion}) {
    ApiRequestManager.instance.updateProductForStore(request, productId,
        completion: (response) {
      completion(response);
    });
  }

  void callCreateOrder(CreateOrderRequest request,
      {required Function(StoreResponse? response) completion}) {
    ApiRequestManager.instance.createOrder(request, completion: (response) {
      completion(response);
    });
  }

  void callCreateTeam(CreateTeamRequest request,
      {required Function(StatusResponse? response) completion}) {
    ApiRequestManager.instance.createTeam(request, completion: (response) {
      completion(response);
    });
  }

  void callUpdateOrder(UpdateOrderRequest request, String orderId,
      {required Function(StatusResponse? response) completion}) {
    ApiRequestManager.instance.updateOrder(request, orderId,
        completion: (response) {
      completion(response);
    });
  }

  void callGetUserStores(String gapId, String category,
      {required Function(StoreResponse? response) completion}) {
    ApiRequestManager.instance.apiGetUserStores(gapId, category,
        completion: (response) {
      completion(response);
    });
  }

  void callGetProductsByStore(String storeId,
      {required Function(ProductListResponse? response) completion}) {
    ApiRequestManager.instance.apiGetProducts(storeId, completion: (response) {
      completion(response);
    });
  }

  void callGetStoresByCategory(String category,
      {required Function(StoreListResponse? response) completion}) {
    ApiRequestManager.instance.apiGetStoresByCategory(category,
        completion: (response) {
      completion(response);
    });
  }

  // Delivery orders
  void callGetUserDeliveryOrders(String userName,
      {required Function(OrderListResponse? response) completion}) {
    ApiRequestManager.instance.apiGetUserDeliveryOrders(userName,
        completion: (response) {
      completion(response);
    });
  }

  void callGetUserOrders(String userName,
      {required Function(OrderListResponse? response) completion}) {
    ApiRequestManager.instance.apiGetUserOrders(userName,
        completion: (response) {
      completion(response);
    });
  }

  void callGetUserStoreOrders(String userName,
      {required Function(OrderListResponse? response) completion}) {
    ApiRequestManager.instance.apiGetUserStoreOrders(userName,
        completion: (response) {
      completion(response);
    });
  }

  void callGetOrderDetailsChat(String userName,
      {required Function(StoreChatListResponse? response) completion}) {
    ApiRequestManager.instance.apiGetOrderDetailsChat(userName,
        completion: (response) {
      completion(response);
    });
  }

  void callCreateOrderDetailsChat(CreateOrderDetailsChatRequest request,
      {required Function(StoreChatResponse? response) completion}) {
    ApiRequestManager.instance.createOrderDetailsChat(request,
        completion: (response) {
      completion(response);
    });
  }

  void callGetUserInboundTransferOrders(UsernameRequest request,
      {required Function(TransfersListResponse? response) completion}) {
    ApiRequestManager.instance.apiGetUserInboundTransferOrders(request,
        completion: (response) {
      completion(response);
    });
  }

  void deletePaymentGateway(String gatewayId,
      {required Function(StatusCodeResponse? response) completion}) {
    ApiRequestManager.instance.deletePaymentGateway(gatewayId,
        completion: (response) {
      completion(response);
    });
  }

  void verifyDispatchOrderFromCustomer(
      String username, String orderId, String otp,
      {required Function(StatusCodeResponse? response) completion}) {
    ApiRequestManager.instance.apiVerifyDispatchOrderFromCustomer(
        username, orderId, otp, completion: (response) {
      completion(response);
    });
  }

  void UserHistoryResponseList(
      String userId,
      {required Function(UserHistoryResponse? response) completion}) {
    ApiRequestManager.instance.apiUserHistoryResponse(
        userId, completion: (response) {
      completion(response);
    });
  }

  void verifyDispatchOrderFromStore(String username, String orderId, String otp,
      {required Function(StatusCodeResponse? response) completion}) {
    ApiRequestManager.instance.apiVerifyDispatchOrderFromStore(
        username, orderId, otp, completion: (response) {
      completion(response);
    });
  }
}
