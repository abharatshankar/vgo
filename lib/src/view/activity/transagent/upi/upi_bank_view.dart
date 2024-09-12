import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_string_utils.dart';
import 'package:vgo_flutter_app/src/view/activity/transagent/upi/upi_list.dart';
import 'package:vgo_flutter_app/src/view/common/common_tool_bar_transfer.dart';
import 'package:vgo_flutter_app/src/view/common/widget_loader.dart';
import 'package:vgo_flutter_app/src/view/services/vgo_wallet_transfer/select_transfer_mode_widget.dart';
import 'package:vgo_flutter_app/src/view_model/activity_view_model.dart';

import '../../../../constants/string_view_constants.dart';
import '../../../../model/coin.dart';
import '../../../../model/country.dart';
import '../../../../model/transfers.dart';
import '../../../../model/transgent_category.dart';
import '../../../../session/session_manager.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/utils.dart';
import '../../../../view_model/services_view_model.dart';
import 'add_bank_upi.dart';

class UPIBankView extends StatefulWidget {
  UPIBankView({super.key});

  @override
  State<StatefulWidget> createState() => UPIBankViewState();
}

class UPIBankViewState extends State<UPIBankView> {
  String? userName;
  String selectedType = '';
  String transferType = 'Bank';
  bool isUpi = true;
  List<Coin> allCoinsList = [];
  List<Country>? currencyList = [];
  List<TransferCategory> transferCategoryList = [];
  Transfers? transfers;
  TransferCategory selectedTransferCategory = TransferCategory(
      categoryCode: 'BANK',
      categoryName: 'Bank',
      categoryIconPath: 'https://vgopay.in/icons/bank.png');

  bool showProgressCircle = false;

  String addGatewayType = "Add Bank";

  @override
  void initState() {
    super.initState();
    SessionManager.getUserName().then((value) {
      userName = value;
      loggerNoStack.e('userName :${userName!}');
      callGetUserBank(userName!, "Bank");
      callCurrencyListApi();
      callSettingsConfigApi();
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

  void callDeletePaymentGatewayApi(String paymentGatewayId) {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.deletePaymentGateway(paymentGatewayId,
        completion: (response) {
      setState(() {
        showProgressCircle = false;
        callGetUserBank(userName!, selectedType);
      });
    });
  }

  void callGetUserBank(
    String userName,
    String category,
  ) {
    setState(() {
      showProgressCircle = true;
    });

    ActivityViewModel.instance.callGetUserBank(userName, category,
        completion: (response) {
      setState(() {
        showProgressCircle = false;
        allCoinsList = response!.allCoinsList!;
      });
    });
  }

  void callCurrencyListApi() {
    ServicesViewModel.instance.callGetCurrenciesList(completion: (response) {
      setState(() {
        currencyList = response!.currencyList!;
        AppStringUtils.defaultCurrency = currencyList![0].currencyCode!;
      });
    });
  }

  void showDeleteAlert(String paymentGatewayId) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.confirm,
        text: 'Do you want to delete this ' + transferType + '? ',
        confirmBtnText: StringViewConstants.yes,
        cancelBtnText: StringViewConstants.no,
        confirmBtnColor: ColorViewConstants.colorBlueSecondaryText,
        onConfirmBtnTap: () {
          callDeletePaymentGatewayApi(paymentGatewayId);
        },
        onCancelBtnTap: () {
          loggerNoStack.e('Not accepted by transaget $userName');
        });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: ColorViewConstants.colorLightWhite,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: ColorViewConstants.colorBlueSecondaryText,
        ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                toolBarTransferWidget(context, "My UPI/Bank", false),
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
                            builder: (context) => AddBankUpiView(
                                  title: addGatewayType,
                                )),
                      ).then((val) => val
                          ? callGetUserBank(userName!, selectedType)
                          : callGetUserBank(userName!, selectedType));
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '+ ' + addGatewayType,
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
                        context, " Select Transfer mode", isUpi,
                        completion: (isUpiSelected) {
                      setState(() {
                        isUpi = isUpiSelected;
                        callGetUserBank(userName!, selectedType);
                      });
                    })),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
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
                              loggerNoStack.e(
                                  'selectedTransferCategory value ' + value!);

                              for (TransferCategory category
                                  in transferCategoryList) {
                                loggerNoStack.e(
                                    'categoryName ' + category.categoryName!);
                                if (category.categoryName == value) {
                                  selectedTransferCategory = category;
                                  selectedType = category.categoryName!;
                                  transferType = category.categoryName!;
                                  addGatewayType =
                                      "Add " + category.categoryName!;
                                  callGetUserBank(userName!, selectedType);
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
                widgetUpiList(context, allCoinsList, completion: (value) {
                  showDeleteAlert(value);
                })
              ],
            ),
            widgetLoader(context, showProgressCircle)
          ],
        ));
  }
}
