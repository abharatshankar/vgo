import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/model/request/create_bank_request.dart';
import 'package:vgo_flutter_app/src/utils/app_string_utils.dart';
import 'package:vgo_flutter_app/src/utils/toast_utils.dart';
import 'package:vgo_flutter_app/src/view/common/common_tool_bar_transfer.dart';
import 'package:vgo_flutter_app/src/view/services/transfer/transfer_blue_button_widget.dart';
import 'package:vgo_flutter_app/src/view/services/vgo_wallet_transfer/select_transfer_mode_widget.dart';
import 'package:vgo_flutter_app/src/view_model/activity_view_model.dart';
import 'package:vgo_flutter_app/src/view_model/profile_view_model.dart';

import '../../../../constants/string_view_constants.dart';
import '../../../../model/bank_upi.dart';
import '../../../../model/country.dart';
import '../../../../model/response/settings_response.dart';
import '../../../../model/transfers.dart';
import '../../../../model/transgent_category.dart';
import '../../../../session/session_manager.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/utils.dart';
import '../../../../view_model/services_view_model.dart';
import '../../../services/vgo_wallet_transfer/bank_account_number_widget.dart';
import '../../../services/vgo_wallet_transfer/currency_bank_type_widget.dart';
import '../../../services/vgo_wallet_transfer/widget_text_controller.dart';

class AddBankUpiView extends StatefulWidget {
  AddBankUpiView({super.key, required this.title});

  String title;
  final accountHolderController = TextEditingController();

  @override
  State<AddBankUpiView> createState() => AddBankUpiViewState();
}

class AddBankUpiViewState extends State<AddBankUpiView> {
  String userTypeValue = '';
  List<String> userTypesList = [];
  String accountNumber = '';
  String holderName = '';
  BankUPI? bankDetails;
  BankUPI? upiDetails;

  final numberController = TextEditingController();
  final holderController = TextEditingController();
  final upiIDController = TextEditingController();

  List<Country>? currencyList = [];
  String selectedCurrency = 'INR';
  String upiId = '';

  bool showProgressCircle = false;
  String selectedGateway = "";
  List<BankUPI> bankList = [];
  String userName = '';
  String countryCode = '';
  String currencyCode = '';

  List<TransferCategory> transferCategoryList = [];
  Transfers? transfers;
  TransferCategory selectedTransferCategory = TransferCategory(
      categoryCode: 'BANK',
      categoryName: 'Bank',
      categoryIconPath: 'https://vgopay.in/icons/bank.png');

  String selectedType = '';
  String transferType = 'Bank';

  SettingsResponse? settingsResponse;

  @override
  void initState() {
    super.initState();
    SessionManager.getUserName().then((value) {
      userName = value!;
      loggerNoStack.e('userName :${userName}');
    });

    SessionManager.getCountryCode().then((value) {
      countryCode = value!;
      loggerNoStack.e('countryCode :${countryCode}');
    });

    SessionManager.getCurrency().then((value) {
      currencyCode = value!;
      // callAllBanksApi('Bank', currencyCode);
      // callAllUPIsApi(value);
      loggerNoStack.e('currencyCode :${currencyCode}');
    });

    // callCurrencyListApi();
    callSettingsConfigApi();
  }

/*  void callAllBanksApi(String category, String currencyType) {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callGetBanksList(category, currencyType,
        completion: (response) {
      setState(() {
        showProgressCircle = false;
      });

      if (response!.success ?? true) {
        setState(() {
          bankList = response.bankUpiList;

          loggerNoStack.e('bankList : ' + bankList!.length.toString());
          selectedGateway = bankList![0].bankName! ?? '';
        });
      } else {
        loggerNoStack.e('No banks');
      }
    });
  }*/

  void callGetUserTypesMenu() {
    setState(() {
      showProgressCircle = true;
    });

    ProfileViewModel.instance.callGetUserTypes(completion: (response) {
      setState(() {
        showProgressCircle = false;
      });
    });
  }

  void callCreateBank() {
    setState(() {
      showProgressCircle = true;
    });
    final CreateBankRequest request = CreateBankRequest(
        userName: userName,
        accountHolderName: holderController.text,
        accountNumber: selectedType == 'UPI'
            ? upiIDController.text
            : numberController.text,
        bankName: selectedGateway,
        bankIconPath: '',
        country: countryCode,
        currency: selectedCurrency,
        category: transferType);

/*    if (selectedType == 'UPI') {
      ActivityViewModel.instance.callCreateUPI(request, completion: (response) {
        setState(() {
          showProgressCircle = false;
          showSuccessAlert(response!.message!, CoolAlertType.success,
              ColorViewConstants.colorBlueSecondaryText);
        });
      });
    } else {
      ActivityViewModel.instance.callGetCreateBank(request,
          completion: (response) {
        setState(() {
          showProgressCircle = false;
          showSuccessAlert(response!.message!, CoolAlertType.success,
              ColorViewConstants.colorBlueSecondaryText);
        });
      });
    }*/

    ActivityViewModel.instance.callGetCreateBank(request,
        completion: (response) {
      setState(() {
        showProgressCircle = false;
        showSuccessAlert(response!.message!, CoolAlertType.success,
            ColorViewConstants.colorBlueSecondaryText);
      });
    });
  }

/*  void callCurrencyListApi() {
    ServicesViewModel.instance.callGetCurrenciesList(completion: (response) {
      setState(() {
        currencyList = response!.currencyList!;
        AppStringUtils.defaultCurrency = currencyList![0].currency!;
      });
    });
  }*/

  void callSettingsConfigApi() {
    ServicesViewModel.instance.callSettingsConfig(completion: (response) {
      setState(() {
        transferCategoryList = response!.transferCategoriesList!;
        selectedTransferCategory = transferCategoryList[0];
        loggerNoStack.e('currencyCode ' + currencyCode);

        settingsResponse = response;
        getBankGatewaysList();
        loggerNoStack.e('bankList ' + bankList!.length.toString());
        // bankList =  settingsResponse!.banks;
      });
    });
  }

  void getBankGatewaysList() {
    bankList.clear();
    currencyList?.clear();
    for (Banks bank in settingsResponse!.banks!) {
      Country country = Country(currency: bank.currency_code);
      currencyList!.add(country);
      selectedCurrency = settingsResponse!.banks![0].currency_code!;
      if (selectedCurrency.toLowerCase() == bank.currency_code!.toLowerCase()) {
        loggerNoStack.e('currency_code ' + bank.currency_code!);

        for (String name in bank.banks_list!) {
          BankUPI bankName = BankUPI(bankName: name);
          bankList.add(bankName);
          selectedGateway = bankList[0].bankName!;
        }
      }
    }
  }

  void getUPIGatewaysList() {
    bankList.clear();
    currencyList?.clear();
    for (UPIs upi in settingsResponse!.upis!) {
      Country country = Country(currency: upi.currency_code);
      currencyList!.add(country);
      selectedCurrency = settingsResponse!.upis![0].currency_code!;
      if (selectedCurrency.toLowerCase() ==
          upi.currency_code!.toLowerCase()) {
        loggerNoStack.e('currency_code ' + upi.currency_code!);

        for (String name in upi.upis_list!) {
          BankUPI bankName = BankUPI(bankName: name);
          bankList.add(bankName);
          selectedGateway = bankList[0].bankName!;
        }
      }
    }
  }

  void filterGatewayList(final String currency, final String transferType) {
    bankList.clear();
    if (transferType == 'Bank') {
      for (Banks bank in settingsResponse!.banks!) {
        if (currency.toLowerCase() == bank.currency_code!.toLowerCase()) {
          loggerNoStack.e('currency_code ' + bank.currency_code!);

          for (String name in bank.banks_list!) {
            BankUPI bankName = BankUPI(bankName: name);
            bankList.add(bankName);
            selectedGateway = bankList[0].bankName!;
          }
        }
      }
    } else if (transferType == 'UPI') {
      for (UPIs upi in settingsResponse!.upis!) {
        if (currency.toLowerCase() == upi.currency_code!.toLowerCase()) {
          loggerNoStack.e('currency_code ' + upi.currency_code!);

          for (String name in upi.upis_list!) {
            BankUPI bankName = BankUPI(bankName: name);
            bankList.add(bankName);
            selectedGateway = bankList[0].bankName!;
          }
        }
      }
    }
  }

  void showSuccessAlert(
      final String message, CoolAlertType alertType, Color confirmBtnColor) {
    CoolAlert.show(
      context: context,
      type: alertType,
      text: message,
      confirmBtnText: StringViewConstants.okay,
      confirmBtnColor: confirmBtnColor,
      onConfirmBtnTap: () {
        Navigator.pop(context, true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorViewConstants.colorWhite,
      appBar: AppBar(
        backgroundColor: ColorViewConstants.colorBlueSecondaryText,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: ColorViewConstants.colorWhite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              toolBarTransferWidget(context, widget.title, false),
              Visibility(
                  visible: false,
                  child: widgetSelectTransferMode(
                      context, " Select Transfer mode", selectedType == 'UPI',
                      completion: (isUpiSelected) {
                    setState(() {
                      // isUpi = isUpiSelected;
                    });
                  })),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                            loggerNoStack
                                .e('selectedTransferCategory value ' + value!);

                            for (TransferCategory category
                                in transferCategoryList) {
                              loggerNoStack
                                  .e('categoryName ' + category.categoryName!);
                              if (category.categoryName == value) {
                                selectedTransferCategory = category;
                                selectedType = category.categoryName!;
                                transferType = category.categoryName!;
                                if (transferType == 'Bank') {
                                  getBankGatewaysList();
                                } else if (transferType == 'UPI') {
                                  getUPIGatewaysList();
                                }
                              }
                            }
                            loggerNoStack.e(
                                'selectedTransferCategory.categoryName ' +
                                    selectedTransferCategory.categoryName!);
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              widgetCurrencyBankType(
                  context,
                  selectedType == 'UPI',
                  selectedCurrency,
                  selectedGateway,
                  currencyList,
                  bankList,
                  selectedType == 'UPI', completion: (currency) {
                setState(() {
                  selectedCurrency = currency;
                  loggerNoStack.e('transferType ' + transferType);
                  loggerNoStack.e('selectedCurrency ' + selectedCurrency);
                  filterGatewayList(selectedCurrency, transferType);
                });
              }, completion2: (bankUpi) {
                setState(() {
                  loggerNoStack.e('bankUpi ' + bankUpi);
                  selectedGateway = bankUpi;
                });
              }),
              Visibility(
                  visible: selectedType != 'UPI',
                  child: widgetBankAccountNumber(
                      context,
                      true,
                      "Bank Account Number",
                      "Account Number",
                      numberController,
                      holderController,
                      selectedType == 'UPI' ? upiDetails : bankDetails,
                      completion: (value) {
                    accountNumber = value;
                  })),
              Visibility(
                  visible: true,
                  child: widgetBankAccountNumber(
                      context,
                      false,
                      "Account Holder Name",
                      "Account Holder Name",
                      numberController,
                      holderController,
                      selectedType == 'UPI' ? upiDetails : bankDetails,
                      completion: (value) {
                    holderName = value;
                  })),
              Visibility(
                visible: selectedType == 'UPI',
                child: Padding(
                  padding: const EdgeInsets.only(left: 1.0, right: 1.0),
                  child: widgetTextController(
                      context,
                      AppStringUtils.TYPE_ANY,
                      "Enter UPI ID ",
                      "Enter UPI ID",
                      upiIDController,
                      selectedType == 'UPI' ? upiDetails : bankDetails,
                      completion: (value) {
                    upiId = value;
                  }),
                ),
              ),
              Visibility(
                visible: false,
                child: Padding(
                  padding: const EdgeInsets.only(left: 1.0, right: 1.0),
                  child: widgetTextController(
                      context,
                      AppStringUtils.TYPE_PERSON_NAME,
                      StringViewConstants.accountHolderName,
                      StringViewConstants.enterHolderName,
                      widget.accountHolderController,
                      selectedType == 'UPI' ? upiDetails : bankDetails,
                      completion: (accountHolderNAme) {
                    widget.accountHolderController.text = accountHolderNAme;
                  }),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              widgetTransferBlueButton(
                  context,
                  selectedType == 'UPI' ? "Add UPI" : "Add Bank",
                  ColorViewConstants.colorBlueSecondaryText,
                  '1',
                  selectedType == 'UPI'
                      ? "Please enter UPI ID"
                      : "Please enter account number", completion: (amount) {
                if (selectedType == 'UPI') {
                  if (upiIDController.text.isNotEmpty) {
                    callCreateBank();
                  } else {
                    ToastUtils.instance.showToast('Please enter UPI ID',
                        context: context,
                        isError: false,
                        bg: ColorViewConstants.colorYellow);
                  }
                } else {
                  if (accountNumber.isEmpty) {
                    ToastUtils.instance.showToast('Please enter account number',
                        context: context,
                        isError: false,
                        bg: ColorViewConstants.colorYellow);
                  } else if (holderName.isEmpty) {
                    ToastUtils.instance.showToast('Please enter account holder',
                        context: context,
                        isError: false,
                        bg: ColorViewConstants.colorYellow);
                  } else {
                    callCreateBank();
                  }
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
