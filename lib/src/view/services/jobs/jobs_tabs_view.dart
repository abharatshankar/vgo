import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/view/activity/kyc/education/education_view.dart';
import 'package:vgo_flutter_app/src/view/activity/kyc/experience/experience_view.dart';
import 'package:vgo_flutter_app/src/view/common/common_tool_bar_transfer.dart';

import '../../../constants/color_view_constants.dart';
import '../../../session/session_manager.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/utils.dart';
import 'all_jobs_list_view.dart';
import 'my_jobs_list_view.dart';

class JobsTabsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => JobsTabsState();
}

class JobsTabsState extends State<JobsTabsView>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int _selectedIndex = 0;
  bool showProgressCircle = false;

  @override
  void initState() {
    super.initState();

    String? userName;

    SessionManager.getUserName().then((value) {
      userName = value;
      loggerNoStack.e('userName :${userName!}');
    });
    _controller = TabController(length: 2, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
        if (_selectedIndex == 0) {
        } else {}
      });
      print("Selected Index: ${_controller.index}");
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                toolBarTransferWidget(context, "JOBS", false, isBack: true),
                DefaultTabController(
                  initialIndex: _selectedIndex,
                  animationDuration: const Duration(milliseconds: 500),
                  length: 2,
                  child: TabBar(
                    controller: _controller,
                    physics: const NeverScrollableScrollPhysics(),
                    labelColor: ColorViewConstants.colorBlueSecondaryText,
                    unselectedLabelColor: ColorViewConstants.colorHintGray,
                    labelStyle: AppTextStyles.medium.copyWith(fontSize: 14),
                    indicatorColor: ColorViewConstants.colorBlueSecondaryText,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: const [
                      Tab(
                        text: "My Jobs",
                      ),
                      Tab(
                        text: "New Jobs",
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                      controller: _controller,
                      children: [MyJobsListView(), AllJobsListView()]),
                ),
              ],
            ),
          ],
        ));
  }
}
