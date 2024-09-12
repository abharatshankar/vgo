/*
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

import '../../../utils/app_box_decoration.dart';

Widget widgetQuantityPrice(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
  //  margin: const EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.only(
        top: screenHeight * 0.01,
        left: screenHeight * 0.02,
        right: screenHeight * 0.01,
        bottom: screenHeight * 0.02),
    decoration: BoxDecoration(
      color: ColorViewConstants.colorWhite,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Quantity',
                  style: AppTextStyles.bold.copyWith(
                      fontSize: 14, color: ColorViewConstants.colorLightBlack),
                ),
              ],
            ),
            SizedBox(width: screenWidth * 0.5,
            height: screenHeight * 0.01,),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter price',
                hintStyle: AppTextStyles.regular.copyWith(
                  fontSize: 14,
                  color: ColorViewConstants.colorGray,
                ),
                enabledBorder: AppBoxDecoration.grayUnderlineBorder,
                focusedBorder: AppBoxDecoration.grayUnderlineBorder,
                border: AppBoxDecoration.grayUnderlineBorder,
              ),
              style: AppTextStyles.medium,
              // textAlign: TextAlign.center,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Text(
                  'Price',
                  style: AppTextStyles.bold.copyWith(
                      fontSize: 14, color: ColorViewConstants.colorLightBlack),
                ),
              ],
            ),
           */
/* SizedBox(width: screenWidth * 0.43,
              height: screenHeight * 0.01,),*//*


          ],
        ),
      ],
    ),
  );
}
*/
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

import '../../../utils/app_box_decoration.dart';

Widget widgetQuantityPrice(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Scaffold(
    body: SafeArea(
      child: Container(
        // margin: const EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.only(
          top: screenHeight * 0.01,
          left: screenHeight * 0.02,
          right: screenHeight * 0.01,
          bottom: screenHeight * 0.02,
        ),
        decoration: BoxDecoration(
          color: ColorViewConstants.colorWhite,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Quantity',
                      style: AppTextStyles.bold.copyWith(
                        fontSize: 14,
                        color: ColorViewConstants.colorLightBlack,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: screenWidth * 0.5,
                  height: screenHeight * 0.01,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter price',
                    hintStyle: AppTextStyles.regular.copyWith(
                      fontSize: 14,
                      color: ColorViewConstants.colorGray,
                    ),
                    enabledBorder: AppBoxDecoration.grayUnderlineBorder,
                    focusedBorder: AppBoxDecoration.grayUnderlineBorder,
                    border: AppBoxDecoration.grayUnderlineBorder,
                  ),
                  style: AppTextStyles.medium,
                  // textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      'Price',
                      style: AppTextStyles.bold.copyWith(
                        fontSize: 14,
                        color: ColorViewConstants.colorLightBlack,
                      ),
                    ),
                  ],
                ),
                 SizedBox(width: screenWidth * 0.43,
              height: screenHeight * 0.01,),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter price',
                    hintStyle: AppTextStyles.regular.copyWith(
                      fontSize: 14,
                      color: ColorViewConstants.colorGray,
                    ),
                    enabledBorder: AppBoxDecoration.grayUnderlineBorder,
                    focusedBorder: AppBoxDecoration.grayUnderlineBorder,
                    border: AppBoxDecoration.grayUnderlineBorder,
                  ),
                  style: AppTextStyles.medium,
                  // textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    ),

  );
}
