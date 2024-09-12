import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/model/country.dart';
import 'package:vgo_flutter_app/src/model/exchange_amount.dart';
import 'package:vgo_flutter_app/src/model/request/create_transfer_request.dart';
import 'package:vgo_flutter_app/src/model/request/transfers_request.dart';
import 'package:vgo_flutter_app/src/model/user.dart';
import 'package:vgo_flutter_app/src/utils/app_string_utils.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';
import 'package:vgo_flutter_app/src/view/activity/transagent/transaction_success_view.dart';
import 'package:vgo_flutter_app/src/view/services/transfer/transfer_blue_button_widget.dart';
import 'package:vgo_flutter_app/src/view/services/vgo_wallet_transfer/select_transfer_mode_widget.dart';

import '../../../constants/string_view_constants.dart';
import '../../../model/request/transfer/upi_transfer_request.dart';
import '../../../model/transfers.dart';
import '../../../model/transgent_category.dart';
import '../../../model/wallet.dart';
import '../../../session/session_manager.dart';
import '../../../utils/app_box_decoration.dart';
import '../../../utils/toast_utils.dart';
import '../../../view_model/services_view_model.dart';
import '../../../view_model/wallet_view_model.dart';
import '../../common/common_profile_name.dart';
import '../../common/common_tool_bar_transfer.dart';
import '../../profile/user_category/user_types.dart';
import '../add_new_recipient/add_new_recipient_view.dart';
import '../transfer/recent_transaction_list.dart';
import '../transfer/widget_recipient_drop_down.dart';

class BankUPITransferView extends StatefulWidget {
  BankUPITransferView({super.key});

  @override
  State<StatefulWidget> createState() => BankUPITransferState();
  final amountCoinNumberController = TextEditingController();
  final receiveAmountNumberController = TextEditingController();
  String transferType = 'Bank';
}

class BankUPITransferState extends State<BankUPITransferView> {
  List<TransferCategory> transferCategoryList = [];

  List<Transfers> transfersList = [];
  List<Wallet> walletList = [];
  List<Transfers>? bankTransfersList;
  List<Transfers>? upiTransfersList;

  bool showProgressCircle = false;
  bool showUserInfo = true;

  // User? user;
  String userName = '';
  String selectedType = '';
  User? user;
  Transfers? transfers;
  TransferCategory selectedTransferCategory = TransferCategory(
      categoryCode: 'BANK',
      categoryName: 'Bank',
      categoryIconPath: 'https://vgopay.in/icons/bank.png');

  // String selectedCurrency = 'INR';
  List<Country>? currencyList;

  String fromCurrency = '';
  String toCurrency = '';

  ExchangeAmount? exchangeAmount;
  bool isExchangeEnabled = false;
  String exchangeAmountText = '';
  String transactionFeeText = '';

  @override
  void initState() {
    super.initState();
    SessionManager.getUserName().then((value) {
      userName = value!;
      loggerNoStack.e('userName : ' + userName);
      callSettingsConfigApi();
      callWallet();
      callCurrenciesApi();
      callBankGetUserRecipients(userName);
      callUpiGetUserRecipients(userName);
      callGetUserOutboundTransferOrders();
    });
  }

  void callSettingsConfigApi() {
    ServicesViewModel.instance.callSettingsConfig(completion: (response) {
      setState(() {
        transferCategoryList = response!.transferCategoriesList!;
        selectedTransferCategory = transferCategoryList[0];
        loggerNoStack.e(
            'selectedTransferCategory ' + selectedTransferCategory.toString());
      });
    });
  }

  void callBankGetUserRecipients(String userName) {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callBankGetUserRecipients(userName,
        completion: (response) {
      setState(() {
        showProgressCircle = false;
      });
          if (response!.success ?? true) {
            setState(() {
              bankTransfersList = response.transferList;
              if (widget.transferType == 'Bank') {
            selectedType = bankTransfersList!.isNotEmpty ? bankTransfersList![0].recipientId! : '';
            transfers = bankTransfersList!.isNotEmpty ? bankTransfersList![0] : Transfers();
            user = User(
                firstName: transfers?.recipientId,
                mobileNumber: transfers?.mobileNumber);
            showUserInfo = true;
          }

          loggerNoStack.e('selectedType Bank $selectedType');
            });
          } else {
            loggerNoStack.e(StringViewConstants.noBanksRecipient);
          }
        });
  }

  void callUpiGetUserRecipients(String userName) {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callUpiGetUserRecipients(userName,
        completion: (response) {
          setState(() {
            showProgressCircle = false;
          });
          setState(() {
            if (response!.success ?? true) {
              setState(() {
                upiTransfersList = response.transferList;
                if (widget.transferType == 'UPI') {
              selectedType = upiTransfersList![0].recipientId!;
              transfers = upiTransfersList![0];
              user = User(
                  firstName: transfers?.recipientId,
                  mobileNumber: transfers?.mobileNumber);
              showUserInfo = true;
            }
            loggerNoStack.e('selectedType UPI $selectedType');
              });
            } else {
              loggerNoStack.e(StringViewConstants.noUpiRecipient);
            }
          });
        });
  }

  void callWallet() {
    setState(() {
      showProgressCircle = true;
    });

    WalletViewModel.instance.callWallet(userName!, completion: (response) {
      setState(() {
        showProgressCircle = false;
      });
      walletList = response!.walletList!;
    });
  }

  void callBankCreateTransfer() {
    setState(() {
      showProgressCircle = true;
    });

    final CreateTransferRequest request = CreateTransferRequest(
        userName: userName,
        accountNumber: '',
        bankName: '',
        bankerUserName: '',
        exchangeAmount: exchangeAmount!.exchangeRate ?? '0',
        recipientImagePath: '',
        receiveAmount: widget.receiveAmountNumberController.text,
        recipientId: selectedType,
        transactionFees: exchangeAmount!.transactionFees ?? '0',
        transferAccountType: '',
        transferAmount: widget.amountCoinNumberController.text,
        transferCurrency: toCurrency,
        transferPurpose: '',
        transferType: 'INR');

    ServicesViewModel.instance.callBankCreateTransfer(request,
        completion: (response) {
          setState(() {
            showProgressCircle = false;

            if (response!.success!) {
              ToastUtils.instance.showToast(response.message!,
                  context: context,
                  isError: false,
                  bg: ColorViewConstants.colorGreen);
              new Future.delayed(const Duration(seconds: 2), () {
            loggerNoStack.e('bank pop up');
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TransactionSuccessView(
                          isMobileTransfer: false,
                          isAdminTransfer: false,
                          transfers: response.transfers,
                          status: '',
                          navigationFrom: 'BANK',
                        )),
              ).then((val) => val
                  ? callGetUserOutboundTransferOrders()
                  : callGetUserOutboundTransferOrders());
            });
          });
        } else {
          ToastUtils.instance.showToast(response.message!,
              context: context,
              isError: false,
              bg: ColorViewConstants.colorRed);
        }
      });
        });
  }

  void callUpiCreateTransfer() {
    setState(() {
      showProgressCircle = true;
    });

    final UpiTransferRequest request = UpiTransferRequest(
      userName: userName,
      exchangeAmount: exchangeAmount!.exchangeRate ?? '0',
      receiveAmount: widget.receiveAmountNumberController.text,
      recipientId: selectedType,
      transactionFees: exchangeAmount!.transactionFees ?? '0',
      transferAmount: widget.amountCoinNumberController.text,
      transferPurpose: '',
      transferType: 'INR',
    );

    ServicesViewModel.instance.callUpiCreateTransfer(request,
        completion: (response) {
          setState(() {
            showProgressCircle = false;

            if (response!.success!) {
              ToastUtils.instance.showToast(response.message!,
                  context: context,
                  isError: false,
                  bg: ColorViewConstants.colorGreen);
              new Future.delayed(const Duration(seconds: 2), () {
                loggerNoStack.e('pop up');
                setState(() {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TransactionSuccessView(
                            isMobileTransfer: false,
                            isAdminTransfer: false,
                            transfers: response.transfers,
                            status: '',
                            navigationFrom: 'UPI',
                          ))).then((val) => val
                  ? callGetUserOutboundTransferOrders()
                  : callGetUserOutboundTransferOrders());
            });
              });
            } else {
              ToastUtils.instance.showToast(response.message!,
                  context: context,
                  isError: false,
                  bg: ColorViewConstants.colorRed);
            }
          });
        });
  }

  void callGetUserOutboundTransferOrders() {
    setState(() {
      showProgressCircle = true;
    });

    final TransfersRequest request = TransfersRequest(
        userName: userName,
        tableName: widget.transferType == 'UPI' ? 'UPI' : 'Bank');

    ServicesViewModel.instance.callGetUserOutboundTransferOrders(request,
        completion: (response) {
      setState(() {
        showProgressCircle = false;
        // transfersList = response!.transferList!;

        List<Transfers> transferListDup = response!.transferList!;
        transfersList.clear();
        for (Transfers transfer in transferListDup) {
          transfer.colorCode =
              ((math.Random().nextDouble() * 0xFFFFFF).toInt());
          /*if (userName == transfer.transferUserName) {
            transfersList.add(transfer);
          }*/
          transfersList.add(transfer);
        }
      });
        });
  }

  void callCurrenciesApi() {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callGetCurrenciesList(completion: (response) {
      setState(() {
        showProgressCircle = false;
      });

      setState(() {
        currencyList = response?.currencyList;
        fromCurrency = currencyList![0].currency!;
        toCurrency = currencyList![0].currency!;
        loggerNoStack.e('fromCurrency' + fromCurrency.toString());
      });
    });
  }

  void callGetCurrencyExchange(String from, String to, String transferAmount) {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callGetCurrencyExchange(from, to, transferAmount,
        completion: (response) {
          setState(() {
            showProgressCircle = false;
          });

          setState(() {
            if (response!.success ?? true) {
              setState(() {
                exchangeAmount = response.exchangeAmount;
                widget.receiveAmountNumberController.text =
                    exchangeAmount?.receiveAmount ?? '0';
                exchangeAmountText = exchangeAmount?.exchangeRate ?? '0';
                transactionFeeText = exchangeAmount?.transactionFees ?? '0';

                if (fromCurrency != toCurrency) {
                  isExchangeEnabled = true;
                } else {
                  isExchangeEnabled = false;
                }
              });
            } else {
              ToastUtils.instance
                  .showToast(response.message!, context: context, isError: true);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorViewConstants.colorWhite,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: ColorViewConstants.colorBlueSecondaryText,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            toolBarTransferWidget(
                context, StringViewConstants.transferToBankUPI, false),
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.02,
                      left: screenHeight * 0.02,
                      right: screenHeight * 0.02,
                      bottom: screenHeight * 0.00,
                    ),
                    child: MaterialButton(
                      height: screenHeight * 0.06,
                      color: ColorViewConstants.colorGreen,
                      minWidth: screenWidth,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddNewRecipientView()),
                        ).then((val) => val
                            ? callBankGetUserRecipients(userName)
                            : callUpiGetUserRecipients(userName));
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        StringViewConstants.addNewRecipient,
                        style: AppTextStyles.bold.copyWith(
                          fontSize: 16,
                          color: ColorViewConstants.colorWhite,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Visibility(
                      visible: false,
                      child: widgetSelectTransferMode(
                          context,
                          StringViewConstants.selectTransferMode,
                          widget.transferType == 'UPI',
                          completion: (isUpiSelected) {
                        setState(() {
                          /*      widget.isUpi = isUpiSelected;
                          if (widget.isUpi) {
                            selectedType = upiTransfersList![0].recipientId!;
                            transfers = upiTransfersList![0];
                          } else {
                            selectedType = bankTransfersList![0].recipientId!;
                            transfers = bankTransfersList![0];
                          }*/
                          user = User(
                              firstName: transfers?.recipientId,
                              mobileNumber: transfers?.mobileNumber);
                          callGetUserOutboundTransferOrders();
                        });
                      })),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.02,
                      left: screenHeight * 0.02,
                      right: screenHeight * 0.02,
                      bottom: screenHeight * 0.02,
                    ),
                    decoration: BoxDecoration(
                      color: ColorViewConstants.colorWhite,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                text: StringViewConstants.selectTransferMode,
                                style: AppTextStyles.medium.copyWith(
                                    color: ColorViewConstants.colorPrimaryText,
                                    fontSize: 16),
                              ),
                              TextSpan(
                                  text: ' *',
                                  style: AppTextStyles.medium.copyWith(
                                      color: ColorViewConstants.colorRed,
                                      fontSize: 16)),
                            ])),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton(
                            itemHeight: 50,
                            iconEnabledColor:
                                ColorViewConstants.colorBlueSecondaryText,
                            iconDisabledColor:
                                ColorViewConstants.colorBlueSecondaryText,
                            value: selectedTransferCategory.categoryName,
                            isExpanded: true,
                            items: transferCategoryList
                                .map((TransferCategory category) {
                              return DropdownMenuItem(
                                value: category.categoryName,
                                child: Container(
                                  color: ColorViewConstants.colorWhite,
                                  padding: EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Image.network(
                                        category.categoryIconPath ??
                                            AppStringUtils.noImageUrl,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.contain,
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.03,
                                      ),
                                      Text(
                                        category.categoryName ?? '',
                                        style: AppTextStyles.medium.copyWith(
                                            fontSize: 14,
                                            color: ColorViewConstants
                                                .colorPrimaryText),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                loggerNoStack.e('selectedTransferCategory value ' + value!);

                                for (TransferCategory category in transferCategoryList) {

                                  loggerNoStack.e('categoryName ' + category.categoryName!);
                                  if (category.categoryName == value) {
                                    selectedTransferCategory = category;
                                    selectedType = category.categoryName!;
                                    widget.transferType = category.categoryName!;
                                    if (selectedType == 'UPI') {
                                      selectedType = upiTransfersList!.isNotEmpty ? upiTransfersList![0].recipientId! : '';
                                      transfers = upiTransfersList!.isNotEmpty ? upiTransfersList![0] : Transfers();
                                      callUpiGetUserRecipients(userName);
                                    } else {
                                      selectedType = bankTransfersList!.isNotEmpty ? bankTransfersList![0].recipientId! : '';
                                      transfers = bankTransfersList!.isNotEmpty ? bankTransfersList![0] : Transfers();
                                      callBankGetUserRecipients(userName);
                                    }
                                    user = User(
                                        firstName: transfers?.recipientId,
                                        mobileNumber: transfers?.mobileNumber);
                                    callGetUserOutboundTransferOrders();
                                  }
                                }

                                loggerNoStack.e('selectedTransferCategory.categoryName ' + selectedTransferCategory.categoryName!);

                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 17.0),
                    child: Text(
                      StringViewConstants.transferMoney,
                      style: AppTextStyles.medium.copyWith(
                        fontSize: 16,
                        color: ColorViewConstants.colorBlack,
                      ),
                    ),
                  ),
                  Padding(
                        padding: EdgeInsets.only(left: 18),
                        child: widgetUserType(
                            context, StringViewConstants.selectRecipient),
                      ),
                      Visibility(
                          visible: transfers != null,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 18.0,
                              right: 15.0,
                            ),
                            child: widgetRecipientDropDown(
                              context,
                          widget.transferType == 'UPI',
                          transfers ?? Transfers(),
                          widget.transferType == 'UPI'
                              ? upiTransfersList
                              : bankTransfersList,
                          completion: (recipient) {
                            setState(() {
                              //loggerNoStack.e('recipient ' + recipient);
                              selectedType = recipient.recipientId!;
                              transfers = recipient;
                              user = User(
                                  firstName: transfers?.recipientId,
                                  mobileNumber: transfers?.mobileNumber);
                              showUserInfo = true;
                            });
                          },
                            ),
                          )),
                      Visibility(
                        visible: showUserInfo && transfers != null,
                        child: Container(
                            color: ColorViewConstants.colorWhite,
                            padding: EdgeInsets.only(left: 15),
                            child: profileName(context, user,
                                textColor: ColorViewConstants.colorWhite,
                                nameColor: ColorViewConstants.colorPrimaryText,
                                numberColor: ColorViewConstants.colorPrimaryText)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.01,
                          left: screenHeight * 0.02,
                          right: screenHeight * 0.02,
                          bottom: screenHeight * 0.01,
                        ),
                        child: Visibility(
                          visible: true,
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: StringViewConstants.transferType,
                                    style: AppTextStyles.regular.copyWith(
                                        color:
                                        ColorViewConstants.colorPrimaryTextHint,
                                        fontSize: 14)),
                                TextSpan(
                                    text: ' *',
                                    style: AppTextStyles.medium.copyWith(
                                        color: ColorViewConstants.colorRed,
                                        fontSize: 14)),
                              ])),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.0,
                      left: screenWidth * 0.02,
                      right: screenWidth * 0.02,
                      bottom: screenHeight * 0.01,
                    ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                                width: screenWidth * 0.3,
                                height: screenHeight * 0.065,
                                padding:
                                EdgeInsets.only(left: 20, right: 20, bottom: 5),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                      iconEnabledColor:
                                      ColorViewConstants.colorBlueSecondaryText,
                                      iconDisabledColor:
                                      ColorViewConstants.colorBlueSecondaryText,
                                      value: fromCurrency,
                                      isExpanded: true,
                                      style: AppTextStyles.medium
                                          .copyWith(fontSize: 16),
                                      items: currencyList?.map((Country items) {
                                        return DropdownMenuItem(
                                          value: items.currency,
                                          child: Text(
                                            items.currency ?? 'INR',
                                            style: AppTextStyles.medium,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          fromCurrency = value!;
                                          callGetCurrencyExchange(
                                              fromCurrency,
                                              toCurrency,
                                              widget
                                                  .amountCoinNumberController.text);
                                        });
                                      }),
                                )),
                            Container(
                              width: screenWidth * 0.55,
                              height: screenHeight * 0.06,
                              decoration: BoxDecoration(
                                color: ColorViewConstants.colorTransferGray,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 17.0, bottom: 5.0),
                                child: SizedBox(
                                  width: screenWidth,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(20),
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    controller: widget.amountCoinNumberController,
                                    decoration: InputDecoration(
                                      hintText: StringViewConstants.amountCoins,
                                      hintStyle: AppTextStyles.regular.copyWith(
                                        fontSize: 14,
                                        color:
                                        ColorViewConstants.colorPrimaryTextHint,
                                      ),
                                      enabledBorder: AppBoxDecoration.noInputBorder,
                                      focusedBorder: AppBoxDecoration.noInputBorder,
                                      border: AppBoxDecoration.noInputBorder,
                                    ),
                                    style: AppTextStyles.medium.copyWith(
                                        fontSize: 14,
                                        color: ColorViewConstants.colorPrimaryText),
                                    onChanged: (value) {
                                      loggerNoStack.e('amount $value');
                                      widget.amountCoinNumberController.text =
                                          value;
                                      callGetCurrencyExchange(
                                          fromCurrency,
                                          toCurrency,
                                          widget.amountCoinNumberController.text);
                                    },
                                    //  textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.01,
                          left: screenHeight * 0.02,
                          right: screenHeight * 0.02,
                          bottom: screenHeight * 0.01,
                        ),
                        child: Visibility(
                          visible: isExchangeEnabled,
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: StringViewConstants.receiveAmount,
                                    style: AppTextStyles.regular.copyWith(
                                        color:
                                        ColorViewConstants.colorPrimaryTextHint,
                                        fontSize: 14)),
                                TextSpan(
                                    text: ' *',
                                    style: AppTextStyles.medium.copyWith(
                                        color: ColorViewConstants.colorRed,
                                        fontSize: 14)),
                              ])),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.0,
                          left: screenHeight * 0.02,
                          right: screenHeight * 0.02,
                          bottom: screenHeight * 0.01,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Visibility(
                                visible: isExchangeEnabled,
                                child: Container(
                                    width: screenWidth * 0.3,
                                    height: screenHeight * 0.065,
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, bottom: 5),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                          iconEnabledColor: ColorViewConstants
                                              .colorBlueSecondaryText,
                                          iconDisabledColor: ColorViewConstants
                                              .colorBlueSecondaryText,
                                          value: toCurrency,
                                          isExpanded: false,
                                          style: AppTextStyles.medium
                                              .copyWith(fontSize: 16),
                                          items: currencyList?.map((Country items) {
                                            return DropdownMenuItem(
                                              value: items.currency,
                                              child: Text(
                                                items.currency ?? 'INR',
                                                style: AppTextStyles.medium,
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              toCurrency = value!;
                                              callGetCurrencyExchange(
                                                  fromCurrency,
                                                  toCurrency,
                                                  widget.amountCoinNumberController
                                                      .text);
                                            });
                                          }),
                                    ))),
                            Visibility(
                              visible: isExchangeEnabled,
                              child: Container(
                                width: screenWidth * 0.55,
                                height: screenHeight * 0.06,
                                decoration: BoxDecoration(
                                  color: ColorViewConstants.colorTransferGray,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 17.0, bottom: 5.0),
                                  child: SizedBox(
                                    width: screenWidth,
                                    child: TextField(
                                      readOnly: true,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(20),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      controller:
                                      widget.receiveAmountNumberController,
                                      decoration: InputDecoration(
                                        hintText: StringViewConstants.amountCoins,
                                        hintStyle: AppTextStyles.regular.copyWith(
                                          fontSize: 14,
                                          color: ColorViewConstants
                                              .colorPrimaryTextHint,
                                        ),
                                        enabledBorder:
                                        AppBoxDecoration.noInputBorder,
                                        focusedBorder:
                                        AppBoxDecoration.noInputBorder,
                                        border: AppBoxDecoration.noInputBorder,
                                      ),
                                      style: AppTextStyles.medium.copyWith(
                                          fontSize: 14,
                                          color:
                                          ColorViewConstants.colorPrimaryText),
                                      onChanged: (value) {
                                        // callGetCurrencyExchange(from, to, transferAmount)
                                      },
                                      //  textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Visibility(
                          visible: isExchangeEnabled,
                          child: Container(
                            padding: EdgeInsets.only(
                              left: screenHeight * 0.02,
                              right: screenHeight * 0.02,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: 'Note: exchange rate: ',
                                          style: AppTextStyles.regular.copyWith(
                                              color: ColorViewConstants
                                                  .colorPrimaryTextHint,
                                              fontSize: 13)),
                                      TextSpan(
                                          text: exchangeAmountText,
                                          style: AppTextStyles.medium.copyWith(
                                              color: ColorViewConstants.colorBlack,
                                              fontSize: 14)),
                                    ])),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: 'Transaction fee: ',
                                          style: AppTextStyles.regular.copyWith(
                                              color: ColorViewConstants
                                                  .colorPrimaryTextHint,
                                              fontSize: 13)),
                                      TextSpan(
                                          text: transactionFeeText,
                                          style: AppTextStyles.medium.copyWith(
                                              color: ColorViewConstants.colorBlack,
                                              fontSize: 14)),
                                    ])),
                                SizedBox(
                                  height: screenHeight * 0.02,
                                ),
                              ],
                            ),
                          )),

                      /*   BuildContext context, String title, Color color,
                  String amount, String validationMessage,{required Function(String amount) completion}*/

                      widgetTransferBlueButton(
                          context,
                          StringViewConstants.transfer,
                          ColorViewConstants.colorBlueSecondaryText,
                          widget.amountCoinNumberController.text,
                      StringViewConstants.pleaseEnterAmount,
                      completion: (value) {
                    FocusScope.of(context).unfocus();

                    if (widget.transferType == 'UPI') {
                      loggerNoStack.e('UPI  is selected');
                      callUpiCreateTransfer();
                    } else {
                      loggerNoStack.e('Bank  is selected');
                      callBankCreateTransfer();
                    }
                  }),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Visibility(
                      visible: false,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 17.0),
                        child: Text(
                          StringViewConstants.recentTransaction,
                          style: AppTextStyles.medium.copyWith(
                            fontSize: 18,
                            color: ColorViewConstants.colorBlack,
                          ),
                        ),
                      )),
                  Visibility(
                      visible: false,
                      child: recentTransactionList(
                        context,
                        transfersList,
                        widget.transferType == 'UPI' ? 'UPI' : 'Bank',
                      )),
                  SizedBox(
                    height: screenHeight * 0.01,
                  )
                ],
              ),
                ))
          ],
        ),
      ),
    );
  }
}
