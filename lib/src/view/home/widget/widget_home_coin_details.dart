import 'package:flip_card/flip_card.dart';
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

  return FlipCard(
    direction: FlipDirection.HORIZONTAL,
    front: Container(
      alignment: Alignment.center,
      width: 250.0,
      height: 250.0,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.fromLTRB(25, 5, 15, 0),
      decoration: BoxDecoration(
        // image: DecorationImage(
        //   image: AssetImage("assets/images/home/coin_new.png"),
        //   fit: BoxFit.cover,
        // ),
        border: Border.all(color: ColorViewConstants.colorRed,width: 4),
          color: ColorViewConstants.colorBlueSecondaryText,
          shape: BoxShape.circle,),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
          Text(
            'C ${AppStringUtils.emptyString(coin?.totalCoins)}',
            style: AppTextStyles.semiBold
                .copyWith(color: ColorViewConstants.colorCyan, fontSize: 16),
          ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
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
      ),
    ),
    back: Container(
      alignment: Alignment.center,
      width: 250.0,
      height: 250.0,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.fromLTRB(25, 5, 15, 0),
      decoration: BoxDecoration(
        // image: DecorationImage(
        //   image: AssetImage("assets/images/home/coin_new.png"),
        //   fit: BoxFit.cover,
        // ),
        border: Border.all(color: ColorViewConstants.colorRed,width: 4),
        color: ColorViewConstants.colorBlueSecondaryText,
        shape: BoxShape.circle,),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Text(
          //   StringViewConstants.coinsFundsVolume,
          //   style: AppTextStyles.regular
          //       .copyWith(color: ColorViewConstants.colorWhite, fontSize: 15),
          // ),
          // SizedBox(
          //   height: screenHeight * 0.01,
          // ),
          Text(
            'C ${AppStringUtils.emptyString(coin?.coinValue)}',
            style: AppTextStyles.semiBold
                .copyWith(color: ColorViewConstants.colorCyan, fontSize: 35),
          ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
          Text(
            '\$ ${AppStringUtils.emptyString(coin?.ledgerAmount)}',
            style: AppTextStyles.semiBold
                .copyWith(color: ColorViewConstants.colorCyan, fontSize: 17),
          ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
          Text(
            'C ${AppStringUtils.emptyString(coin?.totalCoins)}',
            style: AppTextStyles.semiBold
                .copyWith(color: ColorViewConstants.colorCyan, fontSize: 17),
          ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.horizontal,
            children: [
              Text(
                StringViewConstants.back,
                style: AppTextStyles.regular.copyWith(
                    color: ColorViewConstants.colorYellow, fontSize: 12),
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
          )
        ],
      ),
    ),
  );
}
