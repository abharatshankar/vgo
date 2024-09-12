import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/model/request/create_recipient_request.dart';
import 'package:vgo_flutter_app/src/utils/app_string_utils.dart';
import 'package:vgo_flutter_app/src/view/common/common_tool_bar_transfer.dart';
import 'package:vgo_flutter_app/src/view/services/transfer/transfer_blue_button_widget.dart';
import 'package:vgo_flutter_app/src/view/services/vgo_wallet_transfer/currency_bank_type_widget.dart';
import 'package:vgo_flutter_app/src/view/services/vgo_wallet_transfer/widget_text_controller.dart';

import '../../../model/bank_upi.dart';
import '../../../model/country.dart';
import '../../../model/transgent_category.dart';
import '../../../session/session_manager.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/toast_utils.dart';
import '../../../utils/utils.dart';
import '../../../view_model/login_view_model.dart';
import '../../../view_model/services_view_model.dart';
import '../transfer/transfer_phone_number_widget.dart';
import '../vgo_wallet_transfer/select_transfer_mode_widget.dart';

class AddNewRecipientView extends StatefulWidget {
  @override
  State<AddNewRecipientView> createState() => AddNewRecipientState();

  final phoneNumberController = TextEditingController();
  final recipientController = TextEditingController();
  final accountHolderController = TextEditingController();
  final accountNumberController = TextEditingController();
  final dummyController = TextEditingController();
  final upiIDController = TextEditingController();

  String accountNumber = '';
  String accountHolderName = '';
  String upiId = '';
  String recipientName = '';
  String selectedCurrency = 'INR';
  String selectedBank = 'ICICI BANK';
  String selectedUPI = 'PhonePe';
  String transferType = 'Bank';

  // bool isUpi = true;
  List<BankUPI>? bankList;
  List<BankUPI>? upiList;
  List<Country>? currencyList = [];
  BankUPI? bankDetails;
  BankUPI? upiDetails;



  bool showProgressCircle = false;
}

class AddNewRecipientState extends State<AddNewRecipientView> {

  String userName = '';
  String currency = '';
  String selectedType = '';
  List<Country>? countryList = [];
  List<TransferCategory> transferCategoryList = [];

  TransferCategory selectedTransferCategory = TransferCategory(
      categoryCode: 'BANK',
      categoryName: 'Bank',
      categoryIconPath: 'https://vgopay.in/icons/bank.png');

  @override
  void initState() {
    super.initState();
    callSettingsConfigApi();
    callCurrenciesApi();
    callAllBanksApi('Bank','INR');
    callAllUPIsApi('INR');
    // callCreateRecipient();
    callCountryListApi();

    SessionManager.getUserName().then((value) {
      setState(() {
        userName = value!;
        loggerNoStack.e('userName ' + userName);
      });
    });

    SessionManager.getCurrency().then((value) {
      setState(() {
        currency = value!;
        loggerNoStack.e('currency ' + currency);
      });
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


  void callAllBanksApi(String category, String currencyType) {
    setState(() {
      widget.showProgressCircle = true;
    });

    ServicesViewModel.instance.callGetBanksList(category, currencyType,
        completion: (response) {
          setState(() {
            widget.showProgressCircle = false;
          });

          if (response!.success ?? true) {
            setState(() {
              widget.bankList = response.bankUpiList;
            });
          } else {
            loggerNoStack.e('No banks');
          }
        });
  }

  void callAllUPIsApi(String currencyType,) {
    setState(() {
      widget.showProgressCircle = true;
    });

    ServicesViewModel.instance.callGetUpiList(currencyType,
        completion: (response) {
          setState(() {
            widget.showProgressCircle = false;
          });

          if (response!.success ?? true) {
            setState(() {
              widget.upiList = response.bankUpiList;
            });
          } else {
            loggerNoStack.e('No banks');
          }
        });
  }

  void callCurrenciesApi() {
    setState(() {
      widget.showProgressCircle = true;
    });

    ServicesViewModel.instance.callGetCurrenciesList(completion: (response) {
      setState(() {
        widget.showProgressCircle = false;
      });

      setState(() {
        for(Country country in response!.currencyList!){
          loggerNoStack.e('country : ' + country.currency!);
          if(country.currency!.toLowerCase() == currency.toLowerCase()){
            widget.currencyList!.add(country);
          }
        }

      });
    });
  }

  void callCountryListApi() {
    LoginViewModel.instance.apiCountryList(completion: (response) {
      setState(() {
        countryList = response!.countryList!;
        AppStringUtils.defaultCountry = countryList![1];
      });
    });
  }

  void callCreateRecipient() {
    setState(() {
      widget.showProgressCircle = true;
    });

    SessionManager.getUserName().then((value) {
      setState(() {
        userName = value!;
        loggerNoStack.e('userName callCreateRecipient ' + userName);

        String account_number = '';
        String bank_name = '';
        String recipient_type = '';

        if (widget.transferType == 'UPI') {
          account_number = widget.upiIDController.text;
          bank_name = widget.selectedUPI;
          recipient_type = 'UPI';
        } else if (widget.transferType == 'Bank') {
          account_number = widget.accountNumberController.text;
          bank_name = widget.selectedBank;
          recipient_type = 'BANK';
        }

        final CreateRecipientRequest request = CreateRecipientRequest(
            accountHolderName: widget.accountHolderController.text,
            accountNumber: account_number,
            bankName: bank_name,
            userName: userName,
            currencyCode: widget.selectedCurrency,
            mobileNumber: widget.phoneNumberController.text,
            recipientId: widget.recipientController.text,
            recipientType: recipient_type);

        ServicesViewModel.instance.callCreateRecipient(request,
            completion: (response) {
              setState(() {
                widget.showProgressCircle = false;
                if (response!.success ?? true) {
              setState(() {

                showTransactionCancelAlert(response.message!);
              });
            } else {
              ToastUtils.instance.showToast(response.message!,
                  context: context, isError: true);
            }
          });
        });
      });
    });
  }

  void showTransactionCancelAlert(String message) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      text: message,
      confirmBtnText: StringViewConstants.okay,
      confirmBtnColor: ColorViewConstants.colorBlueSecondaryText,
      onConfirmBtnTap: () {
        Navigator.pop(
          context, true);
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
        toolbarHeight: 0,
        backgroundColor: ColorViewConstants.colorBlueSecondaryText,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              toolBarTransferWidget(context, StringViewConstants.addNewRecipientTitle,false),

              widgetTextController(
                  context,
                  AppStringUtils.TYPE_PERSON_NAME,
                  StringViewConstants.recipientNickName,
                  StringViewConstants.enterNickName,
                  widget.recipientController,
                  widget.transferType == 'UPI' ? widget.upiDetails : widget.bankDetails,
                  completion: (value) {
                    widget.recipientName = value;
                    loggerNoStack.e('recipientName ' + widget.recipientName);
                    loggerNoStack
                        .e('recipientName ' + widget.recipientController.text);
                  }),

              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 12.0),
                child: widgetTransferPhoneNumber(
                    context,
                    AppStringUtils.defaultCountry,
                    countryList,
                    widget.phoneNumberController,
                    TextInputAction.next,
                    StringViewConstants.mobileNumberStar,
                    true,
                    false,
                    0.54, completion: (value) {
                  loggerNoStack.e('country code ' + value.countryCode!);
                }),
              ),
          Visibility(
            visible: false,
            child:
              Padding(
                padding: const EdgeInsets.only(left: 1.0, right: 1.0),
                child: widgetSelectTransferMode(
                    context, StringViewConstants.selectTransferMode, widget.transferType == 'UPI',
                    completion: (isUpiSelected) {
                      setState(() {
                       // widget.isUpi = isUpiSelected;
                      });
                    }),
              )),
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
                                  //selectedType = upiTransfersList!.isNotEmpty ? upiTransfersList![0].recipientId! : '';
                                 // transfers = upiTransfersList!.isNotEmpty ? upiTransfersList![0] : Transfers();
                                } else {
                                 // selectedType = bankTransfersList!.isNotEmpty ? bankTransfersList![0].recipientId! : '';
                                 // transfers = bankTransfersList!.isNotEmpty ? bankTransfersList![0] : Transfers();
                                }
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
              Padding(
                padding: const EdgeInsets.only(left: 1.0, right: 1.0),
                child: widgetCurrencyBankType(
                  context,
                  widget.transferType == 'UPI',
                  AppStringUtils.defaultCurrency,
                  widget.transferType == 'UPI' ? widget.selectedUPI : widget.selectedBank,
                  widget.currencyList,
                  widget.transferType == 'UPI' ? widget.upiList : widget.bankList,
                  widget.transferType == 'UPI',
                  completion: (currency) {
                    setState(() {
                      loggerNoStack.e('currency ' + currency.toString());
                      widget.selectedCurrency = currency;
                    });
                  },
                  completion2: (bankUpi) {
                    setState(() {
                      loggerNoStack.e('bankUpi ' + bankUpi);
                      widget.transferType == 'UPI'
                          ? widget.selectedUPI = bankUpi
                          : widget.selectedBank = bankUpi;
                    });
                  },
                ),
              ),

              Visibility(
                visible: widget.transferType == 'UPI',
                child: Padding(
                  padding: const EdgeInsets.only(left: 1.0, right: 1.0),
                  child: widgetTextController(
                      context,
                      AppStringUtils.TYPE_UPI_ID,
                      StringViewConstants.enterUpiID,
                      StringViewConstants.enterUpiID,
                      widget.upiIDController,
                      widget.transferType == 'UPI' ? widget.upiDetails : widget.bankDetails,
                      completion: (value) {
                        widget.upiId = value;
                      }),
                ),
              ),

              Visibility(
                visible: widget.transferType != 'UPI',
                child: Padding(
                  padding: const EdgeInsets.only(left: 1.0, right: 1.0),
                  child: widgetTextController(
                      context,
                      AppStringUtils.TYPE_INT,
                      StringViewConstants.bankAccountNumber,
                      StringViewConstants.enterAccountNumberRecipient,
                      widget.accountNumberController,
                      widget.transferType == 'UPI' ? widget.upiDetails : widget.bankDetails,
                      completion: (value) {
                        widget.accountNumber = value;
                      }),
                ),
              ),

              Visibility(
                visible:true,
                child: Padding(
                  padding: const EdgeInsets.only(left: 1.0, right: 1.0),
                  child: widgetTextController(
                      context,
                      AppStringUtils.TYPE_PERSON_NAME,
                      StringViewConstants.accountHolderName,
                      StringViewConstants.enterHolderName,
                      widget.accountHolderController,
                      widget.transferType == 'UPI' ? widget.upiDetails : widget.bankDetails,
                      completion: (accountHolderNAme) {
                        widget.accountHolderName = accountHolderNAme;
                      }),
                ),
              ),

              SizedBox(height: 16),
              widgetTransferBlueButton(context,  StringViewConstants.addRecipient, ColorViewConstants.colorBlueSecondaryText, '1',"Please Enter Upi Id",
                  completion: (value) {
                    callCreateRecipient();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
