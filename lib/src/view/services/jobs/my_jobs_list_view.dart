import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/view/services/jobs/jobs_logs_view.dart';

import '../../../constants/color_view_constants.dart';
import '../../../constants/string_view_constants.dart';
import '../../../model/job.dart';
import '../../../model/request/job_request.dart';
import '../../../session/session_manager.dart';
import '../../../utils/app_date_utils.dart';
import '../../../utils/utils.dart';
import '../../../view_model/jobs_view_model.dart';
import '../../common/no_data_found.dart';
import '../../common/widget_loader.dart';

class MyJobsListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyJobListState();
}

class MyJobListState extends State<MyJobsListView> {
  bool showProgressCircle = false;
  String username = '';

  List<Job> jobList = [];

  void callGetMyJobOrdersList() {
    setState(() {
      showProgressCircle = true;
    });

    JobsViewModel.instance.callGetMyJobOrdersApi(username,
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

  void callJobStatusUpdate(String jobId, String status) {
    setState(() {
      showProgressCircle = true;
    });

    final JobRequest request = JobRequest(
        username: username,
        job_status: status,
        user_type: 'Receiver',
        message: 'Some message');

    JobsViewModel.instance.callAcceptJobOrdersApi(jobId, request,
        completion: (response) {
      setState(() {
        showProgressCircle = false;

        if (response!.success ?? true) {
          callGetMyJobOrdersList();
        } else {
          loggerNoStack.e('message : ' + response.message!);
        }
      });
    });
  }

  void showAlert(
      final String jobId, final String alertMessage, final String status) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.confirm,
        text: alertMessage,
        confirmBtnText: StringViewConstants.yes,
        cancelBtnText: StringViewConstants.no,
        confirmBtnColor: ColorViewConstants.colorBlueSecondaryText,
        onConfirmBtnTap: () {
          callJobStatusUpdate(jobId, status);
        },
        onCancelBtnTap: () {});
  }

  @override
  void initState() {
    super.initState();
    SessionManager.getUserName().then((value) {
      username = value!;
      loggerNoStack.e('username :${username}');
      callGetMyJobOrdersList();
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
              Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: jobList.length,
                      itemBuilder: (context, position) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JobsLogsView(
                                          job: jobList[position],
                                          userType: 'Freelancer',
                                        )));
                          },
                          child: Container(
                            color: ColorViewConstants.colorWhite,
                            margin:
                                EdgeInsets.only(left: 0, right: 0, bottom: 10),
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 15, top: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                        child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                              style: AppTextStyles.medium
                                                  .copyWith(
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
                                                .isEmpty,
                                            child: SizedBox(
                                              height: 15,
                                            )),
                                        Visibility(
                                            visible: jobList[position]
                                                .category
                                                .toString()
                                                .isEmpty,
                                            child: Text(
                                              jobList[position].category ?? '',
                                              style: AppTextStyles.medium
                                                  .copyWith(
                                                      fontSize: 14,
                                                      color: ColorViewConstants
                                                          .colorPrimaryTextHint),
                                            ))
                                      ],
                                    )),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
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
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Visibility(
                                        visible: jobList[position]
                                                .job_status
                                                .toString() !=
                                            'Done',
                                        child: MaterialButton(
                                          height: screenHeight * 0.04,
                                          minWidth: screenWidth * 0.2,
                                          color: ColorViewConstants
                                              .colorBlueSecondaryDarkText,
                                          onPressed: () {
                                            showAlert(
                                                jobList[position]
                                                    .job_id
                                                    .toString(),
                                                'Do you want to delivery the Job?',
                                                'Delivery');
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: Text(
                                            'DELIVERY',
                                            style: AppTextStyles.medium
                                                .copyWith(
                                                    fontSize: 14,
                                                    color: ColorViewConstants
                                                        .colorWhite),
                                            textAlign: TextAlign.center,
                                          ),
                                        )),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Visibility(
                                        visible: jobList[position]
                                                .job_status
                                                .toString() !=
                                            'Done',
                                        child: MaterialButton(
                                          height: screenHeight * 0.04,
                                          minWidth: screenWidth * 0.2,
                                          color: ColorViewConstants
                                              .colorBlueSecondaryDarkText,
                                          onPressed: () {
                                            showAlert(
                                                jobList[position]
                                                    .job_id
                                                    .toString(),
                                                'Do you want to cancel the Job?',
                                                'Cancel');
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: Text(
                                            'CANCEL',
                                            style: AppTextStyles.medium
                                                .copyWith(
                                                    fontSize: 14,
                                                    color: ColorViewConstants
                                                        .colorWhite),
                                            textAlign: TextAlign.center,
                                          ),
                                        )),
                                    Visibility(
                                        visible: jobList[position]
                                                .job_status
                                                .toString() ==
                                            'Done',
                                        child: MaterialButton(
                                          height: screenHeight * 0.04,
                                          minWidth: screenWidth * 0.2,
                                          color: ColorViewConstants
                                              .colorGreen,
                                          onPressed: () {},
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: Text(
                                            'DONE',
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
