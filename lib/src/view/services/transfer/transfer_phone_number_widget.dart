import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

import '../../../constants/string_view_constants.dart';
import '../../../model/country.dart';
import '../../../utils/app_box_decoration.dart';
import '../../common/user_phone_drop_down.dart';

Widget widgetTransferPhoneNumber(
    BuildContext context,
    Country selectedValue,
    List<Country>? countryList,
    TextEditingController numberController,
    TextInputAction action,
    String title,
    bool textOne,
    bool textTwo,
    double numberWidth,
    {required Function(Country country) completion}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    padding: EdgeInsets.only(
      top: screenHeight * 0.02,
      left: screenHeight * 0.0,
      right: screenHeight * 0.0,
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
              color: ColorViewConstants.colorPrimaryOpacityText80,
            ),
          ),
        ),
       SizedBox(height: screenHeight * 0.01,),
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
                  child: widgetPhoneDropDown(
                      context, selectedValue, countryList, completion: (value) {
                selectedValue = value;
                completion(value);
              })),
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
                        keyboardType: TextInputType.number,
                        controller: numberController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textInputAction: action,
                        decoration: InputDecoration(
                          hintText:  StringViewConstants.phoneNumber,
                          hintStyle: AppTextStyles.regular.copyWith(
                            fontSize: 14,
                            color: ColorViewConstants.colorLightBlack,
                          ),
                          labelStyle:
                              AppTextStyles.medium.copyWith(fontSize: 14, color: ColorViewConstants.colorPrimaryText,),
                          enabledBorder: AppBoxDecoration.noInputBorder,
                          focusedBorder: AppBoxDecoration.noInputBorder,
                          border: AppBoxDecoration.noInputBorder,
                        ),
                        style: AppTextStyles.medium.copyWith(color: ColorViewConstants.colorPrimaryText, fontSize: 14),
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
