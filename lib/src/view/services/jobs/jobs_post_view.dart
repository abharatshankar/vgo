import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/model/request/job_request.dart';
import 'package:vgo_flutter_app/src/session/session_manager.dart';
import 'package:vgo_flutter_app/src/view/common/widget_loader.dart';
import 'package:vgo_flutter_app/src/view_model/jobs_view_model.dart';

import '../../../utils/app_box_decoration.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/toast_utils.dart';
import '../../../utils/utils.dart';
import '../../common/common_tool_bar_transfer.dart';

class JobsPostView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => JobsPostState();
}

class JobsPostState extends State<JobsPostView> {
  bool showProgressCircle = false;

  String gapId = '';
  String username = '';

  final companyController = TextEditingController();
  final titleController = TextEditingController();
  final industryController = TextEditingController();
  final keySkillsController = TextEditingController();
  final descriptionController = TextEditingController();
  final budgetController = TextEditingController();

  void validateExperience() {
    JobRequest request = JobRequest(
      company_name: companyController.text,
      job_title: titleController.text,
      industry: industryController.text,
      key_skills: keySkillsController.text,
      job_desc: descriptionController.text,
      budget_amount: budgetController.text,
      username: username,
      job_status: 'New',
    );

    JobsViewModel.instance.createJobValidate(request,
        completion: (message, isValid) {
      if (isValid) {
        setState(() {
          showProgressCircle = true;
        });
        JobsViewModel.instance.callCreateJobOrderApi(request,
            completion: (response) {
          setState(() {
            showProgressCircle = false;

            if (response!.success ?? true) {
              Navigator.pop(context, true);
            } else {
              ToastUtils.instance.showToast(response.message!,
                  context: context, isError: true);
            }
          });
        });
      } else {
        ToastUtils.instance
            .showToast(message!, context: context, isError: true);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    SessionManager.getGapID().then((value) {
      gapId = value!;
      loggerNoStack.e('gapId :${gapId}');
    });

    SessionManager.getUserName().then((value) {
      username = value!;
      loggerNoStack.e('username :${username}');
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Scaffold(
            backgroundColor: ColorViewConstants.colorHintBlue,
            appBar: AppBar(
              toolbarHeight: 0,
              backgroundColor: ColorViewConstants.colorBlueSecondaryText,
            ),
            bottomNavigationBar: BottomAppBar(
              color: ColorViewConstants.colorWhite,
              elevation: 0,
              child: MaterialButton(
                height: screenHeight * 0.06,
                color: ColorViewConstants.colorBlueSecondaryText,
                minWidth: screenWidth,
                onPressed: () {
                  validateExperience();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'Submit',
                  style: AppTextStyles.semiBold.copyWith(
                      fontSize: 16, color: ColorViewConstants.colorWhite),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                toolBarTransferWidget(context, "NEW JOB POST", false,
                    isBack: true),
                Expanded(
                    child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 30, bottom: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Organization/Company Name',
                                  style: AppTextStyles.regular.copyWith(
                                      color: ColorViewConstants
                                          .colorPrimaryOpacityText80,
                                      fontSize: 14)),
                              TextSpan(
                                  text: ' *',
                                  style: AppTextStyles.medium.copyWith(
                                      color: ColorViewConstants.colorRed,
                                      fontSize: 14)),
                            ])),
                        SizedBox(height: screenHeight * 0.02),
                        Container(
                          width: screenWidth * 0.92,
                          height: screenHeight * 0.06,
                          decoration: BoxDecoration(
                            color: ColorViewConstants.colorTransferGray,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: TextField(
                              controller: companyController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintStyle: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color:
                                      ColorViewConstants.colorPrimaryTextHint,
                                ),
                                enabledBorder: AppBoxDecoration.noInputBorder,
                                focusedBorder: AppBoxDecoration.noInputBorder,
                                border: AppBoxDecoration.noInputBorder,
                              ),
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorPrimaryText),
                              onChanged: (value) {},
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Job Title',
                                  style: AppTextStyles.regular.copyWith(
                                      color: ColorViewConstants
                                          .colorPrimaryOpacityText80,
                                      fontSize: 14)),
                              TextSpan(
                                  text: ' *',
                                  style: AppTextStyles.medium.copyWith(
                                      color: ColorViewConstants.colorRed,
                                      fontSize: 14)),
                            ])),
                        SizedBox(height: screenHeight * 0.02),
                        Container(
                          width: screenWidth * 0.92,
                          height: screenHeight * 0.06,
                          decoration: BoxDecoration(
                            color: ColorViewConstants.colorTransferGray,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: TextField(
                              controller: titleController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintStyle: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color:
                                      ColorViewConstants.colorPrimaryTextHint,
                                ),
                                enabledBorder: AppBoxDecoration.noInputBorder,
                                focusedBorder: AppBoxDecoration.noInputBorder,
                                border: AppBoxDecoration.noInputBorder,
                              ),
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorPrimaryText),
                              onChanged: (value) {},
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Industry',
                                  style: AppTextStyles.regular.copyWith(
                                      color: ColorViewConstants
                                          .colorPrimaryOpacityText80,
                                      fontSize: 14)),
                              TextSpan(
                                  text: ' *',
                                  style: AppTextStyles.medium.copyWith(
                                      color: ColorViewConstants.colorRed,
                                      fontSize: 14)),
                            ])),
                        SizedBox(height: screenHeight * 0.02),
                        Container(
                          width: screenWidth * 0.92,
                          height: screenHeight * 0.06,
                          decoration: BoxDecoration(
                            color: ColorViewConstants.colorTransferGray,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: TextField(
                              controller: industryController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintStyle: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color:
                                      ColorViewConstants.colorPrimaryTextHint,
                                ),
                                enabledBorder: AppBoxDecoration.noInputBorder,
                                focusedBorder: AppBoxDecoration.noInputBorder,
                                border: AppBoxDecoration.noInputBorder,
                              ),
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorPrimaryText),
                              onChanged: (value) {},
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Key Skills',
                                  style: AppTextStyles.regular.copyWith(
                                      color: ColorViewConstants
                                          .colorPrimaryOpacityText80,
                                      fontSize: 14)),
                              TextSpan(
                                  text: ' *',
                                  style: AppTextStyles.medium.copyWith(
                                      color: ColorViewConstants.colorRed,
                                      fontSize: 14)),
                            ])),
                        SizedBox(height: screenHeight * 0.02),
                        Container(
                          width: screenWidth * 0.92,
                          height: screenHeight * 0.06,
                          decoration: BoxDecoration(
                            color: ColorViewConstants.colorTransferGray,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: TextField(
                              controller: keySkillsController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintStyle: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color:
                                      ColorViewConstants.colorPrimaryTextHint,
                                ),
                                enabledBorder: AppBoxDecoration.noInputBorder,
                                focusedBorder: AppBoxDecoration.noInputBorder,
                                border: AppBoxDecoration.noInputBorder,
                              ),
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorPrimaryText),
                              onChanged: (value) {},
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Job Description',
                                  style: AppTextStyles.regular.copyWith(
                                      color: ColorViewConstants
                                          .colorPrimaryOpacityText80,
                                      fontSize: 14)),
                              TextSpan(
                                  text: ' *',
                                  style: AppTextStyles.medium.copyWith(
                                      color: ColorViewConstants.colorRed,
                                      fontSize: 14)),
                            ])),
                        SizedBox(height: screenHeight * 0.02),
                        Container(
                          width: screenWidth * 0.92,
                          height: screenHeight * 0.06,
                          decoration: BoxDecoration(
                            color: ColorViewConstants.colorTransferGray,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: TextField(
                              controller: descriptionController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintStyle: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color:
                                      ColorViewConstants.colorPrimaryTextHint,
                                ),
                                enabledBorder: AppBoxDecoration.noInputBorder,
                                focusedBorder: AppBoxDecoration.noInputBorder,
                                border: AppBoxDecoration.noInputBorder,
                              ),
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorPrimaryText),
                              onChanged: (value) {},
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Budget Amount',
                                  style: AppTextStyles.regular.copyWith(
                                      color: ColorViewConstants
                                          .colorPrimaryOpacityText80,
                                      fontSize: 14)),
                              TextSpan(
                                  text: ' *',
                                  style: AppTextStyles.medium.copyWith(
                                      color: ColorViewConstants.colorRed,
                                      fontSize: 14)),
                            ])),
                        SizedBox(height: screenHeight * 0.02),
                        Container(
                          width: screenWidth * 0.92,
                          height: screenHeight * 0.06,
                          decoration: BoxDecoration(
                            color: ColorViewConstants.colorTransferGray,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: TextField(
                              controller: budgetController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                hintStyle: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color:
                                      ColorViewConstants.colorPrimaryTextHint,
                                ),
                                enabledBorder: AppBoxDecoration.noInputBorder,
                                focusedBorder: AppBoxDecoration.noInputBorder,
                                border: AppBoxDecoration.noInputBorder,
                              ),
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorPrimaryText),
                              onChanged: (value) {},
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
              ],
            )),
        widgetLoader(context, showProgressCircle)
      ],
    );
  }
}
