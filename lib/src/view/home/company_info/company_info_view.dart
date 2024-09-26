import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/model/request/create_buyer_seller_order_request.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';
import 'package:vgo_flutter_app/src/view/common/common_tool_bar_transfer.dart';
import 'package:vgo_flutter_app/src/view/home/company_info/analysis_overview_widget.dart';
import 'package:vgo_flutter_app/src/view/home/company_info/buy_sell_widget.dart';
import 'package:vgo_flutter_app/src/view/home/company_info/company_info_widget.dart';
import 'package:vgo_flutter_app/src/view/home/company_info/company_services_widget.dart';
import 'package:vgo_flutter_app/src/view/home/company_info/sub_services_list.dart';
import 'package:vgo_flutter_app/src/view/home/company_info/widget_bid_transactions_list.dart';
import 'package:vgo_flutter_app/src/view/home/company_info/widget_bids_header.dart';
import 'package:vgo_flutter_app/src/view/home/company_info/widget_company_progress_list.dart';
import 'package:vgo_flutter_app/src/view_model/home_view_model.dart';

import '../../../model/company.dart';
import '../../../model/wallet.dart';
import '../../../session/session_manager.dart';
import '../../../view_model/wallet_view_model.dart';

class CompanyInfoView extends StatefulWidget {
  CompanyInfoView({super.key, this.company, });

  final Company? company;
  List<Wallet> walletList = [];
  List<Company>? companyList = [];
  List<Company>? progressLogsList = [];
  String lowStockPrice = '';
  String highStockPrice = '';
  String totalVolume = '';
  bool showProgressCircle = false;
  int companyServicePosition = 0;

  @override
  State<StatefulWidget> createState() => CompanyInfoViewState();
}

class CompanyInfoViewState extends State<CompanyInfoView> {
  String? userName;

  get onPressed => null;

  @override
  void initState() {
    super.initState();
    SessionManager.getUserName().then((value) {
      loggerNoStack.e('userName :${value!}');
      userName = value;
      callLowStockPriceApi();
      callHighStockPriceApi(widget.company!.symbol!);
      callGetStockTransfersVolumeApi(widget.company!.symbol!);
      callSubServicesCompanyApi(widget.company!.companyCode!);
      callProgressLogsApi(widget.company!.companyCode!);
    });
  }



  void callLowStockPriceApi() {
    setState(() {
      widget.showProgressCircle = true;
    });
    HomeViewModel.instance.getLowStockPrice(widget.company!.symbol!, completion: (response) {
      setState(() {
        widget.showProgressCircle = false;
      });
      if (response!.success ?? true) {
        widget.lowStockPrice = response.company!.lowStockPrice!;
      } else {
        loggerNoStack.e(
          'message${response.message!}',
        );
      }
    });
  }

  void callHighStockPriceApi(
    String symbol,
  ) {
    setState(() {
      widget.showProgressCircle = true;
    });
    HomeViewModel.instance.getHighStockPrice(symbol, completion: (response) {
      setState(() {
        widget.showProgressCircle = false;
      });
      if (response!.success ?? true) {
        widget.highStockPrice = response.company!.highStockPrice!;
      } else {
        loggerNoStack.e(
          'message${response.message!}',
        );
      }
    });
  }

  void callGetStockTransfersVolumeApi(
    String symbol,
  ) {
    setState(() {
      widget.showProgressCircle = true;
    });
    HomeViewModel.instance.getStockTransfersVolume(symbol,
        completion: (response) {
      setState(() {
        widget.showProgressCircle = false;
      });
      if (response!.success ?? true) {
        widget.totalVolume = response.company!.volume!;
      } else {
        loggerNoStack.e(
          'message${response.message!}',
        );
      }
    });
  }

  void callSubServicesCompanyApi(
    int companyCode,
  ) {
    setState(() {
      widget.showProgressCircle = true;
    });
    HomeViewModel.instance.callGetStartUpServicesList(companyCode,
        completion: (response) {
      setState(() {
        widget.showProgressCircle = false;
      });
      if (response!.success ?? true) {
        widget.companyList = response.companyList!;
      } else {
        loggerNoStack.e(
          'message${response.message!}',
        );
      }
    });
  }

  void callProgressLogsApi(
    int companyCode,
  ) {
    setState(() {
      widget.showProgressCircle = true;
    });
    HomeViewModel.instance.callGetStartUpProgressLogs(companyCode,
        completion: (response) {
      setState(() {
        widget.showProgressCircle = false;
      });
      if (response!.success ?? true) {
        widget.progressLogsList = response.companyList!;
      } else {
        loggerNoStack.e(
          'message${response.message!}',
        );
      }
    });
  }

// buy
  void callGetBuyerOrders(String companyName,) {
    setState(() {
      widget.showProgressCircle = true;
    });
    HomeViewModel.instance.getBuyerOrders(companyName, completion: (response) {
      setState(() {
        widget.showProgressCircle = false;
      });
    });
  }

//create buy

  void callCreateBuyerOrder( ) {
    setState(() {
      widget.showProgressCircle = true;
    });

    final CreateBuyerSellerOrderRequest request = CreateBuyerSellerOrderRequest(
      userName: userName,
      symbol: '',
      units: '',
      stockPrice: '',
    );

    HomeViewModel.instance.callCreateBuyerOrder(request,
        completion: (response) {
      setState(() {
        widget.showProgressCircle = false;
      });
    });
  }

  //sell
  void callGetSellerOrders(String companyName,) {
    setState(() {
      widget.showProgressCircle = true;
    });
    HomeViewModel.instance.getSellerOrders(companyName, completion: (response) {
      setState(() {
        widget.showProgressCircle = false;
      });
    });
  }

// create seller

  void callCreateSellerOrder( ) {
    setState(() {
      widget.showProgressCircle = true;
    });

    final CreateBuyerSellerOrderRequest request = CreateBuyerSellerOrderRequest(
      userName: userName,
      symbol: '',
      units: '',
      stockPrice: '',
    );

    HomeViewModel.instance.callCreateSellerOrder(request,
        completion: (response) {
          setState(() {
            widget.showProgressCircle = false;
          });
        });
  }

  //wallet
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
      body: Container(
        // padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            toolBarTransferWidget(context, widget.company!.companyName!,false),
            Expanded(
                child:  SingleChildScrollView(

                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),

                      widgetCompanyInfo(context, widget.company),

                      widgetBuySell(context, widget.company,isBuy: true,userName ?? ""),

                      widgetAnalysisOverView(context, widget.lowStockPrice,
                          widget.highStockPrice, widget.totalVolume),

                      SizedBox(
                        height: screenHeight * 0.01,
                      ),

                      companyServicesWidget(
                          context, widget.companyServicePosition,
                          completion: (position) {
                            setState(() {
                              widget.companyServicePosition = position;
                            });
                          }),

                      SizedBox(
                        height: screenHeight * 0.01,
                      ),

                      Visibility(
                          visible: widget.companyServicePosition == 0,
                          child:
                          widgetSubServicesList(context, widget.companyList)
                      ),

                      Visibility(
                          visible: widget.companyServicePosition == 1,
                          child: widgetCompanyProgressList(
                              context, widget.progressLogsList)
                      ),

                      Visibility(
                        visible: widget.companyServicePosition == 2,
                        child: widgetBidTransactionList(context),
                       // child: widgetSubServicesList(context)
                        ),

                    ],
                  ),
                )

            )
          ],
        ),
      ),
    );
  }
}



