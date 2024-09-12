import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

import '../../../utils/app_box_decoration.dart';
import '../../../utils/toast_utils.dart';

Widget widgetAmountTransfer(BuildContext context,
    String lockTitle,
    TextEditingController amountController,
    bool isReadOnly,
    {required Function(String amount, String title) completion}) {
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
                  text:StringViewConstants.amountToTransfer,
                  style: AppTextStyles.regular.copyWith(
                      color: ColorViewConstants.colorPrimaryOpacityText80,
                      fontSize: 14)),
              TextSpan(
                  text: ' *',
                  style: AppTextStyles.medium.copyWith(
                      color: ColorViewConstants.colorRed, fontSize: 14)),
            ])),
        SizedBox(height: screenHeight * 0.01),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: screenWidth * 0.45,
              height: screenHeight * 0.06,
              decoration: BoxDecoration(
                color: ColorViewConstants.colorTransferGray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                width: screenWidth,
                child: TextField(
                  readOnly: isReadOnly,
                  controller: amountController,
                  inputFormatters: [LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: StringViewConstants.amountCoins,
                    hintStyle: AppTextStyles.regular.copyWith(
                      fontSize: 14,
                      color: ColorViewConstants.colorGray,
                    ),
                    enabledBorder: AppBoxDecoration.noInputBorder,
                    focusedBorder: AppBoxDecoration.noInputBorder,
                    border: AppBoxDecoration.noInputBorder,
                  ),
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 14,
                    color: ColorViewConstants.colorPrimaryText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if(amountController.text.length != 0){
                  if(lockTitle == 'Lock'){
                    lockTitle = 'Cancel';
                  } else {
                    lockTitle = 'Lock';
                  }

                  completion(amountController.text, lockTitle);
                } else {
                  ToastUtils.instance
                      .showToast(StringViewConstants.pleaseEnterTheAmount, context: context, isError: true);
                }
              },
              child: Container(
                width: screenWidth * 0.45,
                height: screenHeight * 0.06,
                decoration: BoxDecoration(
                  color: ColorViewConstants.colorRed,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: 23,
                      height: 23,
                      child: SvgPicture.asset(
                        'assets/images/services/ic_lock.svg',
                        color: ColorViewConstants.colorWhite,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      lockTitle,
                      style: AppTextStyles.medium.copyWith(
                          color: ColorViewConstants.colorWhite, fontSize: 14),
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
