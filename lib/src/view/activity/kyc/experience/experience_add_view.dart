import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/model/request/kyc/experience_request.dart';
import 'package:vgo_flutter_app/src/session/session_manager.dart';
import 'package:vgo_flutter_app/src/view/common/widget_loader.dart';
import 'package:vgo_flutter_app/src/view_model/kyc_view_model.dart';

import '../../../../utils/app_box_decoration.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/toast_utils.dart';
import '../../../../utils/utils.dart';
import '../../../common/common_tool_bar_transfer.dart';

class ExperienceAddView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ExperienceViewState();
}

class ExperienceViewState extends State<ExperienceAddView> {
  bool showProgressCircle = false;

  String gapId = '';

  final companyController = TextEditingController();
  final designationController = TextEditingController();
  final departmentController = TextEditingController();
  final workingPeriodController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final postelCodeController = TextEditingController();

  void validateExperience() {
    ExperienceRequest request = ExperienceRequest(
        orgCompany: companyController.text,
        desig: designationController.text,
        dept: departmentController.text,
        workingYears: workingPeriodController.text,
        cityTown: cityController.text,
        state: stateController.text,
        country: countryController.text,
        currentLocation: cityController.text,
        postalCode: int.parse(postelCodeController.text),
        latLocation: '10.1001',
        lngLocation: '10.1001',
        gapId: gapId);

    KycViewModel.instance.experienceValidate(request,
        completion: (message, isValid) {
      if (isValid) {
        setState(() {
          showProgressCircle = true;
        });
        KycViewModel.instance.callCreateExperience(request,
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
                toolBarTransferWidget(context, "ADD EXPERIENCE", false,
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
                                  text: 'Organization/ Company',
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
                                  text: 'Designation',
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
                              controller: designationController,
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
                                  text: 'Department',
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
                              controller: departmentController,
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
                                  text: 'Working Period',
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
                              controller: workingPeriodController,
                              keyboardType: TextInputType.number,
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
                                  text: 'City/Town',
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
                              controller: cityController,
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
                                  text: 'Postel Code',
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
                              controller: postelCodeController,
                              keyboardType: TextInputType.number,
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
                                  text: 'State',
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
                              controller: stateController,
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
                                  text: 'Country',
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
                              textInputAction: TextInputAction.done,
                              controller: countryController,
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
