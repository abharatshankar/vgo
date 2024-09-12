import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';

import '../../../constants/string_view_constants.dart';
import '../../../utils/app_box_decoration.dart';

Widget widgetTransferPhoneNumberCompletion(
    BuildContext context,
    TextEditingController numberController,
    TextInputAction action,
    String title,
    bool textOne,
    bool textTwo,
    double numberWidth,
    {required Function(String number) completion}) {
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
        Visibility(
          visible: textOne,
          child: Text(
            title,
            style: AppTextStyles.regular.copyWith(
              fontSize: 14,
              color: ColorViewConstants.colorPrimaryTextHint,
            ),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.01,
        ),
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
              child: Align(
                child: Text(
                  '+91',
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 14,
                    color: ColorViewConstants.colorPrimaryTextMedium,
                  ),
                ),
              ),
            ),
            Container(
              width: screenWidth * numberWidth,
              height: screenHeight * 0.06,
              decoration: BoxDecoration(
                color: ColorViewConstants.colorTransferGray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 2),
                child: SizedBox(
                    width: screenWidth,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: TextField(
                        onChanged: (value){
                          completion(value);
                           loggerNoStack.e('value ' + value);
                        },
                        keyboardType: TextInputType.number,
                        controller: numberController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textInputAction: action,
                        decoration: InputDecoration(
                          hintText: StringViewConstants.phoneNumber,
                          hintStyle: AppTextStyles.regular.copyWith(
                            fontSize: 14,
                            color: ColorViewConstants.colorPrimaryTextHint,
                          ),
                          labelStyle:
                              AppTextStyles.semiBold.copyWith(fontSize: 16),
                          enabledBorder: AppBoxDecoration.noInputBorder,
                          focusedBorder: AppBoxDecoration.noInputBorder,
                          border: AppBoxDecoration.noInputBorder,
                        ),
                        style: AppTextStyles.medium.copyWith(
                            color: ColorViewConstants.colorPrimaryTextMedium,
                            fontSize: 14),
                        //  textAlign: TextAlign.center,
                      ),
                    )),
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.01),
        Visibility(
          visible: textTwo,
          child: Text(
            StringViewConstants.note,
            style: AppTextStyles.regular.copyWith(
              fontSize: 14,
              color: ColorViewConstants.colorPrimaryOpacityText80,
            ),
          ),
        )
      ],
    ),
  );
}
