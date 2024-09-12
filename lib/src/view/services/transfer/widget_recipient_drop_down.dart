import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';

import '../../../constants/color_view_constants.dart';
import '../../../model/transfers.dart';
import '../../../utils/app_text_style.dart';

Widget widgetRecipientDropDown(BuildContext context, bool isUpi,
    Transfers selectedType, List<Transfers>? list,
    {required Function(Transfers transfer) completion}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  loggerNoStack.e('widgetRecipientDropDown : widgetRecipientDropDown ' + isUpi.toString());

  return Container(
      padding: EdgeInsets.only(
        top: screenHeight * 0.01,
        left: screenHeight * 0.02,
        right: screenHeight * 0.02,
        bottom: screenHeight * 0.01,
      ),
      decoration: BoxDecoration(
        color: ColorViewConstants.colorTransferGray,
        borderRadius: BorderRadius.circular(10),
      ),
      width: screenWidth ,
      height: screenHeight *  0.07,
     // padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            iconEnabledColor: ColorViewConstants.colorBlueSecondaryText,
            iconDisabledColor: ColorViewConstants.colorBlueSecondaryText,
            value: selectedType,
            isExpanded: false,
            style: AppTextStyles.medium.copyWith(fontSize: 14),
            items: list?.map((Transfers items) {
              return DropdownMenuItem(
                value: items,
                child: Text(
                  StringUtils.capitalize(items.recipientId ?? ''),
                  style: AppTextStyles.medium
                      .copyWith(color: ColorViewConstants.colorPrimaryText),
                ),
              );
            }).toList(),
            onChanged: (value){
              completion(value as Transfers);
            },),
      ));
}
