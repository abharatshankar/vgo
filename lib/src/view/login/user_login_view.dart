import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/model/request/mobile_number_request.dart';
import 'package:vgo_flutter_app/src/utils/toast_utils.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';
import 'package:vgo_flutter_app/src/view/common/widget_loader.dart';
import 'package:vgo_flutter_app/src/view/services/transfer/transfer_phone_number_widget.dart';
import 'package:vgo_flutter_app/src/view_model/login_view_model.dart';

import '../../constants/string_view_constants.dart';
import '../../model/country.dart';
import '../../utils/app_text_style.dart';
import '../account/otp_verification_view.dart';
import '../register/user_register_view.dart';
import 'dart:io';

class UserLoginView extends StatefulWidget {
   UserLoginView({super.key});

   List<Country>? countryList = [];

  @override
  State<UserLoginView> createState() => UserLoginState();
}

class UserLoginState extends State<UserLoginView> {

  final numberController = TextEditingController();

  bool showProgressCircle = false;
  int closeAppClick = 0;

  var country = Country(countryIconPath: 'https://vgopay.in/icons/IND_Icon.png', countryCode: '+91', currencyCode: 'INR');

  @override
  void initState() {
    super.initState();
    callCountryListApi();
  }

  // Get country list
  void callCountryListApi() {
    LoginViewModel.instance.apiCountryList(completion: (response) {
      setState(() {
        widget.countryList = response!.countryList!;
        country = widget.countryList![1];
      });
    });
  }

  Future<bool> _onWillPop() async {
    closeAppClick++;
    if (closeAppClick == 2) {
      exit(0);
    } else {
      ToastUtils.instance.showToast("Please press back again to close the app.",
          context: context, isError: false, bg: ColorViewConstants.colorYellow);
    }

    Future.delayed(const Duration(seconds: 5), () {
      closeAppClick = 0;
    });

    return false;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Validate login form
    void validateLogin() {
      final MobileNumberRequest request =
          MobileNumberRequest(mobileNumber: numberController.text);

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
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OtpVerificationView(
                          number: numberController.text.toString(),
                        )),
              );
            } else {
              ToastUtils.instance.showToast(response!.message!,
                  context: context, isError: true);
            }
          });
        } else {
          ToastUtils.instance
              .showToast(message!, context: context, isError: true);
        }
      });
    }


    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          backgroundColor: ColorViewConstants.colorWhite,
          appBar: AppBar(
            backgroundColor: ColorViewConstants.colorBlueSecondaryText,
            toolbarHeight: 0,
          ),
          bottomNavigationBar: BottomAppBar(
            color: ColorViewConstants.colorWhite,
            elevation: 0,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(StringViewConstants.haveAccount,
                          style: AppTextStyles.medium.copyWith(
                              fontSize: 16,
                              color: ColorViewConstants.colorHintGray)),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserRegisterView()),
                          );
                        },
                        child: Text(
                          StringViewConstants.createAccount,
                          style: AppTextStyles.medium.copyWith(
                              fontSize: 16,
                              color: ColorViewConstants.colorBlueSecondaryText),
                        ),
                      )
                    ],
                  ),
                )),
          ),
          body: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.asset(
                              'assets/images/login/vgo_login.jpg',
                              height: screenWidth * 0.7,
                              width: screenHeight * 0.7,
                            ),
                            Text(
                              StringViewConstants.welcome,
                              style:
                              AppTextStyles.semiBold.copyWith(fontSize: 18),
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Text(
                              StringViewConstants.welcomeDesc,
                              style: AppTextStyles.regular.copyWith(
                                  fontSize: 16,
                                  color: ColorViewConstants.colorGray),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: screenHeight * 0.03,
                            ),
                            Text(
                              StringViewConstants.phoneNumber,
                              style: AppTextStyles.medium.copyWith(
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            widgetTransferPhoneNumber(
                                context,
                                country,
                                widget.countryList,
                                numberController,
                                TextInputAction.done,
                                StringViewConstants.mobileNumber,
                                false,
                                false,
                                0.52,
                                completion: (value) {
                                  setState(() {
                                    loggerNoStack.e( StringViewConstants.countryCode + value.countryCode!);
                                    country = value;
                                  });
                                }),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            MaterialButton(
                              height: screenHeight * 0.06,
                              color: ColorViewConstants.colorBlueSecondaryText,
                              minWidth: screenWidth,
                              onPressed: () {
                                validateLogin();
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                StringViewConstants.proceed,
                                style: AppTextStyles.semiBold.copyWith(
                                    fontSize: 16,
                                    color: ColorViewConstants.colorWhite),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  TextSpan(
                                      text:
                                      StringViewConstants.byProviding,
                                      style: AppTextStyles.regular.copyWith(
                                          color: ColorViewConstants.colorHintGray,
                                          height: 1.5,
                                          fontSize: 15)),
                                  TextSpan(
                                      text: StringViewConstants.termsOfService,
                                      style: AppTextStyles.medium.copyWith(
                                          color: ColorViewConstants
                                              .colorBlueSecondaryText,
                                          fontSize: 15)),
                                  TextSpan(
                                      text: StringViewConstants.and,
                                      style: AppTextStyles.regular.copyWith(
                                          color: ColorViewConstants.colorHintGray,
                                          height: 1.5,
                                          fontSize: 15)),
                                  TextSpan(
                                      text: StringViewConstants.privacyPolicy,
                                      style: AppTextStyles.medium.copyWith(
                                          color: ColorViewConstants
                                              .colorBlueSecondaryText,
                                          fontSize: 15)),
                                  TextSpan(
                                      text: StringViewConstants.inUseOfTheVgoApplication,
                                      style: AppTextStyles.regular.copyWith(
                                          color: ColorViewConstants.colorHintGray,
                                          height: 1.5,
                                          fontSize: 15)),
                                ])),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              widgetLoader(context, showProgressCircle)
            ],
          ))
    );

  }
}
