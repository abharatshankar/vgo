import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/model/wallet.dart';
import 'package:vgo_flutter_app/src/session/session_manager.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/view/common/common_tool_bar.dart';
import 'package:vgo_flutter_app/src/view/common/no_data_found.dart';
import 'package:vgo_flutter_app/src/view/common/transaction_status_view.dart';
import 'package:vgo_flutter_app/src/view/common/widget_loader.dart';
import 'package:vgo_flutter_app/src/view/wallet/widget_wallet_amount_list.dart';
import 'package:vgo_flutter_app/src/view/wallet/widget_wallet_receipt_list.dart';
import 'package:vgo_flutter_app/src/view_model/wallet_view_model.dart';

import '../../model/coin.dart';
import '../../utils/CustomOverlayWidget.dart';
import '../../utils/app_string_utils.dart';
import '../../utils/toast_utils.dart';
import '../../utils/utils.dart';
import '../scanner/qr_scanner_view.dart';
import '../services/order/orders_list_by_users_view.dart';

class BottomWalletView extends StatefulWidget {
  BottomWalletView({super.key});

  List<Wallet> walletList = [];

  List<Coin> allCoinsList = [];

  bool showProgressCircle = false;

  @override
  State<StatefulWidget> createState() => BottomWalletState();
}

class BottomWalletState extends State<BottomWalletView> {
  String? userName;
  int closeAppClick = 0;
  bool isOverlay = false;
  final Customoverlaywidget customoverlaywidget = Customoverlaywidget();
  @override
  void initState() {
    super.initState();
    SessionManager.getUserName().then((value) {
      userName = value;
      callWallet();
      callGetCoinTrans();
    });
  }

  Future<bool> _onWillPop() async {
    closeAppClick++;
    if (closeAppClick == 2) {
      exit(0);
    } else {
      ToastUtils.instance.showToast("Please press back again to close the app.",
          context: context, isError: false, bg: ColorViewConstants.colorYellow);
    }

    Future.delayed(const Duration(seconds: 5), () {
      closeAppClick = 0;
    });

    return false;
  }

  void callWallet() {
    setState(() {
      widget.showProgressCircle = true;
    });

    WalletViewModel.instance.callWallet(userName!, completion: (response) {
      setState(() {
        widget.showProgressCircle = false;
      });
      widget.walletList = response!.walletList!;
    });
  }

  void callGetCoinTrans() {
    setState(() {
      widget.showProgressCircle = true;
    });

    WalletViewModel.instance.callGetAllCoinTrans(userName!,
        completion: (response) {
      setState(() {
        widget.showProgressCircle = false;
      });
      widget.allCoinsList = response!.allCoinsList!;
    });
  }



  @override
  void dispose() {
    super.dispose();
    customoverlaywidget.hideOverlay();
  }

  @override
  void deactivate() {
    super.deactivate();
    customoverlaywidget.hideOverlay();
  }



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            backgroundColor: ColorViewConstants.colorLightWhite,
            appBar: AppBar(
              toolbarHeight: 0,
              backgroundColor: ColorViewConstants.colorBlueSecondaryText,
            ),
            body: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      toolBarWidget(context, StringViewConstants.wallet,
                          completion: (value) {
                            if (value == 'SCAN_ICON') {
                              loggerNoStack
                                  .e('........ QR scanner initiated ........');
                              customoverlaywidget.hideOverlay();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QrScannerView()));
                            } else {
                              if(isOverlay == false){
                                customoverlaywidget.showOverlay(context,[],"");
                                isOverlay = true;
                              }else{
                                customoverlaywidget.hideOverlay();
                                isOverlay = false;
                              }
                              setState(() {});

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => OrdersListByUsersView(
                              //               category: '',
                              //             )));
                            }
                      }),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: screenHeight * 0.12,
                              child: widgetWalletAmountList(
                                  context, widget.walletList),
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            Visibility(
                              visible: !widget.showProgressCircle &&
                                  widget.allCoinsList.length > 0,
                              child: Text(
                                StringViewConstants.date,
                                style: AppTextStyles.semiBold.copyWith(
                                  fontSize: 15,
                                  color: ColorViewConstants.colorBlack,
                                ),
                              ),
                            ),
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.allCoinsList?.length,
                              itemBuilder: (context, position) {
                                return InkWell(
                                  onTap: (){
                                    customoverlaywidget.hideOverlay();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>
                                          TransactionStatusView(coin: widget.allCoinsList[position],)),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.02,
                                        left: screenHeight * 0.02,
                                        right: screenHeight * 0.01,
                                        bottom: screenHeight * 0.02),
                                    decoration: BoxDecoration(
                                        color: ColorViewConstants.colorWhite,
                                        borderRadius: const BorderRadius.all(Radius.circular(10))),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        SizedBox(
                                          width: screenWidth * 0.13,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Image.network(
                                                AppStringUtils.noImageUrlWallet,
                                                width: 40,
                                                height: 40,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.allCoinsList![position].transType! +
                                                    "@" +
                                                    widget.allCoinsList[position].subTransType!,
                                                style: AppTextStyles.medium.copyWith(
                                                  fontSize: 15,
                                                  color: ColorViewConstants.colorBlueSecondaryText,
                                                ),
                                              ),
                                              SizedBox(
                                                height: screenHeight * 0.001,
                                              ),
                                              Visibility(
                                                visible: widget.allCoinsList[position].receiverName != null
                                                    ? true
                                                    : false,
                                                child: Text(
                                                  StringUtils.capitalize(
                                                      widget.allCoinsList[position].receiverName ?? '') ??
                                                      '',
                                                  style: AppTextStyles.medium.copyWith(
                                                    fontSize: 13,
                                                    color: ColorViewConstants.colorLightBlack,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: screenHeight * 0.001,
                                              ),
                                              Text(
                                                widget.allCoinsList[position].createdAt!,
                                                style: AppTextStyles.regular.copyWith(
                                                  fontSize: 13,
                                                  color: ColorViewConstants.colorHintGray,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            width: screenWidth * 0.2,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    widget.allCoinsList[position].loyaltyCoins!,
                                                    style: AppTextStyles.semiBold.copyWith(
                                                      fontSize: 14,
                                                      color: ColorViewConstants.colorPrimaryTextMedium,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: screenHeight * 0.005,
                                                  ),
                                                  Text(
                                                    widget.allCoinsList[position].transAmount!,
                                                    style: AppTextStyles.medium.copyWith(
                                                      fontSize: 14,
                                                      color: ColorViewConstants.colorPrimaryTextHint,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
                widgetLoader(context, widget.showProgressCircle),
                Visibility(
                    visible: widget.allCoinsList.length == 0,
                    child: widgetNoDataFound(context,
                        isSvg: false,
                        image: 'assets/images/wallet/wallet.png',
                        message: StringViewConstants.noTransactionsFound))
              ],
            )));
  }
}
