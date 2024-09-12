import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

Widget toolBarWidget(BuildContext context, String title, {required Function(String isCart) completion}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    color: ColorViewConstants.colorWhite,
    padding: EdgeInsets.only(top: screenHeight * 0.02, left: screenHeight * 0.01, right: screenHeight * 0.01, bottom: screenHeight * 0.02),
    // Add padding for better spacing
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/images/logo/vgo_logo.png',
          width: 35,
          height: 35,
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Text(
            textAlign: TextAlign.center,
            title,
            style: AppTextStyles.medium.copyWith(
              fontSize: 18,
            ),
          ),
        )),
        SvgPicture.asset(
          'assets/images/home/bell_notification.svg',
          width: 25,
          height: 25,
          color: ColorViewConstants.colorBlueSecondaryText,
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
            color: ColorViewConstants.colorBlueSecondaryText,
          ),
        ),
        SizedBox(
          width: 15,
        ),
        InkWell(
          onTap: () {
            completion('SCAN_ICON');
          },
          child: SvgPicture.asset(
            'assets/images/home/ic_qr_code.svg',
            width: 23,
            height: 23,
            color: ColorViewConstants.colorBlueSecondaryText,
          ),
        )
      ],
    ),
  );
}
