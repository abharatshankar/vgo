import 'package:flutter/cupertino.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/view/home/widget/coin/widget_about_coin_list.dart';
import 'package:vgo_flutter_app/src/view/home/widget/coin/widget_treasury_list.dart';

import '../../../../model/coin.dart';

Widget widgetCoinTreasury(BuildContext context, List<Coin>? allCoinsList, List<String>? aboutList) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
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
              Align(
                child: Text(
                  textAlign: TextAlign.center,
                  'Date Time',
                  style: AppTextStyles.medium.copyWith(
                      fontSize: 14,
                      color: ColorViewConstants.colorBlueSecondaryText),
                ),
              ),
              Align(
                child: Text(
                  'Amount',
                  style: AppTextStyles.medium.copyWith(
                      fontSize: 14,
                      color: ColorViewConstants.colorBlueSecondaryText),
                ),
              ),
              Align(
                child: Text(
                  'Volume',
                  style: AppTextStyles.medium.copyWith(
                      fontSize: 14,
                      color: ColorViewConstants.colorBlueSecondaryText),
                ),
              ),
              Align(
                  child: Text(
                'Coin',
                style: AppTextStyles.medium.copyWith(
                    fontSize: 14,
                    color: ColorViewConstants.colorBlueSecondaryText),
              )),
            ],
          ),
          widgetTreasuryList(context, allCoinsList),
        ],
      ),
    ),
  );
}
