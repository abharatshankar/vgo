import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/view/home/company_info/widget_buy.dart';

Widget widgetBidTransactionList(
  BuildContext context,
) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: 10,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, position) {
      return Container(
        padding: EdgeInsets.only(
          top: screenHeight * 0.01,
          left: screenHeight * 0.02,
          right: screenHeight * 0.01,
          bottom: screenHeight * 0.01,
        ),
        decoration: BoxDecoration(
          color: ColorViewConstants.colorWhite,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'VPAY',
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 14,
                  ),
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Ref:',
                          style: AppTextStyles.regular.copyWith(
                              color: ColorViewConstants.colorGray,
                              fontSize: 12)),
                      TextSpan(
                          text: '  123453768933',
                          style: AppTextStyles.medium.copyWith(
                              color: ColorViewConstants.colorBlack,
                              fontSize: 12)),
                    ])),
              ],
            ),
            SizedBox(
              height: screenWidth * 0.01,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                widgetBuy(context),
                SizedBox(
                  width: screenWidth * 0.02,
                ),
                Text(
                  '\$154.30',
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.55,
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Qty:',
                          style: AppTextStyles.regular.copyWith(
                              color: ColorViewConstants.colorGray,
                              fontSize: 13)),
                      TextSpan(
                          text: '  10',
                          style: AppTextStyles.medium.copyWith(
                              color: ColorViewConstants.colorBlack,
                              fontSize: 13)),
                    ])),
              ],
            ),
            SizedBox(
              height: screenWidth * 0.01,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  '2024-03-06 12:13:46',
                  style: AppTextStyles.medium.copyWith(
                      fontSize: 12, color: ColorViewConstants.colorGray),
                ),
                Text(
                  '\$1,543.00',
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
