import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/color_view_constants.dart';
import '../../../utils/app_text_style.dart';

Widget widgetQuantityPriceNew(BuildContext context) {

  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  final FocusNode _focusNode = FocusNode();
  // Ensure the TextField does not gain focus automatically
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _focusNode.unfocus(); // Explicitly unfocus the TextField
  });
  return Container(
    padding: EdgeInsets.only(
      top: screenHeight * 0.01,
      left: screenHeight * 0.02,
      right: screenHeight * 0.01,
      bottom: screenHeight * 0.02,
    ),
    decoration: BoxDecoration(
      color: ColorViewConstants.colorWhite,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(child:   Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Quantity',
                  style: AppTextStyles.bold.copyWith(
                    fontSize: 14,
                    color: ColorViewConstants.colorLightBlack,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: screenWidth * 0.5,
              height: screenHeight * 0.01,
            ),
            Container(
              decoration: BoxDecoration(
                color: ColorViewConstants.colorGrayTransparent,
                borderRadius:  BorderRadius.circular(10),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintStyle: AppTextStyles.regular.copyWith(
                    fontSize: 14,
                    color: ColorViewConstants.colorBlack,
                  ),
                  contentPadding: EdgeInsets.only(left: 15),
                  hintText: 'Enter Quantity',
                  border: InputBorder.none,
                ),
                style: AppTextStyles.medium,
                autofocus: false,
                onChanged: (String val){

                },
              ),
            ),

          ],
        ),),
        SizedBox(width: 10,),
        Expanded(child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Text(
                  'Price',
                  style: AppTextStyles.bold.copyWith(
                    fontSize: 14,
                    color: ColorViewConstants.colorLightBlack,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: screenWidth * 0.5,
              height: screenHeight * 0.01,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(right: 15),
              padding: EdgeInsets.all(13.0),
              decoration: BoxDecoration(
                  color: ColorViewConstants.colorGrayTransparent,
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                'Price',
                style: AppTextStyles.bold.copyWith(
                  fontSize: 14,
                  color: ColorViewConstants.colorLightBlack,
                ),
              ),
            ),

          ],
        ),),
      ],
    ),
  );

}