import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/model/request/job_request.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/view/common/widget_loader.dart';
import 'package:vgo_flutter_app/src/view_model/jobs_view_model.dart';

import '../../../constants/color_view_constants.dart';
import '../../../constants/string_view_constants.dart';
import '../../../model/job.dart';
import '../../../session/session_manager.dart';
import '../../../utils/app_date_utils.dart';
import '../../../utils/utils.dart';
import '../../common/no_data_found.dart';

class AllJobsListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AllJobListState();
}

class AllJobListState extends State<AllJobsListView> {
  bool showProgressCircle = false;
  String username = '';

  List<Job> jobList = [];

  void callGetAllJobOrdersList() {
    setState(() {
      showProgressCircle = true;
    });

    JobsViewModel.instance.callGetAllJobOrdersApi(username,
        completion: (response) {
      setState(() {
        showProgressCircle = false;

        if (response!.success ?? true) {
          jobList = response.jobList!;
        } else {
          loggerNoStack.e('message : ' + response.message!);
        }
      });
    });
  }

  void callAcceptJobOrdersList(String jobId) {
    setState(() {
      showProgressCircle = true;
    });

    final JobRequest request =
        JobRequest(username: username, job_status: 'Accept');

    JobsViewModel.instance.callAcceptJobOrdersApi(jobId, request,
        completion: (response) {
      setState(() {
        showProgressCircle = false;

        if (response!.success ?? true) {
          callGetAllJobOrdersList();
        } else {
          loggerNoStack.e('message : ' + response.message!);
        }
      });
    });
  }

  void showAlert(final String jobId) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.confirm,
        text: 'Do you want to accept the Job?',
        confirmBtnText: StringViewConstants.yes,
        cancelBtnText: StringViewConstants.no,
        confirmBtnColor: ColorViewConstants.colorBlueSecondaryText,
        onConfirmBtnTap: () {
          callAcceptJobOrdersList(jobId);
        },
        onCancelBtnTap: () {

        });
  }


  @override
  void initState() {
    super.initState();
    SessionManager.getUserName().then((value) {
      username = value!;
      loggerNoStack.e('username :${username}');
      callGetAllJobOrdersList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
        children: [
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
              Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: jobList.length,
                      itemBuilder: (context, position) {
                        return Container(
                          color: ColorViewConstants.colorWhite,
                          margin:
                              EdgeInsets.only(left: 0, right: 0, bottom: 10),
                          padding: EdgeInsets.only(
                              left: 10, right: 10, bottom: 15, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Image.asset(
                                        "assets/images/jobs/ic_jobs_placeholder.png",
                                        width: 40,
                                        height: 40,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        jobList[position].job_title ?? '',
                                        style: AppTextStyles.medium.copyWith(
                                            fontSize: 14,
                                            color: ColorViewConstants
                                                .colorPrimaryText),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    jobList[position].industry ?? '',
                                    style: AppTextStyles.medium.copyWith(
                                        fontSize: 14,
                                        color: ColorViewConstants
                                            .colorPrimaryTextHint),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    jobList[position].job_desc ?? '',
                                    style: AppTextStyles.medium.copyWith(
                                        fontSize: 14,
                                        color: ColorViewConstants
                                            .colorPrimaryTextHint),
                                  ),
                                  Visibility(
                                      visible: jobList[position]
                                          .category
                                          .toString()
                                          .isNotEmpty,
                                      child: SizedBox(
                                        height: 15,
                                      )),
                                  Visibility(
                                      visible: jobList[position]
                                          .category
                                          .toString()
                                          .isNotEmpty,
                                      child: Text(
                                        jobList[position].category ?? '',
                                        style: AppTextStyles.medium.copyWith(
                                            fontSize: 14,
                                            color: ColorViewConstants
                                                .colorPrimaryTextHint),
                                      ))
                                ],
                              )),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    AppDateUtils.getTimeAgo(
                                        jobList[position].created_at!,
                                        jobList[position].updated_at!),
                                    style: AppTextStyles.medium.copyWith(
                                        fontSize: 13,
                                        color: ColorViewConstants
                                            .colorPrimaryOpacityText80),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  MaterialButton(
                                    height: screenHeight * 0.05,
                                    minWidth: screenWidth * 0.23,
                                    color: ColorViewConstants
                                        .colorBlueSecondaryDarkText,
                                    onPressed: () {
                                      showAlert(jobList[position].id.toString());
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Text(
                                      'ACCEPT',
                                      style: AppTextStyles.medium.copyWith(
                                          fontSize: 14,
                                          color: ColorViewConstants.colorWhite),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      }))
            ],
          )),
          widgetLoader(context, showProgressCircle),
          Visibility(
              visible: !showProgressCircle &&
                  jobList.length == 0 ,
              child: widgetNoDataFound(context,
                  message: 'New jobs are not available at this movement. Please try again after sometime!'))
    ]);
  }
}
