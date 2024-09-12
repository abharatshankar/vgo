import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

Widget widgetBuy(
  BuildContext context,
) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    width: screenWidth * 0.12,
    height: screenHeight * 0.03,
    padding: EdgeInsets.only(
      top: screenHeight * 0.00,
      left: screenHeight * 0.00,
      right: screenHeight * 0.00,
      bottom: screenHeight * 0.00,
    ),
    decoration: BoxDecoration(
      color: ColorViewConstants.colorBlue,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            'assets/images/home/down_arrow.png',
            width: 18,
            height: 18,
            color: ColorViewConstants.colorBlueSecondaryText,
          ),
          Text('Buy',
              style: AppTextStyles.medium.copyWith(
                fontSize: 12,
                color: (ColorViewConstants.colorBlueSecondaryText),
              )),
        ]),
  );
}
