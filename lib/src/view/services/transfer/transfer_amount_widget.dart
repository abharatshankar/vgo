import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

import '../../../utils/app_box_decoration.dart';

Widget widgetTransferAmount(BuildContext context,
    {required Function(String number) completion}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    padding: EdgeInsets.only(
      top: screenHeight * 0.00,
      left: screenHeight * 0.02,
      right: screenHeight * 0.02,
      bottom: screenHeight * 0.02,
    ),
    decoration: BoxDecoration(
      color: ColorViewConstants.colorWhite,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: screenHeight * 0.01),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: screenWidth * 0.35,
              height: screenHeight * 0.06,
              decoration: BoxDecoration(
                color: ColorViewConstants.colorTransferGray,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.only(
                left: 15,
                right: 5,
                top: 15,
                bottom: 5,
              ),
              child: Text(
                textAlign: TextAlign.center,
                'INR',
                style: AppTextStyles.medium.copyWith(
                  fontSize: 14,
                  color: ColorViewConstants.colorBlack,
                ),
              ),

            ),
            Container(
              width: screenWidth * 0.53,
              height: screenHeight * 0.06,
              padding: EdgeInsets.only(
                left: 15,
                right: 5,
                top: 10,
                bottom: 10,
              ),
              decoration: BoxDecoration(
                color: ColorViewConstants.colorTransferGray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                width: screenWidth,
                child: TextField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: StringViewConstants.amountCoins,
                    hintStyle: AppTextStyles.regular.copyWith(
                      fontSize: 14,
                      color: ColorViewConstants.colorPrimaryOpacityText80,
                    ),
                    enabledBorder: AppBoxDecoration.noInputBorder,
                    focusedBorder: AppBoxDecoration.noInputBorder,
                    border: AppBoxDecoration.noInputBorder,
                  ),
                  style: AppTextStyles.medium,
                  onChanged: (value) {
                    completion(value);
                  },
                ),
              ),
            ),
          ],
        ),

      ],
    ),
  );
}
