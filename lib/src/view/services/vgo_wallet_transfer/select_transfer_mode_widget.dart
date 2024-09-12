import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_box_decoration.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

Widget widgetSelectTransferMode(
    BuildContext context, String title, bool isUpiSelected,
    {required Function(bool isUpi) completion}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    padding: EdgeInsets.only(
      top: screenHeight * 0.02,
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
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                text: title,
                style: AppTextStyles.regular.copyWith(
                    color: ColorViewConstants.colorPrimaryText, fontSize: 14),
              ),
              TextSpan(
                  text: ' *',
                  style: AppTextStyles.medium.copyWith(
                      color: ColorViewConstants.colorRed, fontSize: 14)),
            ])),
        SizedBox(height: screenHeight * 0.02),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
              onTap: () {
                completion(true);
              },
              child: Container(
                width: screenWidth * 0.44,
                height: screenHeight * 0.09,
                decoration: isUpiSelected
                    ? AppBoxDecoration.selectedBox
                    : AppBoxDecoration.unSelectedBox,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: SvgPicture.asset('assets/images/services/upi.svg'),
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      width: 25,
                      height: 25,
                      child: Image.asset(isUpiSelected
                          ? 'assets/images/services/correct.png'
                          : 'assets/images/services/circle.png'),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                completion(false);
              },
              child: Container(
                width: screenWidth * 0.44,
                height: screenHeight * 0.09,
                decoration: isUpiSelected
                    ? AppBoxDecoration.unSelectedBox
                    : AppBoxDecoration.selectedBox,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: 25,
                      height: 25,
                      child: SvgPicture.asset(
                        'assets/images/services/bank.svg',
                        color: ColorViewConstants.colorDarkGray,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text('Bank',
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 14,
                          color: (ColorViewConstants.colorDarkGray),
                        )),
                    SizedBox(width: 15),
                    SizedBox(
                      width: 25,
                      height: 25,
                      child: Image.asset(
                        isUpiSelected
                            ? 'assets/images/services/circle.png'
                            : 'assets/images/services/correct.png',
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    ),
  );
}
