
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';

import '../../../utils/toast_utils.dart';

Widget widgetTransferBlueButton(BuildContext context, String title, Color color,
    String amount, String validationMessage,{required Function(String amount) completion})
{
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    color: ColorViewConstants.colorWhite,
    padding: EdgeInsets.only(
      top: screenHeight * 0.00,
      left: screenHeight * 0.02,
      right: screenHeight * 0.02,
      bottom: screenHeight * 0.02,
    ),
    child: MaterialButton(
      height: screenHeight * 0.06,
      color: color,
      minWidth: screenWidth,
      onPressed: () {
        loggerNoStack.e('amount' + amount);
        if(amount.isNotEmpty && amount !=0){
          completion(amount);
        } else {
          ToastUtils.instance
              .showToast(validationMessage, context: context, isError: false, bg: ColorViewConstants.colorYellow);
        }
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: AppTextStyles.medium.copyWith(
          fontSize: 15,
          color: ColorViewConstants.colorWhite,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
