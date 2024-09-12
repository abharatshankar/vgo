import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/model/bank_upi.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

import '../../../utils/app_box_decoration.dart';

Widget widgetBankAccountNumber(
    BuildContext context,
    bool isNumber,
    String title,
    String hint,
    TextEditingController numberController,
    TextEditingController holderController,
    BankUPI? bankUpi,
    {required Function(String value) completion, bool isAddUPIBank = false}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  if (isNumber && isAddUPIBank) {
    numberController.text = bankUpi?.accountNumber ?? '';
    holderController.text = bankUpi?.upiName ?? '';
  } else if (!isNumber && isAddUPIBank) {
    numberController.text = bankUpi?.accountNumber ?? '';
    holderController.text = bankUpi?.accountHolderName ?? '';
  } else {}

  return Container(
    padding: EdgeInsets.only(
      top: screenHeight * 0.02,
      left: screenHeight * 0.02,
      right: screenHeight * 0.01,
      bottom: screenHeight * 0.01,
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
                  text:
                  title,
                  style: AppTextStyles.regular.copyWith(
                      color: ColorViewConstants.colorPrimaryOpacityText80,
                      fontSize: 14)),
              TextSpan(
                  text: ' *',
                  style: AppTextStyles.medium.copyWith(
                      color: ColorViewConstants.colorRed,
                      fontSize: 14)),

            ])),
        SizedBox(height: screenHeight * 0.02),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: screenWidth * 0.92,
              height: screenHeight * 0.06,
              decoration: BoxDecoration(
                color: ColorViewConstants.colorTransferGray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 17.0),
                child: TextField(
                  inputFormatters: isNumber
                      ? [
                          LengthLimitingTextInputFormatter(20),
                          FilteringTextInputFormatter.digitsOnly
                        ]
                      : [
                          LengthLimitingTextInputFormatter(50),
                          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                        ],
                  controller: isNumber ? numberController : holderController,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: AppTextStyles.regular.copyWith(
                      fontSize: 14,
                      color: ColorViewConstants.colorPrimaryTextHint,
                    ),
                    enabledBorder: AppBoxDecoration.noInputBorder,
                    focusedBorder: AppBoxDecoration.noInputBorder,
                    border: AppBoxDecoration.noInputBorder,
                  ),
                  style: AppTextStyles.medium.copyWith(
                      fontSize: 14, color: ColorViewConstants.colorPrimaryText),
                  onChanged: (value) {
                    completion(value);
                  },
                  // textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
