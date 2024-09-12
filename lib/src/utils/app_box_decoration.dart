

import 'package:flutter/material.dart';

import '../constants/color_view_constants.dart';

class AppBoxDecoration{

  static BoxDecoration unselectedAdsBoxDecoration = BoxDecoration(
    border: Border.all(color: ColorViewConstants.colorBlueSecondaryText),
    borderRadius: const BorderRadius.all(Radius.circular(30)),
  );

  static BoxDecoration selectedAdsBoxDecoration = BoxDecoration(
      border: Border.all(color: ColorViewConstants.colorBlueSecondaryText),
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      color: ColorViewConstants.colorBlueSecondaryText);

  static BoxDecoration greenBorderBoxDecoration = BoxDecoration(
    border: Border.all(color: ColorViewConstants.colorBlueSecondaryText),
    borderRadius: const BorderRadius.all(Radius.circular(10)),
  );

  static BoxDecoration greenBackgroundBoxDecoration = BoxDecoration(
    color: ColorViewConstants.colorBlueSecondaryText,
    borderRadius: const BorderRadius.all(Radius.circular(10)),
  );

  static BoxDecoration grayBorderBoxDecoration = BoxDecoration(
    border: Border.all(color: ColorViewConstants.colorBlueSecondaryText),
    borderRadius: const BorderRadius.all(Radius.circular(10)),
  );

  static BoxDecoration grayBackgroundBoxDecoration = BoxDecoration(
      color: ColorViewConstants.colorBlueSecondaryText,
      borderRadius: const BorderRadius.all(Radius.circular(10)));

  static BoxDecoration selectedBox = BoxDecoration(
    color: ColorViewConstants.colorBlue,
    border: Border.all(
      color: ColorViewConstants.colorDarkBlue,
      width: 1.0,
    ),
    borderRadius: BorderRadius.circular(10),
  );

  static BoxDecoration unSelectedBox = BoxDecoration(
    color: ColorViewConstants.colorLightWhite,
    borderRadius: BorderRadius.circular(10),
  );

  static UnderlineInputBorder grayUnderlineInputBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: ColorViewConstants.colorBlueSecondaryText));

  static UnderlineInputBorder noInputBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: ColorViewConstants.colorTransferGray));

  static UnderlineInputBorder grayUnderlineBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: ColorViewConstants.colorGray));
}