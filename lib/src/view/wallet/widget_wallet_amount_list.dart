import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

import '../../model/wallet.dart';
import '../../utils/app_date_utils.dart';

Widget widgetWalletAmountList(BuildContext context, List<Wallet>? walletList) {
  double screenWidth = MediaQuery
      .of(context)
      .size
      .width;
  double screenHeight = MediaQuery
      .of(context)
      .size
      .height;

  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: walletList?.length,
    shrinkWrap: true,
    itemBuilder: (context, position) {
      return Container(
        margin: const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
        padding: EdgeInsets.only(
            top: screenHeight * 0.02,
            left: screenHeight * 0.02,
            right: screenHeight * 0.0,
            bottom: screenHeight * 0.01),
        decoration: BoxDecoration(
            color: ColorViewConstants.colorYellow,
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: screenWidth * 0.15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          textAlign: TextAlign.center,
                          'INR',
                          style: AppTextStyles.medium.copyWith(
                            fontSize: 14,
                            color: ColorViewConstants.colorLightBlack,
                          ),
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
              width: screenWidth * 0.38,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    walletList![position].quantity!,
                    style: AppTextStyles.medium.copyWith(
                      fontSize: 14,
                      color: ColorViewConstants.colorWhite,
                    ),
                  ),
                  Text(
                    walletList[position].quantityHold ?? '0',
                    style: AppTextStyles.medium.copyWith(
                      fontSize: 14,
                      color: ColorViewConstants.colorWhite,
                    ),
                  ),
                  Text(
                    AppDateUtils.getTimeAgo(walletList[position].createdAt!, walletList[position].updatedAt!) ,
                    style: AppTextStyles.regular.copyWith(
                      fontSize: 12,
                      color: ColorViewConstants.colorWhite,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

