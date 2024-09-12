import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/view/common/widget_bank_upi_drop_down.dart';
import 'package:vgo_flutter_app/src/view/common/widget_currency_drop_down.dart';

import '../../../model/bank_upi.dart';
import '../../../model/country.dart';

Widget widgetCurrencyBankType(
    BuildContext context, bool isUpi, String selectedType, String selectedType2, List<Country>? list, List<BankUPI>? list2,
    bool isUpiSelected,
    {required Function(String currency) completion,
      required Function(String bankUpi) completion2}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    padding: EdgeInsets.only(
      top: screenHeight * 0.01,
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
        SizedBox(height: screenHeight * 0.02),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column( // Column for the INR text
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: StringViewConstants.currencyType,
                          style: AppTextStyles.regular.copyWith(
                              color: ColorViewConstants.colorHintGray,
                              fontSize: 14)),
                      TextSpan(
                          text: ' *',
                          style: AppTextStyles.regular.copyWith(
                              color: ColorViewConstants.colorRed,
                              fontSize: 14)),
                    ])),
                SizedBox(height: screenHeight * 0.01),
                Container(
                  width: screenWidth * 0.35,
                  height: screenHeight * 0.06,
                  decoration: BoxDecoration(
                    color: ColorViewConstants.colorTransferGray,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.only(
                    top: 5,
                  ),
                  child: widgetCurrencyDropDown(context, selectedType, list,
                      completion: (currency) {
                    completion(currency);
                  }),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: isUpiSelected ? 'Select UPI' : 'Select Bank',
                          style: AppTextStyles.regular.copyWith(
                              color: ColorViewConstants.colorHintGray,
                              fontSize: 14)),
                      TextSpan(
                          text: ' *',
                          style: AppTextStyles.medium.copyWith(
                              color: ColorViewConstants.colorRed,
                              fontSize: 14)),
                    ])),
                SizedBox(height: screenHeight * 0.01),
                Container(
                  width: screenWidth * 0.5,
                  height: screenHeight * 0.06,
                  decoration: BoxDecoration(
                    color: ColorViewConstants.colorTransferGray,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.only(
                    left: 20,
                    top: 7,
                  ),
                  child: widgetBankUPIDropDown(context, isUpi, selectedType2, list2, completion: (value){
                    completion2(value);
                  })
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
