import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';

Widget toolBarTransferWhiteWidget(BuildContext context, String title) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    color: ColorViewConstants.colorWhite,
    padding: EdgeInsets.only(
        top: screenHeight * 0.02,
        left: screenHeight * 0.02,
        right: screenHeight * 0.03,
        bottom: screenHeight * 0.02),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            'assets/images/services/left_arrow.svg',
            width: 23,
            height: 23,
            color: ColorViewConstants.colorBlueSecondaryText,
          ),
        ),
        Text(
          title,
          style: AppTextStyles.medium.copyWith(
              fontSize: 18, color: ColorViewConstants.colorBlueSecondaryText),
        ),
        Visibility(
          visible: false,
          child: SvgPicture.asset(
            'assets/images/home/bell_notification.svg',
            width: 30,
            height: 30,
            color: ColorViewConstants.colorWhite,
          ),
        )
      ],
    ),
  );
}
