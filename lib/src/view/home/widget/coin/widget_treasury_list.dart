import 'package:flutter/cupertino.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_string_utils.dart';

import '../../../../model/coin.dart';

Widget widgetTreasuryList(BuildContext context, List<Coin>? allCoinsList) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: allCoinsList?.length,
      itemBuilder: (context, position) {
        return Container(
          padding: EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    AppStringUtils.subStringDate(allCoinsList![position].createdAt.toString()) ?? '',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.regular.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        allCoinsList[position].coinValue.toString(),
                        style: AppTextStyles.regular.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.002,
                      ),
                      Text(
                        allCoinsList[position].ledgerAmount.toString(),
                        style: AppTextStyles.regular.copyWith(
                            fontSize: 13, color: ColorViewConstants.colorRed),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        allCoinsList[position].coinVolume.toString(),
                        style: AppTextStyles.regular.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.002,
                      ),
                      Text(
                        allCoinsList[position].totalAmount.toString(),
                        style: AppTextStyles.regular.copyWith(
                            fontSize: 13, color: ColorViewConstants.colorRed),
                      ),
                    ],
                  ),
                  Text(
                    allCoinsList[position].totalCoinVolume.toString(),
                    style: AppTextStyles.regular.copyWith(
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      });
}
