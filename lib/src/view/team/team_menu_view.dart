import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/model/response/settings_response.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';
import 'package:vgo_flutter_app/src/view/common/common_tool_bar_transfer.dart';
import 'package:vgo_flutter_app/src/view/team/freelancer/team_freelancer_list_view.dart';
import 'package:vgo_flutter_app/src/view/team/team_join_view.dart';
import 'package:vgo_flutter_app/src/view/team/team_list_view.dart';

import '../../utils/app_text_style.dart';
import '../activity/kyc/kyc_tabs_view.dart';
import '../services/jobs/jobs_post_view.dart';
import '../services/jobs/my_posted_jobs_list_view.dart';

class TeamMenuView extends StatefulWidget {
  TeamMenuView({super.key, required this.settingsResponse});

  SettingsResponse? settingsResponse;

  @override
  State<TeamMenuView> createState() => TeamMenuViewState();
}

class TeamMenuViewState extends State<TeamMenuView> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3.0;
    final double itemWidth = size.width / 1.1;

    return Scaffold(
      backgroundColor: ColorViewConstants.colorLightWhite,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: ColorViewConstants.colorBlueSecondaryText,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 0.0,
          left: 0.5,
          right: 0.5,
          bottom: 0.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            toolBarTransferWidget(context, "Big Link", false, isBack: true),
            Container(
              padding: EdgeInsets.only(top: 15, left: 15, right: 15),
              child: GridView.count(
                childAspectRatio: (itemWidth / itemHeight),
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: List.generate(
                    widget.settingsResponse!.teamList!.length, (index) {
                  return InkWell(
                    onTap: () {

                      loggerNoStack.e('Menu :' + widget.settingsResponse!.teamList![index].menuCode!);

                      if (widget.settingsResponse!.teamList![index].menuCode == 'JOIN') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TeamJoinView()));
                      } else
                      if (widget
                              .settingsResponse!.teamList![index].menuCode ==
                          'MYTEAM') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TeamListView(
                                      settingsResponse: widget.settingsResponse,
                                    )));
                      } else if (widget
                              .settingsResponse!.teamList![index].menuCode ==
                          'USERKYC') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => KycTabsView()));
                      } else if (widget
                          .settingsResponse!.teamList![index].menuCode ==
                          'Job Post') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyPostedJobsListView()));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TeamFreelancerListView(
                                      title: widget.settingsResponse!
                                              .teamList![index].menuName ??
                                          '',
                                      code: widget.settingsResponse!
                                              .teamList![index].menuCode ??
                                          '',
                                      subMenuList: widget.settingsResponse!
                                          .teamList![index].subMenuList!,
                                    )));
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ColorViewConstants.colorWhite,
                      ),
                      padding: EdgeInsets.only(
                          top: screenHeight * 0.03,
                          bottom: screenHeight * 0.02,
                          left: screenHeight * 0.01,
                          right: screenHeight * 0.01),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            widget.settingsResponse?.teamList![index]
                                    .menuIconPath ??
                                '',
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            widget.settingsResponse?.teamList![index]
                                    .menuName ??
                                '',
                            style: AppTextStyles.medium.copyWith(
                              fontSize: 12,
                              color: ColorViewConstants.colorLightBlack,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
