import 'package:flutter/material.dart';

import '../../constants/color_view_constants.dart';
import '../../model/country.dart';
import '../../utils/app_text_style.dart';

Widget widgetCurrencyDropDown(
    BuildContext context,
    String selectedType,
    List<Country>? list,
    {required Function(String currency) completion}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
      width: screenWidth * 0.05,
      height: screenHeight * 0.065,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            iconEnabledColor: ColorViewConstants.colorBlueSecondaryText,
            iconDisabledColor: ColorViewConstants.colorBlueSecondaryText,
            value: selectedType,
            isExpanded: false,
            style: AppTextStyles.medium.copyWith(fontSize: 16),
            items: list?.map((Country items) {
              return DropdownMenuItem(
                value: items.currency,
                child: Text(
                  items.currency!,
                  style: AppTextStyles.medium,
                ),
              );
            }).toList(),
            onChanged: (value) {
              completion(value!);
            }),
      ));
}
