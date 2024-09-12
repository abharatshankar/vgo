import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/model/request/create_team_request.dart';
import 'package:vgo_flutter_app/src/session/session_manager.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';
import 'package:vgo_flutter_app/src/view_model/services_view_model.dart';

import '../../constants/color_view_constants.dart';
import '../../utils/app_box_decoration.dart';
import '../../utils/app_text_style.dart';
import '../../utils/toast_utils.dart';
import '../common/common_tool_bar_transfer.dart';
import '../common/widget_loader.dart';

class TeamJoinView extends StatefulWidget {
  @override
  State<TeamJoinView> createState() => TeamJoinViewState();
}

class TeamJoinViewState extends State<TeamJoinView> {
  bool showProgressCircle = false;

  final nameController = TextEditingController();

  String gapId = '';

  validateAddTeam() {
    final CreateTeamRequest request =
        CreateTeamRequest(input_gap_id: nameController.text, resp_gap_id: gapId);
    ServicesViewModel.instance.validateAddTeam(request, context,
        completion: (message, isValid) {
      if (isValid) {
        ServicesViewModel.instance.callCreateTeam(request,
            completion: (response) {
          if (response!.success ?? true) {
            ToastUtils.instance.showToast(response.message!,
                context: context,
                isError: true,
                bg: ColorViewConstants.colorGreen);
          } else {
            ToastUtils.instance
                .showToast(response.message!, context: context, isError: true);
          }
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
    SessionManager.getGapID().then((value){
         gapId = value!;
         loggerNoStack.e('gapId : ' + gapId );
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
        body: Stack(children: [
          widgetLoader(context, showProgressCircle),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              toolBarTransferWidget(context, 'Join Team', false),
              Container(
                padding: EdgeInsets.all(screenWidth * 0.1),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Enter Gap ID',
                        hintStyle: AppTextStyles.regular.copyWith(
                          fontSize: 14,
                          color: ColorViewConstants.colorGray,
                        ),
                        enabledBorder: AppBoxDecoration.grayUnderlineBorder,
                        focusedBorder: AppBoxDecoration.grayUnderlineBorder,
                        border: AppBoxDecoration.grayUnderlineBorder,
                      ),
                      style: AppTextStyles.medium,
                      //  textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        MaterialButton(
                          height: screenHeight * 0.05,
                          minWidth: screenWidth * 0.38,
                          color: ColorViewConstants.colorHintRed,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          child: Text(
                            'CANCEL',
                            style: AppTextStyles.medium.copyWith(
                                fontSize: 14,
                                color: ColorViewConstants.colorWhite),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        MaterialButton(
                          height: screenHeight * 0.05,
                          minWidth: screenWidth * 0.38,
                          color: ColorViewConstants.colorBlueSecondaryDarkText,
                          onPressed: () {
                            validateAddTeam();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          child: Text(
                            'ADD',
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
              )
            ],
          ),
        ]));
  }
}
