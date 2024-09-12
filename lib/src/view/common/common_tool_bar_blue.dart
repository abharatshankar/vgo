import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

Widget toolBarBlueWidget(BuildContext context, String title,
    {required Function(String isCart) completion}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    color: ColorViewConstants.colorBlueSecondaryText,
    padding: EdgeInsets.only(
        top: screenHeight * 0.02,
        left: screenHeight * 0.01,
        right: screenHeight * 0.01,
        bottom: screenHeight * 0.02),
    // Add padding for better spacing
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                color: ColorViewConstants.colorWhite,
                borderRadius: BorderRadius.circular(35)),
            child: Center(
              child: Text(
                'SA',
                style: AppTextStyles.bold.copyWith(
                    fontSize: 18,
                    color: ColorViewConstants.colorBlueSecondaryText),
              ),
            )),
        Expanded(
          child: Text(
            textAlign: TextAlign.center,
            title,
            style: AppTextStyles.medium
                .copyWith(fontSize: 18, color: ColorViewConstants.colorWhite),
          ),
        ),
        SvgPicture.asset(
          'assets/images/home/bell_notification.svg',
          width: 28,
          height: 28,
          color: ColorViewConstants.colorWhite,
        ),
        SizedBox(
          width: 15,
        ),
        InkWell(
          onTap: () {
            completion('CART_ICON');
          },
          child: SvgPicture.asset(
            'assets/images/common/ic_cart.svg',
            width: 23,
            height: 23,
            color: ColorViewConstants.colorWhite,
          ),
        )
      ],
    ),
  );
}
