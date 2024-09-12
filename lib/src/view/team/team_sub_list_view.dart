import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/session/session_manager.dart';
import 'package:vgo_flutter_app/src/view/common/widget_loader.dart';
import 'package:vgo_flutter_app/src/view_model/services_view_model.dart';

import '../../constants/color_view_constants.dart';
import '../../model/response/settings_response.dart';
import '../../model/response/team_response.dart';
import '../../utils/app_string_utils.dart';
import '../../utils/app_text_style.dart';
import '../../utils/utils.dart';
import '../common/common_tool_bar_transfer.dart';

class TeamSubEarningsListView extends StatefulWidget {
  TeamSubEarningsListView({super.key, required this.title, required this.teamDetail});

  String title = '';
 TeamDetail teamDetail;

  @override
  State<TeamSubEarningsListView> createState() => TeamSubEarningsListViewState();
}

class TeamSubEarningsListViewState extends State<TeamSubEarningsListView>
    with SingleTickerProviderStateMixin {
  bool showProgressCircle = false;
  late TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _controller = TabController(length:2, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;

        if (_selectedIndex == 1) {
        }  else {
        }
      });
      print("Selected Index: ${_controller.index}");
    });


    SessionManager.getUserName().then((value) {
      loggerNoStack.e('gap id :${value!}');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            widgetLoader(context, showProgressCircle),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                toolBarTransferWidget(context, widget.title, false),
                DefaultTabController(
                  initialIndex: _selectedIndex,
                  animationDuration: const Duration(milliseconds: 500),
                  length: 2,
                  child: TabBar(
                      isScrollable: false,
                      controller: _controller,
                      physics: const NeverScrollableScrollPhysics(),
                      labelColor:
                      ColorViewConstants.colorBlueSecondaryText,
                      unselectedLabelColor:
                      ColorViewConstants.colorHintGray,
                      labelStyle:
                      AppTextStyles.medium.copyWith(fontSize: 14),
                      indicatorColor:
                      ColorViewConstants.colorBlueSecondaryText,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: [
                        Tab(
                          text: "Sub List",
                        ),
                        Tab(
                          text: "Earnings",
                        ),
                      ]),
                ),
                Expanded(
                  child: TabBarView(controller: _controller, children: [
                      loadSubList(context, widget.teamDetail.subTeamList!),
                    loadEarningsList(context, widget.teamDetail.earningsList!)
                  ]),
                ),

              ],
            ),
          ],
        ));
  }
}

Widget loadSubList(BuildContext context, List<TeamDetail> list) {
  loggerNoStack.e("teamDetailList" + list.length.toString());

  return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, position) {
        final String name = list[position].name ?? '';

        return InkWell(
          onTap: (){

          },
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: ColorViewConstants.colorBlueSecondaryText
                        .withOpacity(1.0),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      AppStringUtils.extractFirstLetter(name) ?? '',
                      style: AppTextStyles.semiBold.copyWith(
                        fontSize: 14,
                        color: ColorViewConstants.colorWhite,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      StringUtils.capitalize(name) ?? '',
                      style: AppTextStyles.medium.copyWith(
                          color: ColorViewConstants.colorPrimaryText,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      list[position].dept ?? '',
                      style: AppTextStyles.regular.copyWith(
                          color: ColorViewConstants.colorBlueSecondaryText,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      list[position].gapId ?? '',
                      style: AppTextStyles.regular.copyWith(
                          color: ColorViewConstants.colorPrimaryTextHint,
                          fontSize: 14),
                    )
                  ],
                ))
              ],
            ),
          ),
        );
      });
}



Widget loadEarningsList(BuildContext context, List<Earnings> list) {
  loggerNoStack.e("teamDetailList" + list.length.toString());

  return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, position) {
        final String name = list[position].customerName ?? '';

        return InkWell(
          onTap: (){

          },
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: ColorViewConstants.colorBlueSecondaryText
                        .withOpacity(1.0),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      AppStringUtils.extractFirstLetter(name) ?? '',
                      style: AppTextStyles.semiBold.copyWith(
                        fontSize: 14,
                        color: ColorViewConstants.colorWhite,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          StringUtils.capitalize(name) ?? '',
                          style: AppTextStyles.medium.copyWith(
                              color: ColorViewConstants.colorPrimaryText,
                              fontSize: 14),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          list[position].storeName ?? '',
                          style: AppTextStyles.regular.copyWith(
                              color: ColorViewConstants.colorBlueSecondaryText,
                              fontSize: 14),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          list[position].transAmount ?? '',
                          style: AppTextStyles.regular.copyWith(
                              color: ColorViewConstants.colorPrimaryTextHint,
                              fontSize: 14),
                        ),

                        Text(
                          list[position].loyaltyCoins ?? '',
                          style: AppTextStyles.regular.copyWith(
                              color: ColorViewConstants.colorPrimaryTextHint,
                              fontSize: 14),
                        )
                      ],
                    ))
              ],
            ),
          ),
        );
      });
}