class APIConstant {
  static final String SLASH = '/';

  static final String PAYMENT_TYPE_UPI = "UPI";
  static final String PAYMENT_TYPE_BANK = "BANK";
  static final String PAYMENT_TYPE_BANK_SMALL = "Bank";
  static final String PAYMENT_TRANSFER_TO_BANK = "transfer2_bank";
  static final String PAYMENT_TRANSFER_TO_UPI = "transfer2_upi";

  static String apiSettings = "profile/public/api/profiles/get-settings-file";
  static String apiRegister = "profile/public/api/users/register";
  static String apiLogin = "profile/public/api/users/user-login";
  static String apiOTPValidation = "profile/public/api/users/otp-validation";
  static String getUserSearchHistory = "profile/public/api/usersearch";
  static String apiCheckUserExists =
      "profile/public/api/users/check-user-exists";
  static String apiCountryList =
      "profile/public/api/countrycodes/get-all-country-codes";

  // Home
  static String apiGetCoinValue = "wallet/public/api/treasury/get-coin-value";
  static String apiAllCoinTreasury =
      "wallet/public/api/coin-treasury/get-all-coin-treasury";
  static String apiAboutCoin = "profile/public/api/vgocoin/about-coin";

  static String apiLowStockPrice(String symbol) {
    return "iio/public/api/trade/stockprice/" + symbol + "/get-low-stock-price";
  }

  static String apiHighStockPrice(String symbol) {
    return "iio/public/api/trade/stockprice/" +
        symbol +
        "/get-high-stock-price";
  }

  static String apiStockTransfersVolume(String symbol) {
    return "iio/public/api/trade/stocktransfer/" +
        symbol +
        "/get-stock-transfers-volume";
  }

  static String apiGetStartUpProgressLogs(int companyCode) {
    return "startups/public/api/startups/progresslog/" +
        companyCode.toString() +
        "/get-startup-progress-logs";
  }

  static String apiGetStartUpServices(int companyCode) {
    return "startups/public/api/startup-services/" +
        companyCode.toString() +
        "/get-startup-services";
  }

  static String apiGetStartUps = "startups/public/api/startups/get-startups";
  static String apiGetIioCategories =
      "startups/public/api/investments/get-iio-categories";

  static String apiGetTreasuryAllInvestments =
      "wallet/public/api/treasury-funds-investments/get-treasury-all-investments";

  static String apiWallets(String userName) {
    return "wallet/public/api/wallets/" + userName;
  }

  static String apiGetAllCoinTrans(String userName) {
    return "wallet/public/api/cointrans/" + userName + "/get-all-coin-trans";
  }

  static String apiGetAllBanners =
      "profile/public/api/useractivities/banners/get-all-banners";

  // Services
  static String apiGetTransferMenu =
      "wallet/public/api/transfers/menu/get-transfer-menu";

  static String apiGetMobileTransaction =
      "wallet/public/api/transactions/mobile/get-mobile-transactions";

  static String apiCreateTransfer =
      "wallet/public/api/transfers/mobile/create-transfer";

  //profile
  static String apiGetUserTypes = "profile/public/api/users/get-user-types";

  static String apiCreateUserCategory =
      "profile/public/api/usercategory/create-user-category";

  //trans-agent
  // outbound
  static String apiGetNewOutboundTransferOrders =
      "wallet/public/api/cointrans/outbounds/get-new-outbound-transfer-orders";

  static String apiGetBankerOutboundTransferOrders =
      "wallet/public/api/cointrans/outbounds/get-banker-outbound-transfer-orders";

  //bank
  static String apiGetUserBanks(String userName, String category) {
    return "wallet/public/api/bankers/bank/" +
        userName +
        SLASH +
        category +
        "/get-user-banks";
  }

  static String apiGetUserUPIs(String userName) {
    return "wallet/public/api/bankers/upi/" + userName + "/get-user-upis";
  }

  // add bank
  static String apiCreateBank = "wallet/public/api/bankers/bank/create-bank";
  static String apiCreateUPI = "wallet/public/api/bankers/upi/create-upi";

  // Transfer
  static String apiGetMobileRecipientTransactions =
      "wallet/public/api/transactions/outbounds/recipient/get-mobile-recipient-transactions";

  static String apiCurrencies = "wallet/public/api/bankers/bank/get-currencies";

  static String apiAllUPIs(String currencyType) {
    return "wallet/public/api/bankers/upi/" + currencyType + "/get-upis";
  }

  static String apiAllBanks(String category, String currencyType) {
    return "wallet/public/api/bankers/bank/" +
        category +
        SLASH +
        currencyType +
        "/get-banks";
  }

  //vgo wallet
  static String apiGetSelectedBankAccountDetails(
      String currencyType, String bank, String amount) {
    return "wallet/public/api/bankers/bank/" +
        currencyType +
        "/" +
        bank +
        "/" +
        amount +
        "/get-selected-bank-account-details";
  }

  static String apiGetSelectedUpiAccountDetails(
      String currencyType, String bank, String amount) {
    return "wallet/public/api/bankers/upi/" +
        currencyType +
        "/" +
        bank +
        "/" +
        amount +
        "/get-selected-upi-account-details";
  }

  //inbound
  static String apiGetBankerInboundTransferOrders =
      "wallet/public/api/cointrans/inbounds/get-banker-inbound-transfer-orders";

  static String apiGetUserNewInboundTransferOrders(String userName) {
    return "wallet/public/api/cointrans/inbounds/" +
        userName +
        "/get-user-new-inbound-transfer-orders";
  }

  static String apiUpdateTransfer(
      String transaction_id, String receipt_image_path, String status) {
    return "wallet/public/api/transfers/vgowallet/update-transfer/" +
        transaction_id +
        '/' +
        receipt_image_path +
        '/' +
        status;
  }

  static String apiCreateTransferWallet() {
    return "wallet/public/api/transfers/vgowallet/create-transfer";
  }

  // file upload
  static String apiReceiptSnapUpload = "vgo/receiptSnapUpload.php";

  static String apiBankGetUserRecipients(String userName) {
    return "wallet/public/api/transfers/recipient/" +
        userName +
        "/Bank/get-user-recipients";
  }

  static String apiUpiGetUserRecipients(String userName) {
    return "wallet/public/api/transfers/recipient/" +
        userName +
        "/UPI/get-user-recipients";
  }

  static String apiGetUserOutboundTransferOrders =
      "wallet/public/api/cointrans/outbounds/get-user-outbound-transfer-orders";

  static String apiCreateRecipient =
      "wallet/public/api/transfers/recipient/create-recipient";

// transfer
  static String apiBankCreateTransfer =
      "wallet/public/api/transfers/bank/create-transfer";

  static String apiUpiCreateTransfer =
      "wallet/public/api/transfers/upi/create-transfer";

//timer
  static String apiGetTransferTimer =
      "wallet/public/api/transfer/timer/get-transfer-timer";

  static String apiTransferOrderReceipt(final String id, String tableName,
      final String bankerUserName, final String imagePath) {
    return "wallet/public/api/cointrans/outbounds/update-outbound-transfer-order-receipt/" +
        id +
        SLASH +
        tableName +
        SLASH +
        bankerUserName +
        SLASH +
        imagePath;
  }

  //
  //https://vgopay.in/wallet/public/api/cointrans/outbounds/update-outbound-transfer-order-receipt/{id}/{table_name}/{banker_username}/{receipt_image_path}

  static String apiTransferOrderStatus =
      "wallet/public/api/cointrans/outbounds/update-outbound-transfer-order-status";

  static String apiGetSellerOrders(String companyName) {
    return "iio/public/api/trade/sellerorder/" +
        companyName +
        "/get-seller-orders";
  }

  static String apiGetBuyerOrders(String companyName) {
    return "iio/public/api/trade/buyerorder/" +
        companyName +
        "/get-buyer-orders";
  }

  static String apiCreateBuyerOrder =
      "iio/public/api/trade/buyerorder/create-buyer-order";

  static String apiCreateSellerOrder =
      "iio/public/api/trade/sellerorder/create-seller-orderr";

  static String apiGetRecipientTransactions =
      "wallet/public/api/transactions/outbounds/recipient/get-recipient-transactions";

  static String apiGetCurrencyExchange(
      String from, String to, String transferAmount) {
    return "wallet/public/api/currencytables/exchange/" +
        from +
        "/" +
        to +
        "/" +
        transferAmount +
        "/get-currency-exchange";
  }

  static String apiConfirmTransferOrder(String transferId, String status) {
    return "wallet/public/api/transfers/vgowallet/confirm-transfer-order/" +
        transferId +
        "/" +
        status;
  }

  static String apiAcceptOutboundTransferOrder(
      String transferId, String userName) {
    return "wallet/public/api/cointrans/outbounds/" +
        transferId +
        "/" +
        userName +
        "/accept-outbound-transfer-order";
  }

//https://vgopay.in/wallet/public/api/cointrans/outbounds/confirm-outbound-transfer-order
  static String apiConfirmOutboundTransferOrderChat =
      "wallet/public/api/cointrans/outbounds/confirm-outbound-transfer-order";

  static String apiGetMyTeam(String gapId) {
    return "profile/public/api/team/" + gapId + "/get-my-team";
  }

  static String apiGetAllStores(String industry) {
    return "profile/public/api/stores/" + industry + "/get-stores";
  }

  static String apiGetUserStores(String gapId, String category) {
    return "profile/public/api/stores/" +
        gapId +
        "/" +
        category +
        "/get-user-stores";
  }

  static String apiCreateUserStore() {
    return "profile/public/api/stores/create-store";
  }

  static String apiUpdateUserStore(String storeId) {
    return "profile/public/api/stores/" + storeId + "/update-store";
  }

  static String apiCreateUserProduct() {
    return "profile/public/api/stores/products/create-product";
  }

  static String apiUpdateUserProduct(String productId) {
    return "profile/public/api/stores/products/" +
        productId +
        "/update-product";
  }

  static String apiGetProducts(String storeId) {
    return "profile/public/api/stores/products/" + storeId + "/get-products";
  }

  static String apiCreateOrder =
      "profile/public/api/stores/products/orders/create-order";

  static String apiCreateTeam = "profile/public/api/team/create-team";

  // Delivery orders
  static String apiGetUserDeliveryOrders(String userName) {
    return "profile/public/api/stores/products/orders/" +
        userName +
        "/get-delivery-orders";
  }

  static String apiGetUserOrders(String userName,String category,String subCat,) {
    return "profile/public/api/stores/products/orders/" +
        userName +"/"+category +"/"+subCat+
        "/get-user-orders";
  }

  static String apiGetDirectOrders(String category,String subCat,) {
    return "profile/public/api/stores/products/orders/" +
        category +"/"+subCat+
        "/get-new-orders";
  }
  static String apiRetailerAcceptOrder(String id,String username) {
    return "profile/public/api/stores/products/orders/" +
        id +"/"+username+
        "/retailer-accept-order";
  }


  static String apiUpdateUserOrders(String orderId) {
    return "profile/public/api/stores/products/orders/" +
        orderId +
        "/update-order";
  }

  static String apiGetUserStoreOrders(String userName,String cat,String subCat) {
    return "profile/public/api/stores/products/orders/" +
        userName +"/"+cat+"/"+subCat+
        "/get-store-orders";
  }

  static String apiCreateOrderDetailsChat =
      'profile/public/api/stores/products/orders/create-order-details';

  static String apiGetOrderDetailsChat(String orderId) {
    return "profile/public/api/stores/products/orders/" +
        orderId +
        "/get-order-details";
  }

  static String apiGetUserInboundTransferOrders =
      "wallet/public/api/cointrans/inbounds/get-user-inbound-transfer-orders";

  static String apiDeleteGateways(String gatewayId) {
    return "wallet/public/api/bankers/bank/" + gatewayId + "/delete-bank";
  }

  // Address
  static String apiCreateAddress =
      "profile/public/api/stores/delivery-address/create-address";

  static String apiGetDeliveryAddress(String username) {
    return "profile/public/api/stores/delivery-address/" +
        username +
        "/get-delivery-address";
  }

  static String apiDeleteDeliveryAddress(String username) {
    return "profile/public/api/stores/delivery-address/" +
        username +
        "/delete-delivery-address";
  }

  static String apiVerifyDispatchOrderFromStore(
      String username, String orderId, String otp) {
    return "profile/public/api/stores/products/orders/" +
        orderId +
        "/store/" +
        otp +
        "/verify-store-otp";
  }

  static String apiVerifyDispatchOrderFromCustomer(
      String username, String orderId, String otp) {
    return "profile/public/api/stores/products/orders/" +
        username +
        SLASH +
        orderId +
        "/customer/" +
        otp +
        "/verify-customer-otp";
  }

  // KYC-Experience
  static String apiCreateExperienceProfile =
      "profile/public/api/gaprofile/experience-profile/create-experience-profile";

  static String apiGetExperienceProfile(String gapId) {
    return "profile/public/api/gaprofile/experience-profile/" +
        gapId +
        "/get-experience-profiles";
  }

  // KYC-Education
  static String apiCreateEducationProfile =
      "profile/public/api/gaprofile/education-profile/create-education-profile";

  static String apiGetEducationProfile(String gapId) {
    return "profile/public/api/gaprofile/education-profile/" +
        gapId +
        "/get-education-profiles";
  }

  // KYC-profile
  static String apiGetReferProfiles(String gapId) {
    return "profile/public/api/gaprofile/profile-inquiry/" +
        gapId +
        "/get-refer-profiles";
  }

  static String apiGetAcceptProfiles(String gapId) {
    return "profile/public/api/gaprofile/profile-inquiry/" +
        gapId +
        "/get-accept-profiles";
  }

  static String apiUpdateProfileStatus(String status, String id) {
    return "profile/public/api/gaprofile/profile-inquiry/" +
        status +
        SLASH +
        id +
        "/update-profile-profiles";
  }

  // KYC-address
  static String apiGetAddressProfile(String gapId) {
    return "profile/public/api/gaprofile/address-profile/" +
        gapId +
        "/get-address-profiles";
  }

  static String apiCreateAddressProfile =
      "profile/public/api/gaprofile/address-profile/create-address-profile";

  // KYC-Inquiries
  static String apiGetMyProfileInquiries(final String gapId) {
    return "profile/public/api/gaprofile/" +
        gapId +
        "/get-my-profile-inquiries";
  }

/* @POST("profile/public/api/gaprofile/profile-inquiry/{gap_id}/get-refer-profiles")
  Flowable<PersonalProfileListResponse> getReferProfiles(@Path("gap_id") String gapId);

  @POST("profile/public/api/gaprofile/profile-inquiry/{gap_id}/get-accept-profiles")
  Flowable<PersonalProfileListResponse> getAcceptProfiles(@Path("gap_id") String gapId);

  @POST("profile/public/api/gaprofile/profile-inquiry/{status}/{id}/update-profile-status")
  Flowable<StatusResponse> updateProfileStatus(@Path("status") String status, @Path("id") String id);*/

  // Jobs - all jobs
  static String apiGetAllJobOrders(String username) {
    return "startups/public/api/startups/joborders/" +
        username +
        "/get-job-orders";
  }

  // Jobs - my jobs
  static String apiGetMyJobOrders(String username) {
    return "startups/public/api/startups/joborders/" +
        username +
        "/get-my-job-orders";
  }

  // Jobs - my posted jobs
  static String apiGetMyPostedJobOrders(String username) {
    return "startups/public/api/startups/joborders/" +
        username +
        "/get-posted-job-orders";
  }

  // Jobs - accept job
  static String apiAcceptJobOrders(String jobId) {
    return "startups/public/api/startups/joborders/" +
        jobId +
        "/update-job-order";
  }

  // Jobs - create job
  static String apiCreateJobOrder =
      "startups/public/api/startups/joborders/create-job-order";

  // Job logs create
  static String apiCreateJobOrderLog =
      "startups/public/api/startups/joborderlogs/create-job-order-log";

  // Job logs list
  static String apiGetJobOrderLogs(String jobId) {
    return "startups/public/api/startups/joborderlogs/" +
        jobId +
        "/get-job-order-logs";
  }

  // Bot chat
  static String apiBotGetChatResponse =
      "profile/public/api/chatbot/get-chat-response";

  // Search profile
  static String apiSearchProfile(String gapId) {
    return "profile/public/api/gaprofile/" +
        gapId +
        "/search-profile";
  }
}
