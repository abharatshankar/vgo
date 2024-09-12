import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/model/company.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';

import 'bottom_sheet.dart';


Widget widgetBuySell(BuildContext context, Company? company, {required bool isBuy}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    margin: const EdgeInsets.only(top: 5, bottom: 10),
    padding: EdgeInsets.only(
        top: screenHeight * 0.02,
        left: screenHeight * 0.02,
        right: screenHeight * 0.02,
        bottom: screenHeight * 0.02),
    decoration: BoxDecoration(
      color: ColorViewConstants.colorBlue,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Want to buy/sell',
          style: AppTextStyles.medium.copyWith(
              fontSize: 16, color: ColorViewConstants.colorBlack),
        ),
        Container(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0,top: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              MaterialButton(
                  height: screenHeight * 0.05,
                  minWidth: screenWidth * 0.3,
                  color: ColorViewConstants.colorRed,
                  onPressed: () {
                    BottomSheetHelper.showBottomSheet(context, company,isBuy: true);
                },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: Text(
                    'SELL',
                    style: AppTextStyles.medium.copyWith(
                        fontSize: 14, color: ColorViewConstants.colorWhite),
                    textAlign: TextAlign.center,
                  ),
                ),


              MaterialButton(
                height: screenHeight * 0.05,
                minWidth: screenWidth * 0.3,
                color: ColorViewConstants.colorBlueSecondaryText,
                onPressed: () {
                  loggerNoStack.e("button pressed");
                  BottomSheetHelper.showBottomSheet(context, company, isBuy: true);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                child: Text(
                  'Buy',
                  style: AppTextStyles.medium.copyWith(
                      fontSize: 14, color: ColorViewConstants.colorWhite),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


