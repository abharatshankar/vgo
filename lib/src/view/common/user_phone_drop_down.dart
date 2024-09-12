import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';

import '../../model/country.dart';

Widget widgetPhoneDropDown(
    BuildContext context, Country selectedValue, List<Country>? countryList,
    {required Function(Country country) completion}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  loggerNoStack.e('countryList '+ countryList!.length.toString());

  return Container(
    padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
    decoration: BoxDecoration(
        color: ColorViewConstants.colorTransferGray,
        borderRadius: BorderRadius.circular(5)),
    width: screenWidth,
    child: DropdownButtonHideUnderline(
      child: DropdownButton(
          elevation: 0,
          underline: Divider(
            color: ColorViewConstants.colorTransferGray,
          ),
          iconDisabledColor: ColorViewConstants.colorHintGray,
          iconEnabledColor: ColorViewConstants.colorBlueSecondaryText,
          isExpanded: false,
          iconSize: 25,
          style: AppTextStyles.medium.copyWith(fontSize: 16),
          value: selectedValue,
          icon: const Icon(Icons.arrow_drop_down),
          items: countryList?.map((Country items) {
            return DropdownMenuItem(
                value: items,
                child: Container(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Image.network(
                        items.countryIconPath!,
                        width: 40,
                        height: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        items.countryCode!,
                        style: AppTextStyles.medium.copyWith(
                            fontSize: 14,
                            color: ColorViewConstants.colorPrimaryText),
                      ),
                    ],
                  ),
                ));
          }).toList(),
        onChanged: (value){
            completion(value as Country);
        }),
    ),
  );
}
