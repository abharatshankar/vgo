import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';

Widget widgetAnalysisOverView(BuildContext context,
    String? lowStockPrice,
    String? highStockPrice, String? totalVolume) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    margin: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
    padding: EdgeInsets.only(
        top: screenHeight * 0.02,
        left: screenHeight * 0.02,
        right: screenHeight * 0.02,
        bottom: screenHeight * 0.02),
    decoration: BoxDecoration(
      color: ColorViewConstants.colorWhite,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
      Text(
      StringViewConstants.analysisOverVie,
      style: AppTextStyles.bold.copyWith(
          fontSize: 18, color: ColorViewConstants.colorBlack
      ),
    ),
        Container(
        padding: const EdgeInsets.only(left: 20.0,top: 10.0),
        child: Row(
          children: [
            SizedBox(width: screenWidth * 0.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    StringViewConstants.priceHigh,
                    style: AppTextStyles.regular.copyWith(
                        fontSize: 15, color: ColorViewConstants.colorGray
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    '\$ $highStockPrice',
                    style: AppTextStyles.medium.copyWith(
                        fontSize: 17, color: ColorViewConstants.colorBlack),
                  ),
                ],
              ),
            ),
            SizedBox(width: screenWidth * 0.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                  StringViewConstants.priceLow,
                    style: AppTextStyles.regular.copyWith(
                        fontSize: 15, color: ColorViewConstants.colorGray
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    '\$ $lowStockPrice',
                    style: AppTextStyles.medium.copyWith(
                        fontSize: 16, color: ColorViewConstants.colorBlack),
                  ),
                ],
              ),
            ),
            SizedBox(width: screenWidth * 0.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    StringViewConstants.volume,
                    style: AppTextStyles.regular.copyWith(
                        fontSize: 15, color: ColorViewConstants.colorGray),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    '\$ $totalVolume',
                    style: AppTextStyles.medium.copyWith(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ],
    ),
  );
}
