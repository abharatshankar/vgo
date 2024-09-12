import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

import '../../../model/country.dart';
import '../../../utils/app_box_decoration.dart';
import '../../common/widget_currency_drop_down.dart';

Widget widgetTransferType(BuildContext context,
    String title,
    bool textOne,
    bool textTwo,
    String hint,
    String selectedType,
    int type,
    List<Country>? list,
    TextEditingController numberController,
    {required Function(Country currency) completion}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  List<TextInputFormatter> inputFormatter = [];

  if (type == 1) {
    inputFormatter = [
      LengthLimitingTextInputFormatter(20),
      FilteringTextInputFormatter.digitsOnly,
    ];
  } else {
    inputFormatter = [
      LengthLimitingTextInputFormatter(50),
      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
    ];
  }

  return Container(
    padding: EdgeInsets.only(
      top: screenHeight * 0.01,
      left: screenHeight * 0.02,
      right: screenHeight * 0.02,
      bottom: screenHeight * 0.01,
    ),
    decoration: BoxDecoration(
      color: ColorViewConstants.colorWhite,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: textOne,
          child:RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                    text: title,
                    style: AppTextStyles.regular.copyWith(
                        color: ColorViewConstants.colorPrimaryTextHint,
                        fontSize: 14)),
                TextSpan(
                    text: ' *',
                    style: AppTextStyles.medium.copyWith(
                        color: ColorViewConstants.colorRed, fontSize: 14)),
              ])),
        ),
        SizedBox(height: screenHeight * 0.02),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: screenWidth * 0.3,
              height: screenHeight * 0.06,
              decoration: BoxDecoration(
                color: ColorViewConstants.colorTransferGray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: widgetCurrencyDropDown(context, selectedType, list,
                  completion: (currency) {
                    completion(currency as Country);
                  }),
            ),
            Container(
              width: screenWidth * 0.55,
              height: screenHeight * 0.06,
              decoration: BoxDecoration(
                color: ColorViewConstants.colorTransferGray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 17.0, bottom: 5.0),
                child: SizedBox(
                  width: screenWidth,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: inputFormatter,
                    controller: numberController,
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
                        fontSize: 14,
                        color: ColorViewConstants.colorPrimaryText),
                    onChanged: (value){

                    },
                    //  textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.01),
        Visibility(
          visible: textTwo,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Note: exchange rate' ,
                        style: AppTextStyles.regular.copyWith(
                            color: ColorViewConstants.colorPrimaryTextHint,
                            fontSize: 13)),
                    TextSpan(
                        text: '   1USD = 83.45INR',
                        style: AppTextStyles.medium.copyWith(
                            color: ColorViewConstants.colorBlack, fontSize: 14)),
                  ])),
              RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Transaction fee' ,
                        style: AppTextStyles.regular.copyWith(
                            color: ColorViewConstants.colorPrimaryTextHint,
                            fontSize: 13)),
                    TextSpan(
                        text: '  ₹2500',
                        style: AppTextStyles.medium.copyWith(
                            color: ColorViewConstants.colorBlack, fontSize: 14)),
                  ])),
            ],
          ),
        ),
      ],
    ),
  );
}
