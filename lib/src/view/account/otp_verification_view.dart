import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/model/request/otp_request.dart';
import 'package:vgo_flutter_app/src/model/user.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';
import 'package:vgo_flutter_app/src/view_model/otp_view_model.dart';

import '../../constants/string_view_constants.dart';
import '../../model/request/mobile_number_request.dart';
import '../../model/response/settings_response.dart';
import '../../session/session_manager.dart';
import '../../utils/app_text_style.dart';
import '../../utils/toast_utils.dart';
import '../../view_model/login_view_model.dart';
import '../../view_model/services_view_model.dart';
import '../bottom/bottom_navigation_view.dart';
import '../common/widget_loader.dart';

class OtpVerificationView extends StatefulWidget {
  const OtpVerificationView({super.key, this.number});

  final String? number;

  @override
  State<OtpVerificationView> createState() => OtpVerificationState();
}

class OtpVerificationState extends State<OtpVerificationView> {
  bool showProgressCircle = false;

  OtpFieldController otpController = OtpFieldController();

  var otpValue = '';
  SettingsResponse? settingsResponse;

  @override
  void initState() {
    super.initState();
    callSettingsConfigApi();
  }

  void callSettingsConfigApi() {
    ServicesViewModel.instance.callSettingsConfig(completion: (response) {
      setState(() {
        settingsResponse = response;
      });
    });
  }

  void validateOTP() {
    final OTPRequest request =
        OTPRequest(mobileNumber: widget.number, otp: otpValue);

    OTPViewModel.instance.doOTPValidate(request, context,
        completion: (message, isValidForm) {
      if (isValidForm) {
        setState(() {
          showProgressCircle = true;
        });

        OTPViewModel.instance.doOTPAuthenticateAPI(request,
            completion: (response) {
          setState(() {
            showProgressCircle = false;
          });

          if (response!.success ?? true) {
            final MobileNumberRequest mobileNumberRequest =
                MobileNumberRequest(mobileNumber: widget.number);

            LoginViewModel.instance.callUserExistsOrNot(mobileNumberRequest,
                completion: (response) {
              if (response!.success ?? true) {

                final User? user = response.user;
                SessionManager.setUserName(user?.username);
                SessionManager.setMobileNumber(user?.mobileNumber);
                SessionManager.setFirstName(user?.firstName);
                SessionManager.setLastName(user?.lastName);
                SessionManager.setCountryCode(user?.countryCode);
                SessionManager.setCurrency(user?.currency);
                SessionManager.setGapID(user?.gapId);
                SessionManager.setProfession(user?.profession);

                //BottomNavigationView(currentIndex: 0,)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomNavigationView(currentIndex: 0,)),
                );
              } else {
                loggerNoStack.e('response : ${response.message}');
              }
            });
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

  // Validate login form
  void resendOTP() {
    final MobileNumberRequest request =
        MobileNumberRequest(mobileNumber: widget.number);

    LoginViewModel.instance.doLoginValidate(request, context,
        completion: (message, isValidForm) {
      if (isValidForm) {
        setState(() {
          showProgressCircle = true;
        });

        LoginViewModel.instance.doLoginAPI(request, completion: (response) {
          setState(() {
            showProgressCircle = false;
          });

          if (response!.success ?? true) {
            ToastUtils.instance.showToast(response!.message!,
                context: context,
                isError: false,
                bg: ColorViewConstants.colorGreen);
          } else {
            ToastUtils.instance
                .showToast(response!.message!, context: context, isError: true);
          }
        });
      } else {
        ToastUtils.instance
            .showToast(message!, context: context, isError: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: ColorViewConstants.colorWhite,
        appBar: AppBar(
          backgroundColor: ColorViewConstants.colorBlueSecondaryText,
          toolbarHeight: 0,
        ),
        bottomNavigationBar: BottomAppBar(
          color: ColorViewConstants.colorWhite,
          elevation: 0,
          child: MaterialButton(
            height: screenHeight * 0.06,
            color: ColorViewConstants.colorBlueSecondaryText,
            minWidth: screenWidth,
            onPressed: () {
              validateOTP();
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Text(
              'Continue',
              style: AppTextStyles.semiBold
                  .copyWith(fontSize: 16, color: ColorViewConstants.colorWhite),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 10, top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_outlined,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                      width: screenWidth,
                      child: Text(
                        textAlign: TextAlign.center,
                        StringViewConstants.accountVerification,
                        style: AppTextStyles.medium.copyWith(fontSize: 24),
                      )),
                  SizedBox(
                    height: screenHeight * 0.06,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: screenWidth * 0.75,
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                                text:
                                    StringViewConstants.accountVerificationDesc,
                                style: AppTextStyles.regular.copyWith(
                                    color: ColorViewConstants.colorHintGray,
                                    height: 1.5,
                                    fontSize: 16)),
                            TextSpan(
                                text: "+91 ${widget.number}",
                                style: AppTextStyles.medium.copyWith(
                                    color: ColorViewConstants
                                        .colorBlueSecondaryText,
                                    height: 1.5,
                                    fontSize: 16)),
                            TextSpan(
                                text: StringViewConstants
                                    .pleaseEnterAndVerifyAccount,
                                style: AppTextStyles.regular.copyWith(
                                    color: ColorViewConstants.colorHintGray,
                                    fontSize: 16)),
                          ])),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  OTPTextField(
                      controller: otpController,
                      width: screenWidth,
                      length: 6,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldWidth: 45,
                      fieldStyle: FieldStyle.underline,
                      outlineBorderRadius: 10,
                      style: AppTextStyles.medium.copyWith(
                          color: ColorViewConstants.colorBlueSecondaryText,
                          fontSize: 16),
                      onChanged: (pin) {
                        otpValue = pin;
                      },
                      onCompleted: (pin) {
                        otpValue = pin;
                      }),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(StringViewConstants.otpReceived,
                                style: AppTextStyles.medium.copyWith(
                                    fontSize: 16,
                                    color: ColorViewConstants.colorHintGray)),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                resendOTP();
                              },
                              child: Text(
                                StringViewConstants.resend,
                                style: AppTextStyles.medium.copyWith(
                                    fontSize: 16,
                                    color: ColorViewConstants
                                        .colorBlueSecondaryText),
                              ),
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ),
            widgetLoader(context, showProgressCircle)
          ],
        ));
  }
}
