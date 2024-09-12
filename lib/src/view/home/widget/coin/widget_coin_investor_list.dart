import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';

import '../../../../model/company.dart';

Widget widgetCoinInvestorList(
    BuildContext context, List<Company>? allTreasuryList) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: allTreasuryList?.length,
    itemBuilder: (context, position) {
      return Container(
        margin: const EdgeInsets.only(top: 0, left: 5, right: 5, bottom: 10),
        padding: EdgeInsets.only(
            top: screenHeight * 0.02,
            left: screenHeight * 0.02,
            right: screenHeight * 0.01,
            bottom: screenHeight * 0.02),
        decoration: BoxDecoration(
            color: ColorViewConstants.colorWhite,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: screenWidth * 0.14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                        color: ColorViewConstants.colorBlueSecondaryText,
                        borderRadius: BorderRadius.circular(30)),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          allTreasuryList![position].symbol.toString(),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bold.copyWith(
                            fontSize: 14,
                            color: ColorViewConstants.colorWhite,
                          ),
                        )),
                  )
                  ],
                ),
              ),
              SizedBox(
                width: screenWidth * 0.03,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  Text(
                    allTreasuryList[position].companyName!,
                    style: AppTextStyles.medium.copyWith(
                      fontSize: 14,
                      color: ColorViewConstants.colorBlack,
                    ),
                  ),
                  Text(
                    allTreasuryList[position].investmentAmount!,
                    style: AppTextStyles.medium.copyWith(
                      fontSize: 13,
                      color: ColorViewConstants.colorGray,
                    ),
                  ),
                  Text(
                    allTreasuryList[position].stockQuantity!,
                    style: AppTextStyles.medium.copyWith(
                      fontSize: 13,
                      color: ColorViewConstants.colorGray,
                    ),
                  ),
                ],
                ),
              ),
              SizedBox(
                  width: screenWidth * 0.15,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                      Visibility(
                          visible: true,
                          child: Text(
                            '',
                            style: AppTextStyles.regular.copyWith(
                              fontSize: 13,
                              color: ColorViewConstants.colorLightBlack,
                            ),
                          )),
                      Text(
                        allTreasuryList[position].currentPrice! ?? '',
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 13,
                          color: ColorViewConstants.colorGreen,
                        ),
                      ),
                      // SizedBox(height: screenHeight * 0.01,),
                      Text(
                        allTreasuryList[position].buyingPrice!,
                        style: AppTextStyles.regular.copyWith(
                          fontSize: 13,
                          color: ColorViewConstants.colorRed,
                        ),
                      ),
                    ],
                    ),
                  )),
            ],
          ),
        );
      },
  );
}
