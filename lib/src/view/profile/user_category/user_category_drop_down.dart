import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

Widget widgetUserCategoryDropDown(
    BuildContext context, String userTypeValue, List<String>? userTypesList,
    {required Function(String string) completion}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    padding: const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 10),
    decoration: BoxDecoration(
        color: ColorViewConstants.colorHintBlue,
        borderRadius: BorderRadius.circular(5)),
    width: screenWidth,
    child: DropdownButtonHideUnderline(
      child: DropdownButton(
          elevation: 0,
          underline: Divider(
            color: ColorViewConstants.colorHintBlue,
          ),
          iconDisabledColor: ColorViewConstants.colorHintGray,
          iconEnabledColor: ColorViewConstants.colorGreen,
          isExpanded: false,
          iconSize: 25,
          style: AppTextStyles.medium.copyWith(fontSize: 16),
          value: userTypeValue,
          icon: const Icon(Icons.arrow_drop_down),
          items: userTypesList?.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(
                items,
                style: AppTextStyles.medium.copyWith(fontSize: 16),
              ),
            );
          }).toList(),
          onChanged: (String? value) {
            completion(value!);
          }),
    ),
  );
}
