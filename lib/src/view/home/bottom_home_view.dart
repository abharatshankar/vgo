import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/model/company.dart';
import 'package:vgo_flutter_app/src/model/response/coin_detail.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';
import 'package:vgo_flutter_app/src/view/common/common_tool_bar.dart';
import 'package:vgo_flutter_app/src/view/common/widget_loader.dart';
import 'package:vgo_flutter_app/src/view/home/bottom_home_list_chip.dart';
import 'package:vgo_flutter_app/src/view/home/company_list_view.dart';
import 'package:vgo_flutter_app/src/view/home/widget/widget_home_coin_details.dart';
import 'package:vgo_flutter_app/src/view_model/home_view_model.dart';

import '../../constants/string_view_constants.dart';
import '../../session/session_manager.dart';
import '../../utils/toast_utils.dart';
import '../scanner/qr_scanner_view.dart';
import '../services/order/orders_list_by_users_view.dart';

class BottomHomeView extends StatefulWidget {
  BottomHomeView({super.key});

  CoinDetail? coin;
  List<String> iioCategoriesList = [];
  List<Company> companyList = [];
  List<Company> filterCompanyList = [];
  int seedIndex = 0;


  @override
  State<StatefulWidget> createState() => BottomHomeState();
}

class BottomHomeState extends State<BottomHomeView> {
  bool showProgressCircle = true;
  String? userName;
  String? mobileNumber;

  int closeAppClick = 0;

  @override
  void initState() {
    super.initState();

    SessionManager.getUserName().then((value) {
      userName = value;
      loggerNoStack.e('userName :${userName!}');

      callCoinApiDetails();
      callIIOCategoriesApiDetails();
      callStartUpsApiDetails();
    });

    SessionManager.getMobileNumber().then((value) {
      mobileNumber = value;
      loggerNoStack.e('mobileNumber :${mobileNumber!}');
    });
  }

  void callCoinApiDetails() {

    HomeViewModel.instance.apiCoinDetails(completion: (response) {
      setState(() {
        showProgressCircle = false;
      });

      if (response!.success ?? true) {
        widget.coin = response.coin;
      } else {
        loggerNoStack.e('response :${response.message}');
      }
    });
  }

  void callIIOCategoriesApiDetails() {

    HomeViewModel.instance.apiIIOCategories(completion: (response) {
      setState(() {
        showProgressCircle = false;
      });
      widget.iioCategoriesList.add(StringViewConstants.all);
      widget.iioCategoriesList.addAll(response!.iioCategoriesList!);
    });
  }

  void callStartUpsApiDetails() {

    HomeViewModel.instance.apiStartUps(completion: (response) {
      setState(() {
        showProgressCircle = false;
      });

      widget.companyList = response!.companyList!;

      for (Company company in widget.companyList) {
        widget.filterCompanyList.add(company);
      }

    });
  }

  Future<bool> _onWillPop() async {
    closeAppClick++;
    if(closeAppClick == 2){
      exit(0);
    } else {
      ToastUtils.instance
          .showToast("Please press back again to close the app.", context: context, isError: false, bg: ColorViewConstants.colorYellow);
    }

    Future.delayed(const Duration(seconds: 5), () {
      closeAppClick = 0;
    });

    return false;
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    toolBarWidget(context, StringViewConstants.home,
                        completion: (value) {
                      if (value == 'SCAN_ICON') {
                        loggerNoStack
                            .e('........ QR scanner initiated ........');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QrScannerView()));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrdersListByUsersView(
                                      category: '',
                                    )));
                      }

                      //callID: mobileNumber ?? ''
                      //mobileNumber ?? ''
                      //       userName: userName ?? '',
                      /*          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CallPage(
                                    callID: userName ?? '',
                                    mobileNumber: mobileNumber ?? '',
                                    userName: userName ?? '',
                                  )));*/
/*
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CallPage(
                                    callID: '9092143103',
                                    mobileNumber: '9092143103' ?? '',
                                    userName:
                                        '7abf03a3ca54ed76b4f635ef0152c5c9' ??
                                            '',
                                  )));*/

                        /*  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CallPage(
                                    callID: '9b80b43ee130f3f5cad40a36487e5281',
                                    mobileNumber: '9876543210' ?? '',
                                    userName:
                                    '9b80b43ee130f3f5cad40a36487e5281' ??
                                        '',
                                  )));*/
                    }),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    widgetHomeCoinDetails(context, widget.coin),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    // BottomHomeChip(context),
                    SizedBox(
                        height: screenHeight * 0.05,
                        child: bottomHomeListChip(
                            context, widget.seedIndex, widget.iioCategoriesList,
                            getSelectedPosition: (selectedPosition) {
                          widget.filterCompanyList.clear();

                          setState(() {
                            widget.seedIndex = selectedPosition;

                            if (widget.iioCategoriesList[selectedPosition]
                                    .toLowerCase() ==
                                StringViewConstants.seed) {
                              for (Company company in widget.companyList) {
                                if (company.iioCategory?.toLowerCase() ==
                                    StringViewConstants.seed) {
                                  widget.filterCompanyList.add(company);
                                }
                              }
                            } else if (widget
                                    .iioCategoriesList[selectedPosition]
                                    .toLowerCase() ==
                                StringViewConstants.preIio) {
                              for (Company company in widget.companyList) {
                                if (company.iioCategory?.toLowerCase() ==
                                    StringViewConstants.preIio) {
                                  widget.filterCompanyList.add(company);
                                }
                              }
                            } else if (widget
                                    .iioCategoriesList[selectedPosition]
                                    .toLowerCase() ==
                                StringViewConstants.iio) {
                              for (Company company in widget.companyList) {
                                if (company.iioCategory?.toLowerCase() ==
                                    StringViewConstants.iio) {
                                  widget.filterCompanyList.add(company);
                                }
                              }
                            } else {
                              for (Company company in widget.companyList) {
                                widget.filterCompanyList.add(company);
                              }
                            }
                            //loggerNoStack.e('filterCompanyList ${widget.filterCompanyList.length}');
                          });
                        })),

                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Expanded(
                        child: widgetCompanyList(
                            context, widget.filterCompanyList)),
                  ],
                ),
              ),
              widgetLoader(context, showProgressCircle)
            ],
          )),
    );
  }
}
