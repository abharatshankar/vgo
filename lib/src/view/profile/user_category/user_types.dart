import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';

Widget widgetUserType(BuildContext context,String title) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    padding: EdgeInsets.only(
      top: screenHeight * 0.02,
      left: screenHeight * 0.00,
      right: screenHeight * 0.02,
      bottom: screenHeight * 0.02,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                text: title,
                  style: AppTextStyles.regular.copyWith(
                      color: ColorViewConstants.colorPrimaryTextHint, fontSize: 14)),
              TextSpan(
                  text: ' *',
                  style: AppTextStyles.medium.copyWith(
                      color: ColorViewConstants.colorRed, fontSize: 14)),
            ])),
      ],
    ),
  );
}
