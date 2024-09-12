import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';

Widget widgetSelectRecipient(
  BuildContext context,
  String title,
  bool textOne,
) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    padding: EdgeInsets.only(
      top: screenHeight * 0.0,
      left: screenHeight * 0.02,
      right: screenHeight * 0.02,
      bottom: screenHeight * 0.02,
    ),
    decoration: BoxDecoration(
      color: ColorViewConstants.colorWhite,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: textOne,
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                    text: title,
                    style: AppTextStyles.regular.copyWith(
                        color: ColorViewConstants.colorHintGray, fontSize: 14)),
                TextSpan(
                    text: ' *',
                    style: AppTextStyles.medium.copyWith(
                        color: ColorViewConstants.colorRed, fontSize: 14)),
              ])),
        ),
        SizedBox(height: screenHeight * 0.02),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.06,
              decoration: BoxDecoration(
                color: ColorViewConstants.colorTransferGray,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.only(left: 15, top: 15),
              child: Text(
               StringViewConstants.selectRecipient,
                style: AppTextStyles.medium.copyWith(
                  fontSize: 14,
                  color: ColorViewConstants.colorPrimaryTextHint,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
