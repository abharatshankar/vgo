import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vgo_flutter_app/src/model/request/bot/bot_chat_request.dart';
import 'package:vgo_flutter_app/src/view_model/bot_chat_view_model.dart';

import '../../constants/color_view_constants.dart';
import '../../model/job.dart';
import '../../model/response/settings_response.dart';
import '../../session/session_manager.dart';
import '../../utils/app_box_decoration.dart';
import '../../utils/app_text_style.dart';
import '../../utils/toast_utils.dart';
import '../../utils/utils.dart';
import '../../view_model/services_view_model.dart';
import '../common/common_tool_bar.dart';
import '../scanner/qr_scanner_view.dart';
import '../services/order/orders_list_by_users_view.dart';

class BottomBotView extends StatefulWidget {
  const BottomBotView({super.key, this.job, required this.userType});

  final Job? job;
  final String userType;

  @override
  State<StatefulWidget> createState() => BottomBotState();
}

class BottomBotState extends State<BottomBotView> {
  bool showProgressCircle = false;
  String username = '';
  String selectedCategory = 'Support';
  final commentsController = TextEditingController();

  List<String> botCategoriesList = [];
  List<Job> jobList = [];
  SettingsResponse? settingsResponse;

  void callSettingsConfigApi() {
    ServicesViewModel.instance.callSettingsConfig(completion: (response) {
      setState(() {
        settingsResponse = response;
        botCategoriesList = response!.bot_categories!;
      });
    });
  }

  void callBotGetChatResponseApi() {

    final BotChatRequest request = BotChatRequest(
        category: selectedCategory, message: commentsController.text);

    BotChatViewModel.instance.callBotGetChatResponseApi(request,
        completion: (response) {
      setState(() {
        ;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    SessionManager.getUserName().then((value) {
      username = value!;
      loggerNoStack.e('username :${username}');
    });

    callSettingsConfigApi();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(children: [
      Scaffold(
          backgroundColor: ColorViewConstants.colorLightWhite,
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: ColorViewConstants.colorBlueSecondaryText,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              toolBarWidget(context, 'BOT', completion: (value) {
                if (value == 'SCAN_ICON') {
                  loggerNoStack.e('........ QR scanner initiated ........');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => QrScannerView()));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrdersListByUsersView(
                                category: '',
                              )));
                }
              }),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 30,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: botCategoriesList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, position) {
                    final String category = botCategoriesList[position];

                    return InkWell(
                      onTap: () {},
                      child: Container(
                          margin: EdgeInsets.only(left: 10),
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 4, bottom: 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: ColorViewConstants
                                      .colorBlueSecondaryText)),
                          child: Text(category + '?' ?? '',
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 13,
                                  color: ColorViewConstants
                                      .colorBlueSecondaryText))),
                    );
                  },
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.007),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/services/chat_bg.png'),
                        fit: BoxFit.fill),
                  ),
                  child: ListView.builder(
                      itemCount: jobList.length,
                      itemBuilder: (context, position) {
                        return jobList[position].user_type == "Employer"
                            ? Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                    width: screenWidth * 0.6,
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 10,
                                        bottom: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        color: ColorViewConstants.colorWhite),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          jobList[position].message ?? '',
                                          style: AppTextStyles.medium.copyWith(
                                              color: ColorViewConstants
                                                  .colorPrimaryText,
                                              fontSize: 14),
                                        ),
                                      ],
                                    )))
                            : Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                    width: screenWidth * 0.6,
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 10,
                                        bottom: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        color: ColorViewConstants
                                            .colorChatBackground),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          jobList[position].message ?? '',
                                          style: AppTextStyles.medium.copyWith(
                                              color: ColorViewConstants
                                                  .colorPrimaryText,
                                              fontSize: 14),
                                        ),
                                      ],
                                    )));
                      }),
                ),
              ),
              Container(
                color: ColorViewConstants.colorWhite,
                height: screenHeight * 0.09,
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: commentsController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Enter comments here...',
                          hintStyle: AppTextStyles.regular.copyWith(
                            fontSize: 16,
                            color: ColorViewConstants.colorGray,
                          ),
                          labelStyle:
                              AppTextStyles.medium.copyWith(fontSize: 15),
                          enabledBorder: AppBoxDecoration.noInputBorder,
                          focusedBorder: AppBoxDecoration.noInputBorder,
                          border: AppBoxDecoration.noInputBorder,
                        ),
                        style: AppTextStyles.medium,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (commentsController.text.isNotEmpty) {
                          callBotGetChatResponseApi();
                        } else {
                          ToastUtils.instance.showToast(
                              'Please enter the comments!',
                              context: context,
                              isError: false,
                              bg: ColorViewConstants.colorYellow);
                        }
                      },
                      child: SvgPicture.asset(
                        'assets/images/services/ic_send.svg',
                        height: 35,
                        width: 35,
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    ]);
  }
}
