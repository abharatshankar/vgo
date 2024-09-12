import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/view/home/company_info/widget_bids_list.dart';

Widget widgetBidsHeader(
  BuildContext context,
) {

  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    padding: EdgeInsets.only(
      top: screenHeight * 0.02,
      left: screenHeight * 0.02,
      right: screenHeight * 0.02,
      bottom: screenHeight * 0.02,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
            width: screenWidth * 0.43,
            padding: EdgeInsets.only(
              top: screenHeight * 0.02,
              left: screenHeight * 0.02,
              right: screenHeight * 0.02,
              bottom: screenHeight * 0.02,
            ),
            decoration: BoxDecoration(
              color: ColorViewConstants.colorHintRed,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('Bid price',
                          style: AppTextStyles.medium.copyWith(
                            fontSize: 14,
                            color: (ColorViewConstants.colorBlueSecondaryText),
                          )),
                      Text('Qty',
                          style: AppTextStyles.medium.copyWith(
                            fontSize: 14,
                            color: (ColorViewConstants.colorBlueSecondaryText),
                          )),
                    ]),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                widgetBidsList(context),
              ],
            )),
        Container(
            width: screenWidth * 0.43,
            padding: EdgeInsets.only(
              top: screenHeight * 0.02,
              left: screenHeight * 0.02,
              right: screenHeight * 0.03,
              bottom: screenHeight * 0.02,
            ),
            decoration: BoxDecoration(
              color: ColorViewConstants.colorHintRed,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('Offer price',
                          style: AppTextStyles.medium.copyWith(
                            fontSize: 14,
                            color: (ColorViewConstants.colorBlueSecondaryText),
                          )),
                      Text('Qty',
                          style: AppTextStyles.medium.copyWith(
                            fontSize: 14,
                            color: (ColorViewConstants.colorBlueSecondaryText),
                          )),
                    ]),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                widgetBidsList(context),
              ],
            )),
      ],
    ),
  );
}
