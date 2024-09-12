import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/view/common/common_tool_bar_white.dart';

import '../../constants/color_view_constants.dart';
import '../../model/country.dart';
import '../../utils/app_box_decoration.dart';
import '../../utils/utils.dart';
import '../services/transfer/transfer_phone_number_widget.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => EditProfileViewState();
}

class EditProfileViewState extends State<EditProfileView> {
  bool showProgressCircle = false;

  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final locationController = TextEditingController();

  var country = Country(
      countryIconPath: 'https://vgopay.in/icons/IND_Icon.png',
      countryCode: '+91',
      currencyCode: 'INR');

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
    body: SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            toolBarTransferWhiteWidget(
              context,
              StringViewConstants.editProfile,
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Center(
              child: Image.asset('assets/images/service/user_avatar.png'),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
           Center(
           child: Text(
               StringViewConstants.uploadPhoto,
               style: AppTextStyles.regular.copyWith(
                   fontSize: 16, color: ColorViewConstants.colorDarkGray),
             ),
           ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Text(
              StringViewConstants.firstNameEdit,
              style: AppTextStyles.regular.copyWith(
                  fontSize: 16, color: ColorViewConstants.colorDarkGray),
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
                    fontSize: 16,
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
              StringViewConstants.lastNameEdit,
              style: AppTextStyles.regular.copyWith(
                  fontSize: 16, color: ColorViewConstants.colorDarkGray),
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
                      fontSize: 16,
                      color: ColorViewConstants.colorGray,
                    ),
                    enabledBorder: AppBoxDecoration.noInputBorder,
                    focusedBorder: AppBoxDecoration.noInputBorder,
                    border: AppBoxDecoration.noInputBorder,
                  ),
                  style: AppTextStyles.medium,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Text(
                  StringViewConstants.phoneNumber,
                style: AppTextStyles.regular.copyWith(
                    fontSize: 16, color: ColorViewConstants.colorDarkGray),
              ),
              widgetTransferPhoneNumber(
                  context,
                  country,
                  null,
                  numberController,
                  TextInputAction.next,
                  StringViewConstants.enterPhoneNumber,
                  false,
                  false,
                  0.55, completion: (value) {
                loggerNoStack.e('country code ' + value.countryCode!);
              }),
              Align(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  height: screenHeight * 0.05,
                  minWidth: screenWidth * 0.10,
                  color: ColorViewConstants.colorYellow,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    StringViewConstants.change,
                    style: AppTextStyles.semiBold.copyWith(
                        fontSize: 16, color: ColorViewConstants.colorBlack),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Text(
                StringViewConstants.emailEdit,
              style: AppTextStyles.regular.copyWith(
                  fontSize: 16, color: ColorViewConstants.colorDarkGray),
            ),
            SizedBox(
              height: screenHeight * 0.01,
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
                    fontSize: 16,
                    color: ColorViewConstants.colorGray,
                  ),
                  enabledBorder: AppBoxDecoration.noInputBorder,
                  focusedBorder: AppBoxDecoration.noInputBorder,
                  border: AppBoxDecoration.noInputBorder,
                ),
                style: AppTextStyles.medium,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Text(
              StringViewConstants.location,
              style: AppTextStyles.regular.copyWith(
                  fontSize: 16, color: ColorViewConstants.colorDarkGray),
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
                controller: locationController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                ],
                decoration: InputDecoration(
                  hintText: '',
                  hintStyle: AppTextStyles.regular.copyWith(
                    fontSize: 16,
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
              StringViewConstants.chooseCurrency,
              style: AppTextStyles.regular.copyWith(
                  fontSize: 16, color: ColorViewConstants.colorDarkGray),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Container(
              width: screenWidth,
              padding: const EdgeInsets.only(
                  left: 10, top: 15, bottom: 15, right: 15),
              decoration: BoxDecoration(
                color: ColorViewConstants.colorTransferGray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                StringViewConstants.inr,
                style: AppTextStyles.medium.copyWith(fontSize: 16),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            MaterialButton(
              height: screenHeight * 0.06,
              color: ColorViewConstants.colorBlueSecondaryText,
              minWidth: screenWidth,
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                StringViewConstants.upload,
                style: AppTextStyles.semiBold.copyWith(
                    fontSize: 16, color: ColorViewConstants.colorWhite),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
