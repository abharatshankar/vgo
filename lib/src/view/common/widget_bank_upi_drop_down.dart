import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/model/bank_upi.dart';

import '../../constants/color_view_constants.dart';
import '../../utils/app_text_style.dart';

Widget widgetBankUPIDropDown(
    BuildContext context, bool isUpi, String selectedType, List<BankUPI>? list,
    {required Function(String currency) completion}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
      width: screenWidth * 0.05,
      height: screenHeight * 0.1,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            iconEnabledColor: ColorViewConstants.colorBlueSecondaryText,
            iconDisabledColor: ColorViewConstants.colorBlueSecondaryText,
            value: selectedType,
            isExpanded: false,
            style: AppTextStyles.medium.copyWith(fontSize: 16),
            items: list?.map((BankUPI items) {
              String? name = items.bankName ?? items.upiName;
              return DropdownMenuItem(
                value: name,
                child: Text(
                  name ?? '',
                  style: AppTextStyles.medium,
                ),
              );
            }).toList(),
            onChanged: (String? value) {
              completion(value!);
            }),
      ));
}
