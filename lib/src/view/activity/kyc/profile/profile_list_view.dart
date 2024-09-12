import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';

Widget widgetProfileList(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
      padding: EdgeInsets.only(
          top: screenHeight * 0.02,
          left: screenHeight * 0.02,
          right: screenHeight * 0.01,
          bottom: screenHeight * 0.02),
    decoration: BoxDecoration(
      color: ColorViewConstants.colorWhite,
    ),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          SvgPicture.asset(
            'assets/images/services/mobile_transfer.svg',
            width: 30,
            height: 30,
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Text(
            'Gowthami Babu',
            style: AppTextStyles.medium.copyWith(
              fontSize: 16,
              color: ColorViewConstants.colorBlack,
            ),
            textAlign: TextAlign.center,
          ),

          Text(
            'Education',
            style: AppTextStyles.medium.copyWith(
              fontSize: 15,
              color: ColorViewConstants.colorLightBlack,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
  );

}