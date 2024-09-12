import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

Widget widgetType(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    padding: EdgeInsets.only(
      top: screenHeight * 0.01,
      left: screenHeight * 0.02,
      right: screenHeight * 0.02,
      bottom: screenHeight * 0.02,
    ),
    decoration: BoxDecoration(
      color: ColorViewConstants.colorWhite,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Type',
          style: AppTextStyles.medium.copyWith(
            fontSize: 14,
            color: ColorViewConstants.colorBlack,
          ),
        ),
        SizedBox(height: screenHeight * 0.02,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: screenWidth * 0.25,
              height: screenHeight * 0.05,
              padding: EdgeInsets.only(
                top: screenHeight * 0.01,
                left: screenHeight * 0.02,
                right: screenHeight * 0.02,
                bottom: screenHeight * 0.01,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(05.0),
                border: Border.all(
                  color: ColorViewConstants.colorBlueSecondaryText,
                  width: 1.0,
                ),
              ),
              child: Text('Market',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 14,
                    color: (ColorViewConstants.colorBlueSecondaryText),
                  )),
            ),
            SizedBox(width: screenWidth * 0.06),
            Container(
              width: screenWidth * 0.25,
              height: screenHeight * 0.05,
              padding: EdgeInsets.only(
                top: screenHeight * 0.01,
                left: screenHeight * 0.02,
                right: screenHeight * 0.02,
                bottom: screenHeight * 0.01,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(05.0),
                border: Border.all(
                  color: ColorViewConstants.colorGray,
                  width: 1.0,
                ),
              ),
              child: Text('Limit',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 14,
                    color: (ColorViewConstants.colorGray),
                  )),
            ),
          ],
        ),
      ],
    ),
  );
}
