import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/color_view_constants.dart';
import '../../../model/job.dart';
import '../../../model/request/job_request.dart';
import '../../../session/session_manager.dart';
import '../../../utils/app_box_decoration.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/toast_utils.dart';
import '../../../utils/utils.dart';
import '../../../view_model/jobs_view_model.dart';
import '../../common/common_tool_bar_transfer.dart';
import '../../common/widget_loader.dart';

class JobsLogsView extends StatefulWidget {
  const JobsLogsView({super.key, this.job, required this.userType});

  final Job? job;
  final String userType;

  @override
  State<StatefulWidget> createState() => JobsLogsState();
}

class JobsLogsState extends State<JobsLogsView> {
  bool showProgressCircle = false;
  String username = '';
  final commentsController = TextEditingController();

  List<Job> jobList = [];

  void callGetJobOrderLogsApi() {
    setState(() {
      showProgressCircle = true;
    });

    JobsViewModel.instance.callGetJobOrderLogsApi(
        widget.job!.job_id!.toString(), completion: (response) {
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

  void callCreateJobOrderLogsList() {
    setState(() {
      showProgressCircle = true;
    });

    final JobRequest request = JobRequest(
        job_id: widget.job!.job_id!,
        username: username,
        user_type: widget.userType,
        message: commentsController.text,
        status: 'Process');

    JobsViewModel.instance.callCreateJobOrderLogsApi(
        widget.job!.job_id!.toString(), request, completion: (response) {
      setState(() {
        showProgressCircle = false;

        if (response!.success ?? true) {
          commentsController.clear();
          callGetJobOrderLogsApi();
        } else {
          loggerNoStack.e('message : ' + response.message!);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    SessionManager.getUserName().then((value) {
      username = value!;
      loggerNoStack.e('username :${username}');
      callGetJobOrderLogsApi();
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
              toolBarTransferWidget(context, widget.job?.job_title ?? '', false,
                  isBack: true),
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
                          callCreateJobOrderLogsList();
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
      widgetLoader(context, showProgressCircle),
    ]);
  }
}
