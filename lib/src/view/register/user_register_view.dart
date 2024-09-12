import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vgo_flutter_app/src/model/request/registration_request.dart';
import 'package:vgo_flutter_app/src/utils/app_string_utils.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/utils/toast_utils.dart';
import 'package:vgo_flutter_app/src/view/common/widget_currency_drop_down.dart';
import 'package:vgo_flutter_app/src/view/login/user_login_view.dart';
import 'package:vgo_flutter_app/src/view_model/register_view_model.dart';
import 'package:vgo_flutter_app/src/view_model/services_view_model.dart';

import '../../constants/color_view_constants.dart';
import '../../constants/string_view_constants.dart';
import '../../model/country.dart';
import '../../utils/app_box_decoration.dart';
import '../../utils/utils.dart';
import '../../view_model/login_view_model.dart';
import '../services/transfer/transfer_phone_number_widget.dart';

class UserRegisterView extends StatefulWidget {
  const UserRegisterView({super.key});

  @override
  State<UserRegisterView> createState() => UserRegisterState();
}

class UserRegisterState extends State<UserRegisterView> {
  bool showProgressCircle = false;

  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  List<Country>? countryList = [];
  List<Country>? currencyList = [];


  @override
  void initState() {
    super.initState();

    callCountryListApi();
    callCurrencyListApi();
  }

  void callCountryListApi() {
    LoginViewModel.instance.apiCountryList(completion: (response) {
      setState(() {
        countryList = response!.countryList!;
        AppStringUtils.defaultCountry = countryList![1];
      });
    });
  }

  void callCurrencyListApi() {
    ServicesViewModel.instance.callGetCurrenciesList(completion: (response) {
      setState(() {
        currencyList = response!.currencyList!;
        AppStringUtils.defaultCurrency = currencyList![0].currencyCode!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Get country list

    doRegistration() {
      final RegistrationRequest request = RegistrationRequest(
          mobileNumber: numberController.text,
          firstName: fNameController.text,
          lastName: lNameController.text,
          countryCode: '+91',
          currency: 'INR',
          emailId: emailController.text,
          gapId: '',
          location: '',
          profession: '',
          userImagePath: '',
          userStatus: 'Active',
          userSubType: 'Non Loyalty',
          userType: 'Customer');

      RegisterViewModel.instance.doRegisterValidate(request, context,
          completion: (message, isValidForm) {
            if (isValidForm) {
          setState(() {
            showProgressCircle = true;
          });

          RegisterViewModel.instance.doRegistrationAPI(request,
              completion: (response) {

            setState(() {
              showProgressCircle = false;
            });

            if (response!.success ?? true) {
              /*    Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OtpVerificationView(
                            number: numberController.text,
                          )));*/

              ToastUtils.instance.showToast("Account created successfully!",
                  context: context,
                  isError: false,
                  bg: ColorViewConstants.colorGreen);

              Future.delayed(const Duration(seconds: 2), () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserLoginView()));
              });

            } else {
              ToastUtils.instance.showToast(response.message!,
                  context: context, isError: true);
            }
          });
        } else {
          ToastUtils.instance
              .showToast(message!, context: context, isError: true);
        }
      });
    }

    return Scaffold(
      backgroundColor: ColorViewConstants.colorWhite,
      appBar: AppBar(
        backgroundColor: ColorViewConstants.colorBlueSecondaryText,
        toolbarHeight: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
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
                  StringViewConstants.createNewAccount,
                  style: AppTextStyles.medium.copyWith(fontSize: 22),
                )),
            SizedBox(
              height: screenHeight * 0.005,
            ),
            SizedBox(
                width: screenWidth,
                child: Text(
                  textAlign: TextAlign.center,
                  StringViewConstants.PleaseFillTheFormToContinue,
                  style: AppTextStyles.medium.copyWith(
                      fontSize: 12,
                      color: ColorViewConstants.colorBlueSecondaryText),
                )),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 10, top: 10, bottom: 30),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  StringViewConstants.firstName,
                    style: AppTextStyles.regular.copyWith(
                        fontSize: 14, color: ColorViewConstants.colorDarkGray),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: ColorViewConstants.colorTransferGray,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: screenWidth,
                    child: TextField(
                      controller: fNameController,
                      keyboardType: TextInputType.name,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                      ],
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: '',
                        hintStyle: AppTextStyles.regular.copyWith(
                          fontSize: 14,
                          color: ColorViewConstants.colorGray,
                        ),
                        enabledBorder: AppBoxDecoration.noInputBorder,
                        focusedBorder: AppBoxDecoration.noInputBorder,
                        border: AppBoxDecoration.noInputBorder,
                      ),
                      style: AppTextStyles.medium,
                      //  textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Text(
                      StringViewConstants.lastName,
                    style: AppTextStyles.regular.copyWith(
                        fontSize: 14, color: ColorViewConstants.colorDarkGray),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: ColorViewConstants.colorTransferGray,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: screenWidth,
                    child: TextField(
                      controller: lNameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                      ],
                      decoration: InputDecoration(
                        hintText: '',
                        hintStyle: AppTextStyles.regular.copyWith(
                          fontSize: 14,
                          color: ColorViewConstants.colorGray,
                        ),
                        enabledBorder: AppBoxDecoration.noInputBorder,
                        focusedBorder: AppBoxDecoration.noInputBorder,
                        border: AppBoxDecoration.noInputBorder,
                      ),
                      style: AppTextStyles.medium,
                      //  textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Text(
                      StringViewConstants.phoneNumberRegister,
                    style: AppTextStyles.regular.copyWith(
                        fontSize: 14, color: ColorViewConstants.colorDarkGray),
                  ),
                  widgetTransferPhoneNumber(
                      context,
                      AppStringUtils.defaultCountry,
                      countryList,
                      numberController,
                      TextInputAction.next,
                      StringViewConstants.enterPhoneNumber,
                      false,
                      false,
                      0.5, completion: (value) {
                    setState(() {
                      loggerNoStack.e( StringViewConstants.countryCode + value.countryCode!);
                      AppStringUtils.defaultCountry = value;
                    });
                  }),
                  Text(
                    StringViewConstants.selectCurrency,
                    style: AppTextStyles.regular.copyWith(
                        fontSize: 14, color: ColorViewConstants.colorDarkGray),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Container(
                    width: screenWidth,
                    padding: const EdgeInsets.only(),
                    decoration: BoxDecoration(
                      color: ColorViewConstants.colorTransferGray,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: widgetCurrencyDropDown(
                        context, AppStringUtils.defaultCurrency, currencyList,
                        completion: (value) {}),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Text(
                    StringViewConstants.email,
                    style: AppTextStyles.regular.copyWith(
                        fontSize: 14, color: ColorViewConstants.colorDarkGray),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: ColorViewConstants.colorTransferGray,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: screenWidth,
                    child: TextField(
                      controller: emailController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: '',
                        hintStyle: AppTextStyles.regular.copyWith(
                          fontSize: 14,
                          color: ColorViewConstants.colorGray,
                        ),
                        enabledBorder: AppBoxDecoration.noInputBorder,
                        focusedBorder: AppBoxDecoration.noInputBorder,
                        border: AppBoxDecoration.noInputBorder,
                      ),
                      style: AppTextStyles.medium,
                      //  textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  MaterialButton(
                    height: screenHeight * 0.06,
                    color: ColorViewConstants.colorBlueSecondaryText,
                    minWidth: screenWidth,
                    onPressed: () {
                      doRegistration();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      StringViewConstants.createAccount,
                      style: AppTextStyles.semiBold.copyWith(
                          fontSize: 14, color: ColorViewConstants.colorWhite),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
