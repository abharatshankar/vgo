import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/session/session_manager.dart';
import 'package:vgo_flutter_app/src/view/common/widget_loader.dart';
import 'package:vgo_flutter_app/src/view/team/team_sub_list_view.dart';
import 'package:vgo_flutter_app/src/view_model/services_view_model.dart';

import '../../constants/color_view_constants.dart';
import '../../model/response/settings_response.dart';
import '../../model/response/team_response.dart';
import '../../utils/app_string_utils.dart';
import '../../utils/app_text_style.dart';
import '../../utils/utils.dart';
import '../common/common_tool_bar_transfer.dart';

class TeamListView extends StatefulWidget {
  TeamListView({super.key, required this.settingsResponse});

  SettingsResponse? settingsResponse;

  @override
  State<TeamListView> createState() => TeamListViewState();
}

class TeamListViewState extends State<TeamListView>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int _selectedIndex = 0;
  bool showProgressCircle = false;

  List<Team> teamList = [];
  List<Tab> tabList = [];
  List<TeamDetail> teamDetailList = [];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;

        if (_selectedIndex == 1) {
          teamDetailList = teamList[1].teamDetailList!;
        } else if (_selectedIndex == 2) {
          teamDetailList = teamList[2].teamDetailList!;
        } else {
          teamDetailList = teamList[0].teamDetailList!;
        }
      });
      print("Selected Index: ${_controller.index}");
    });

    SessionManager.getGapID().then((value) {
      loggerNoStack.e('gap id :${value!}');
      callGetMyTeamApi(value);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void callGetMyTeamApi(String gapId) {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callGetMyTeam(gapId, completion: (response) {
      setState(() {
        showProgressCircle = false;

        if (response!.success ?? true) {
          teamList = response.teamList!;

          for (Team team in teamList) {
            tabList.add(new Tab(
              text: team.desig,
            ));
          }

          loggerNoStack.e("teamList " + teamList.length.toString());
          teamDetailList = teamList != null && teamList.length > 0
              ? teamList[0].teamDetailList!
              : [];
        } else {
          loggerNoStack.e('response : ${response.message}');
        }
      });
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
              mainAxisSize: MainAxisSize.max,
              children: [
                toolBarTransferWidget(context, "My Team", false),
                teamList.length > 0
                    ? DefaultTabController(
                        initialIndex: _selectedIndex,
                        animationDuration: const Duration(milliseconds: 500),
                        length: teamList.length,
                        child: TabBar(
                            isScrollable: true,
                            controller: _controller,
                            tabAlignment: TabAlignment.start,
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
                            tabs: tabList),
                      )
                    : SizedBox(),
                teamList.length > 0
                    ? Expanded(
                        child: TabBarView(controller: _controller, children: [
                          loadSubList(context, teamDetailList),
                          loadSubList(context, teamDetailList),
                          loadSubList(context, teamDetailList)
                        ]),
                      )
                    : Expanded(
                        child: Align(
                        alignment: Alignment.center,
                        child: Visibility(
                          visible: !showProgressCircle,
                          child: Text(
                            'No Team Data Found!',
                            style: AppTextStyles.medium.copyWith(
                                fontSize: 16,
                                color: ColorViewConstants
                                    .colorBlueSecondaryDarkText),
                          ),
                        )
                      ))
              ],
            ),
            widgetLoader(context, showProgressCircle),
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TeamSubEarningsListView(title: StringUtils.capitalize(name) ?? '',teamDetail:  list[position],)));

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
