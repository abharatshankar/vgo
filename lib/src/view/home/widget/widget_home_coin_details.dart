import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/model/coin.dart';
import 'package:vgo_flutter_app/src/model/response/coin_detail.dart';
import 'package:vgo_flutter_app/src/utils/app_string_utils.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

import '../coin_detail_view.dart';

Widget widgetHomeCoinDetails(BuildContext context, CoinDetail? coin) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    width: screenWidth,
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
        color: ColorViewConstants.colorBlueSecondaryText,
        borderRadius: BorderRadius.circular(15)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          StringViewConstants.coinsFundsVolume,
          style: AppTextStyles.regular
              .copyWith(color: ColorViewConstants.colorWhite, fontSize: 15),
        ),
        SizedBox(
          height: screenHeight * 0.01,
        ),
        Text(
          'C ${AppStringUtils.emptyString(coin?.coinValue)}',
          style: AppTextStyles.semiBold
              .copyWith(color: ColorViewConstants.colorCyan, fontSize: 16),
        ),
        SizedBox(
          height: screenHeight * 0.005,
        ),
        Text(
          '\$ ${AppStringUtils.emptyString(coin?.ledgerAmount)}',
          style: AppTextStyles.semiBold
              .copyWith(color: ColorViewConstants.colorCyan, fontSize: 16),
        ),
        SizedBox(
          height: screenHeight * 0.005,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'C ${AppStringUtils.emptyString(coin?.totalCoins)}',
              style: AppTextStyles.semiBold
                  .copyWith(color: ColorViewConstants.colorCyan, fontSize: 16),
            ),
            const Spacer(),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CoinDetailView(
                          )));
                },
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  direction: Axis.horizontal,
                  children: [
                    Text(
                      StringViewConstants.knowMore,
                      style: AppTextStyles.regular.copyWith(
                          color: ColorViewConstants.colorYellow, fontSize: 13),
                    ),
                    SizedBox(
                      width: screenWidth * 0.01,
                    ),
                    SvgPicture.asset(
                      'assets/images/home/right_icon.svg',
                      width: 20,
                      height: 20,
                      color: ColorViewConstants.colorYellow,
                    ),
                  ],
                ))
          ],
        )
      ],
    ),
  );
}
