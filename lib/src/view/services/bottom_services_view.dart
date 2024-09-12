import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';
import 'package:vgo_flutter_app/src/view/common/common_tool_bar.dart';
import 'package:vgo_flutter_app/src/view/common/widget_loader.dart';
import 'package:vgo_flutter_app/src/view/profile/applicant_profile_view.dart';
import 'package:vgo_flutter_app/src/view/services/jobs/jobs_tabs_view.dart';
import 'package:vgo_flutter_app/src/view/services/order/delivery/orders_delivery_list_by_users_view.dart';
import 'package:vgo_flutter_app/src/view/services/services_transfer_widget.dart';
import 'package:vgo_flutter_app/src/view/services/stores/stores_list_by_category_view.dart';
import 'package:vgo_flutter_app/src/view_model/services_view_model.dart';

import '../../model/response/settings_response.dart';
import '../../model/transfer.dart';
import '../../utils/toast_utils.dart';
import 'order/orders_list_by_users_view.dart';

class BottomServicesView extends StatefulWidget {
  BottomServicesView({super.key});

  @override
  State<StatefulWidget> createState() => ServicesViewState();
}

class ServicesViewState extends State<BottomServicesView> {
  List<Transfer> transferList = [];
  bool showProgressCircle = false;
  int closeAppClick = 0;

  List<ServicesMenu> servicesMenuList = [];

  @override
  void initState() {
    super.initState();
    callGetTransferMenu();
    callServicesMenu();
  }

  void callGetTransferMenu() {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callGetTransferMenu(completion: (response) {
      setState(() {
        showProgressCircle = false;
      });

      setState(() {
        for (Transfer transfer in response!.transferList!) {
          if (transfer.visible == 'true') {
            transferList.add(transfer);
          }
        }
      });
    });
  }

  void callServicesMenu() {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callSettingsConfig(completion: (response) {
      setState(() {
        showProgressCircle = false;
      });

      setState(() {
        servicesMenuList = response!.servicesMenuList!;
        loggerNoStack
            .e('servicesMenuList : ' + servicesMenuList.length.toString());
      });
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3.5;
    final double itemWidth = size.width / 2;

    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            backgroundColor: ColorViewConstants.colorWhite,
            appBar: AppBar(
              backgroundColor: ColorViewConstants.colorBlueSecondaryText,
              toolbarHeight: 0,
            ),
            body: Stack(
              children: [
                toolBarWidget(context, StringViewConstants.services,
                    completion: (value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrdersListByUsersView(
                                category: '',
                              )));
                }),
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.18,
                  margin: const EdgeInsets.only(top: 70, left: 15, right: 15),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/services/ic_services_bg.png',
                        ),
                        fit: BoxFit.fill),
                  ),
                ),
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.1,
                  margin: const EdgeInsets.only(top: 160, left: 15, right: 15),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/services/ic_services_menu_bg.png',
                        ),
                        fit: BoxFit.fill),
                  ),
                ),
                Container(
                    width: screenWidth,
                    margin: const EdgeInsets.only(top: 80, left: 30, right: 30),
                    padding: EdgeInsets.only(top: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            'Wallet balance',
                            style: AppTextStyles.medium.copyWith(
                                fontSize: 12,
                                color: ColorViewConstants.colorGray),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            'Rs 89700',
                            style: AppTextStyles.semiBold.copyWith(
                                fontSize: 15,
                                color: ColorViewConstants.colorWhite),
                          ),
                        ),
                        Text(
                          'Money transfer',
                          style: AppTextStyles.semiBold.copyWith(
                              fontSize: 15,
                              color: ColorViewConstants.colorWhite),
                        ),
                      ],
                    )),
                Container(
                  height: screenHeight * 0.12,
                  margin: const EdgeInsets.only(top: 140, left: 15, right: 15),
                  child: Align(
                      child: servicesTransferWidget(context, transferList)),
                ),
                Container(
                    margin: EdgeInsets.only(top: 270),
                    color: ColorViewConstants.colorWhite,
                    child: Expanded(
                        child: SingleChildScrollView(
                            child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: screenHeight * 0.23,
                          width: screenWidth,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Image.asset(
                            'assets/images/banner/banner3.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: servicesMenuList.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, position) {
                              return Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        servicesMenuList[position].title ?? '',
                                        style: AppTextStyles.medium.copyWith(
                                            color: ColorViewConstants
                                                .colorPrimaryText,
                                            fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: screenHeight * 0.13,
                                        child: ListView.builder(
                                            itemCount:
                                                servicesMenuList[position]
                                                    .servicesMenu
                                                    ?.length,
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                  onTap: () {
                                                    loggerNoStack.e(
                                                        'cliced on services : ' +
                                                            servicesMenuList[
                                                                    position]
                                                                .servicesMenu![
                                                                    index]
                                                                .menuCode
                                                                .toString());
                                                    if ("DELIVERY" ==
                                                        servicesMenuList[
                                                                position]
                                                            .servicesMenu![
                                                                index]
                                                            .menuCode
                                                            .toString()) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  OrdersDeliveryListByUsersView(
                                                                    category: servicesMenuList[position]
                                                                            .servicesMenu![index]
                                                                            .menuCode ??
                                                                        '',
                                                                  )));
                                                    } else if ("JOBS" ==
                                                        servicesMenuList[
                                                                position]
                                                            .servicesMenu![
                                                                index]
                                                            .menuCode
                                                            .toString()) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  JobsTabsView()));
                                                    } else if ("GAP" ==
                                                        servicesMenuList[
                                                                position]
                                                            .servicesMenu![
                                                                index]
                                                            .menuCode
                                                            .toString()) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ApplicantProfileView()));
                                                    } else {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  StoresListByCategoryView(
                                                                    category: servicesMenuList[position]
                                                                            .servicesMenu![index]
                                                                            .menuCode ??
                                                                        '',
                                                                  )));
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 10,
                                                        bottom: 10),
                                                    width: screenWidth * 0.25,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Image.network(
                                                            servicesMenuList[
                                                                        position]
                                                                    .servicesMenu![
                                                                        index]
                                                                    .menuIconPath ??
                                                                '',
                                                            height: 35,
                                                            width: 35,
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            servicesMenuList[
                                                                        position]
                                                                    .servicesMenu![
                                                                        index]
                                                                    .menuName ??
                                                                '',
                                                            style: AppTextStyles
                                                                .medium
                                                                .copyWith(
                                                                    color: ColorViewConstants
                                                                        .colorPrimaryTextHint,
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                        ]),
                                                  ));
                                            }),
                                      )
                                    ]),
                              );
                            }),
                      ],
                    )))),
                widgetLoader(context, showProgressCircle),
              ],
            )));
  }
}
