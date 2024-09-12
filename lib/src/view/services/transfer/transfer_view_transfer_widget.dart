import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

import '../../../constants/string_view_constants.dart';

Widget widgetTransferViewTransfer(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    color: ColorViewConstants.colorWhite,
    padding: EdgeInsets.only(
      top: screenHeight * 0.01,
      left: screenHeight * 0.02,
      right: screenHeight * 0.01,
      bottom: screenHeight * 0.0,
    ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 0,),
            child: Text(
            StringViewConstants.transferTo,
            style: AppTextStyles.medium.copyWith(
                fontSize: 14,
                color: ColorViewConstants.colorPrimaryText,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: screenWidth * 0.45,
          height: screenHeight * 0.05,
          decoration: BoxDecoration(
            color: ColorViewConstants.colorWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: ColorViewConstants.colorBlueSecondaryText,
              width: 1,
            ),
          ),

            padding: EdgeInsets.only(left: 10, right: 0, top: 10, bottom: 10,),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/images/service/arrow.svg',
                width: 16,
                height: 16,
                color: ColorViewConstants.colorBlueSecondaryText,
              ),
              SizedBox(width: screenWidth * 0.03),
              Text(
                StringViewConstants.viewTransaction,
                style: AppTextStyles.medium.copyWith(
                  fontSize: 14,
                  color: ColorViewConstants.colorBlueSecondaryText,
                ),
              ),
            ],
          ),
        ),
        ],
      ),

  );
}
