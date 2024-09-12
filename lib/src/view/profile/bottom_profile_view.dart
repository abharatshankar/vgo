import 'dart:async';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/model/request/mobile_number_request.dart';
import 'package:vgo_flutter_app/src/model/response/settings_response.dart';
import 'package:vgo_flutter_app/src/session/session_manager.dart';
import 'package:vgo_flutter_app/src/view/activity/transagent/transagent_view.dart';
import 'package:vgo_flutter_app/src/view/common/common_tool_bar.dart';
import 'package:vgo_flutter_app/src/view/profile/settings_list_view.dart';
import 'package:vgo_flutter_app/src/view/profile/widget_qr_code.dart';
import 'package:vgo_flutter_app/src/view/profile/widget_user_info.dart';
import 'package:vgo_flutter_app/src/view_model/services_view_model.dart';

import '../../constants/string_view_constants.dart';
import '../../model/user.dart';
import '../../utils/app_text_style.dart';
import '../../utils/toast_utils.dart';
import '../../utils/utils.dart';
import '../../view_model/login_view_model.dart';
import '../login/user_login_view.dart';
import '../scanner/qr_scanner_view.dart';
import '../services/jobs/my_posted_jobs_list_view.dart';
import '../services/order/orders_list_by_users_view.dart';
import '../team/team_menu_view.dart';

class BottomProfileView extends StatefulWidget {
  BottomProfileView({super.key});

  @override
  State<BottomProfileView> createState() => BottomProfileState();
}

class BottomProfileState extends State<BottomProfileView> {
  int closeAppClick = 0;
  String mobileNumber = '';

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  User? user;
  String appVersion = '';

  SettingsResponse? settingsResponse;

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
      loggerNoStack.e('_packageInfo ' + _packageInfo.version);
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
  void initState() {
    super.initState();

    _initPackageInfo();

    SessionManager.getMobileNumber().then((value) {
       mobileNumber = value!;
      callUserExistsApi(mobileNumber);
      callSettingsConfigApi();
    });
  }

  void callUserExistsApi(String number) {
    final MobileNumberRequest request =
    MobileNumberRequest(mobileNumber: number);
    LoginViewModel.instance.callUserExistsOrNot(request,
        completion: (response) {
      if (response!.success ?? true) {
        setState(() {
          user = response.user!;
          SessionManager.setProfession(user?.profession);
        });
      } else {
        loggerNoStack.e('response : ${response.message}');
      }
    });
  }

  void callSettingsConfigApi() {
    ServicesViewModel.instance.callSettingsConfig(completion: (response) {
      setState(() {
        settingsResponse = response;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1;

    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: ColorViewConstants.colorWhite,
          appBar: AppBar(
            backgroundColor: ColorViewConstants.colorBlueSecondaryText,
            toolbarHeight: 0,
          ),
          body: Container(
            color: ColorViewConstants.colorWhite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                toolBarWidget(context,  StringViewConstants.profile, completion: (value){
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
                }),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        widgetUserInfo(context, user),

                        SizedBox(
                          height: screenHeight * 0.02,
                        ),

                        widgetUserQRCode(context, mobileNumber),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'More',
                            style: AppTextStyles.bold.copyWith(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 10,
                            bottom: 0,
                          ),
                          child: Visibility(
                            visible: false,
                            child: TransAgentView(settingsResponse: settingsResponse,),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: GridView.count(
                            childAspectRatio: (itemWidth / itemHeight),
                            crossAxisCount: 3,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            children: List.generate(
                              settingsResponse != null ? settingsResponse!.moreMenuList!.length : 0,
                              (index) {
                                return InkWell(
                                    onTap: () {

                                      if (settingsResponse!.moreMenuList![index].menuCode!.toString().toLowerCase() == 'transagent') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TransAgentView(settingsResponse: settingsResponse,)));
                                      } else if (settingsResponse!.moreMenuList![index].menuCode!.toString().toLowerCase() == 'team') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TeamMenuView(settingsResponse: settingsResponse)));
                                      } else if (settingsResponse!.moreMenuList![index].menuCode!.toString().toLowerCase() == 'job') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MyPostedJobsListView()));
                                      } else if (settingsResponse!.moreMenuList![index].menuCode!.toString().toLowerCase() == 'order') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrdersListByUsersView(category: StringViewConstants.CONSTANT_OWNER_STORE_ORDER,)));
                                      }else if (settingsResponse!.moreMenuList![index].menuCode!.toString().toLowerCase() == 'settings') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SettingsListView()));
                                      } else if (index == 100) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SettingsListView()));
                                      } else {
                                        CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.confirm,
                                          text:
                                              StringViewConstants.wantToLogout,
                                          confirmBtnText:
                                              StringViewConstants.yes,
                                          cancelBtnText: StringViewConstants.no,
                                          confirmBtnColor: ColorViewConstants
                                              .colorBlueSecondaryText,
                                          onConfirmBtnTap: () {
                                            SessionManager.clearSession();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserLoginView()));
                                          },
                                        );
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(70),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.network(
                                            settingsResponse!.moreMenuList![index].menuIconPath!,
                                            width: 35,
                                            height: 35,
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.01,
                                          ),
                                          Text(
                                            settingsResponse!.moreMenuList![index].menuName!,
                                            style:
                                                AppTextStyles.medium.copyWith(
                                              fontSize: 13,
                                              color: ColorViewConstants
                                                  .colorPrimaryTextMedium,
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ));
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

/*  generateMenuList() {
    widget.menuDataList = [
      SettingsData(
        title: StringViewConstants.transagent,
        icon: Icons.category_outlined,
      ),
      SettingsData(
        title: StringViewConstants.settings,
        icon: Icons.settings,
      ),
      SettingsData(
        title: StringViewConstants.logout,
        icon: Icons.logout,
      ),
    ];
  }*/
}
