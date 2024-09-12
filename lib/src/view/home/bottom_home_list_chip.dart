import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';

Widget bottomHomeListChip(
    BuildContext context, int selectedIndex, List<String>? iioCategoriesList,
    {required Function(int position) getSelectedPosition}) {

  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  loggerNoStack.e('selectedIndex$selectedIndex');

  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: iioCategoriesList?.length,
    itemBuilder: (context, position) {
      return InkWell(
        onTap: () {
          //selectedIndex = position;
          getSelectedPosition(position);
        },
        child: Container(
          height: 0,
          margin: const EdgeInsets.only(
            left: 10,
            right: 5,
          ),
          padding: EdgeInsets.only(
            top: screenHeight * 0.011,
            left: screenHeight * 0.02,
            right: screenHeight * 0.02,
          ),
          decoration: BoxDecoration(
            color: selectedIndex == position
                ? ColorViewConstants.colorBlueSecondaryText
                : ColorViewConstants.colorLightGray,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Text(iioCategoriesList![position],
              style: AppTextStyles.medium.copyWith(
                  fontSize: 14, color: ColorViewConstants.colorWhite)),
        ),
      );
    },
  );
}

