import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/view/services/jobs/jobs_logs_view.dart';
import 'package:vgo_flutter_app/src/view/services/jobs/jobs_post_view.dart';

import '../../../constants/color_view_constants.dart';
import '../../../constants/string_view_constants.dart';
import '../../../model/job.dart';
import '../../../model/request/job_request.dart';
import '../../../session/session_manager.dart';
import '../../../utils/app_date_utils.dart';
import '../../../utils/utils.dart';
import '../../../view_model/jobs_view_model.dart';
import '../../common/common_tool_bar_transfer.dart';
import '../../common/no_data_found.dart';
import '../../common/widget_loader.dart';

class MyPostedJobsListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyJobListState();
}

class MyJobListState extends State<MyPostedJobsListView> {
  bool showProgressCircle = false;
  String username = '';

  List<Job> jobList = [];

  void callGetMyPostedJobOrdersList() {
    setState(() {
      showProgressCircle = true;
    });

    JobsViewModel.instance.apiGetMyPostedJobOrders(username,
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

  void callCancelJobOrders(String jobId, String jobStatus) {
    setState(() {
      showProgressCircle = true;
    });

    String status = '';
    if (jobStatus == 'CONFIRM') {
      status = 'Confirm';
    } else if (jobStatus == 'JOB CLOSED') {
      status = 'Close';
    } else {
      status = 'Cancel';
    }

    final JobRequest request = JobRequest(
        username: username,
        job_status: status,
        user_type: 'Employer',
        message: 'Some message');

    JobsViewModel.instance.callAcceptJobOrdersApi(jobId, request,
        completion: (response) {
      setState(() {
        showProgressCircle = false;

        if (response!.success ?? true) {
          callGetMyPostedJobOrdersList();
        } else {
          loggerNoStack.e('message : ' + response.message!);
        }
      });
    });
  }

  void showAlert(final String jobId, String jobStatus) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.confirm,
        text: jobStatus == 'CONFIRM'
            ? 'Do you want to confirm the Job?'
            : 'Do you want to close the Job?',
        confirmBtnText: StringViewConstants.yes,
        cancelBtnText: StringViewConstants.no,
        confirmBtnColor: ColorViewConstants.colorBlueSecondaryText,
        onConfirmBtnTap: () {
          callCancelJobOrders(jobId, jobStatus);
        },
        onCancelBtnTap: () {});
  }

  @override
  void initState() {
    super.initState();
    SessionManager.getUserName().then((value) {
      username = value!;
      loggerNoStack.e('username :${username}');
      callGetMyPostedJobOrdersList();
    });
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
              toolBarTransferWidget(context, "My Posted Jobs", false,
                  isBack: true),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: MaterialButton(
                  height: screenHeight * 0.06,
                  color: ColorViewConstants.colorBlueSecondaryText,
                  minWidth: screenWidth * 0.9,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JobsPostView())).then((val) =>
                        val
                            ? callGetMyPostedJobOrdersList()
                            : callGetMyPostedJobOrdersList());
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Post New Job',
                    style: AppTextStyles.semiBold.copyWith(
                        fontSize: 16, color: ColorViewConstants.colorWhite),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: jobList.length,
                      itemBuilder: (context, position) {
                        String jobStatus = '';
                        Color color  = ColorViewConstants.colorBlueSecondaryDarkText;

                        if (jobList[position].job_status == 'Delivery') {
                          jobStatus = 'CONFIRM';
                          color  = ColorViewConstants.colorBlueSecondaryDarkText;
                        } else if (jobList[position].job_status == 'Close') {
                          jobStatus = 'JOB CLOSED';
                          color  = ColorViewConstants.colorHintRed;
                        } else if (jobList[position].job_status == 'Done') {
                          jobStatus = 'DONE';
                          color  = ColorViewConstants.colorGreen;
                        } else {
                          jobStatus = 'CLOSE JOB';
                        }

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JobsLogsView(
                                          job: jobList[position],
                                          userType: 'Employer',
                                        )));
                          },
                          child: Container(
                            color: jobList[position].job_status != 'Close'
                                ? ColorViewConstants.colorWhite
                                : ColorViewConstants.colorGrayOpacity,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                      jobList[position].key_skills ?? '',
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
                                          jobList[position].date!,
                                          jobList[position].date!),
                                      style: AppTextStyles.medium.copyWith(
                                          fontSize: 13,
                                          color: ColorViewConstants
                                              .colorPrimaryOpacityText80),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Rs : ' +
                                          jobList[position].budget_amount!,
                                      style: AppTextStyles.medium.copyWith(
                                          fontSize: 14,
                                          color: ColorViewConstants
                                              .colorBlueSecondaryDarkText),
                                    ),
                                    Visibility(
                                        visible: true,
                                        child: SizedBox(
                                          height: 10,
                                        )),
                                    Visibility(
                                        visible: true,
                                        child: MaterialButton(
                                          height: screenHeight * 0.04,
                                          minWidth: screenWidth * 0.23,
                                          color: color,
                                          onPressed: () {
                                            if(jobList[position].job_status == 'Done'
                                                || jobList[position].job_status == 'Close'){

                                            } else {
                                              showAlert(
                                                  jobList[position].job_id.toString(),
                                                  jobStatus);
                                            }
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: Text(
                                            jobStatus,
                                            style: AppTextStyles.medium
                                                .copyWith(
                                                    fontSize: 14,
                                                    color: ColorViewConstants
                                                        .colorWhite),
                                            textAlign: TextAlign.center,
                                          ),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }))
            ],
          )),
      widgetLoader(context, showProgressCircle),
      Visibility(
          visible: !showProgressCircle && jobList.length == 0,
          child: widgetNoDataFound(context,
              message:
                  'Jobs are not available at this movement. Please try again after sometime!'))
    ]);
  }
}
