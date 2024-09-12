import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/model/coin.dart';
import 'package:vgo_flutter_app/src/utils/app_string_utils.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

Widget widgetWalletReceiptList(BuildContext context, List<Coin>? allCoinsList) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: allCoinsList?.length,
    itemBuilder: (context, position) {
      return Container(
        margin: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
        padding: EdgeInsets.only(
            top: screenHeight * 0.02,
            left: screenHeight * 0.02,
            right: screenHeight * 0.01,
            bottom: screenHeight * 0.02),
        decoration: BoxDecoration(
            color: ColorViewConstants.colorWhite,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: screenWidth * 0.13,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network(
                    AppStringUtils.noImageUrlWallet,
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    allCoinsList![position].transType! +
                        "@" +
                        allCoinsList[position].subTransType!,
                    style: AppTextStyles.medium.copyWith(
                      fontSize: 15,
                      color: ColorViewConstants.colorBlueSecondaryText,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.001,
                  ),
                  Visibility(
                    visible: allCoinsList[position].receiverName != null
                        ? true
                        : false,
                    child: Text(
                      StringUtils.capitalize(
                              allCoinsList[position].receiverName ?? '') ??
                          '',
                      style: AppTextStyles.medium.copyWith(
                        fontSize: 13,
                        color: ColorViewConstants.colorLightBlack,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.001,
                  ),
                  Text(
                    allCoinsList[position].createdAt!,
                    style: AppTextStyles.regular.copyWith(
                      fontSize: 13,
                      color: ColorViewConstants.colorHintGray,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                width: screenWidth * 0.2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        allCoinsList[position].loyaltyCoins!,
                        style: AppTextStyles.semiBold.copyWith(
                          fontSize: 14,
                          color: ColorViewConstants.colorPrimaryTextMedium,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.005,
                      ),
                      Text(
                        allCoinsList[position].transAmount!,
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 14,
                          color: ColorViewConstants.colorPrimaryTextHint,
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
