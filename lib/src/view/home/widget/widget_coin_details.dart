import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/model/coin.dart';

Widget widgetCoinDetails(BuildContext context, Coin? coin) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    width: screenWidth,
    padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
    decoration: BoxDecoration(
        color: ColorViewConstants.colorBlueSecondaryText,
        borderRadius: BorderRadius.circular(0)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              StringViewConstants.coinValue,
              style: AppTextStyles.regular
                  .copyWith(color: ColorViewConstants.colorWhite, fontSize: 16),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Text(
              '1.303',
              style: AppTextStyles.semiBold
                  .copyWith(color: ColorViewConstants.colorCyan, fontSize: 20),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              StringViewConstants.allocatedFunds,
              style: AppTextStyles.regular
                  .copyWith(color: ColorViewConstants.colorWhite, fontSize: 16),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Text(
              '0.0',
              style: AppTextStyles.semiBold
                  .copyWith(color: ColorViewConstants.colorWhite, fontSize: 20),
            )
          ],
        )
      ],
    ),
  );
}
