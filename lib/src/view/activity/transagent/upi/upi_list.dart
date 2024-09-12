import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

import '../../../../model/coin.dart';
import '../../../../utils/app_date_utils.dart';
import '../../../../utils/app_string_utils.dart';

Widget widgetUpiList(BuildContext context, List<Coin>? allCoinsList,
    {required Function(String status) completion}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Expanded(
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: allCoinsList?.length,
      itemBuilder: (context, position) {
        String bankName = allCoinsList![position].bankName ?? '';
        String upiName = allCoinsList[position].upiName ?? '';
        String imagePath = allCoinsList[position].bankIconPath ??
            AppStringUtils.noImageUrlWallet;

        /* if (bankName.toLowerCase() == 'icici bank') {
          imagePath = 'assets/images/bank/icici_bank.png';
        } else if (bankName.toLowerCase() == 'axis bank') {
          imagePath = 'assets/images/bank/axis_bank.png';
        } else if (bankName.toLowerCase() == 'hdfc bank') {
          imagePath = 'assets/images/bank/hdfc_bank.jpg';
        } else if (bankName.toLowerCase() == 'paytm') {
          imagePath = 'assets/images/bank/paytm.jpg';
        } else if (bankName.toLowerCase() == 'phonepe') {
          imagePath = 'assets/images/bank/phonepe.jpg';
        } else if (bankName.toLowerCase() == 'google pay') {
          imagePath = 'assets/images/bank/gpay.png';
        }
*/
        return Padding(
          padding: EdgeInsets.only(
              top: screenHeight * 0.02,
              bottom: screenHeight * 0.00,
              right: screenHeight * 0.01,
              left: screenHeight * 0.01),
          child: Container(
            color: ColorViewConstants.colorWhite,
            padding: EdgeInsets.only(
                top: screenHeight * 0.02,
                bottom: screenHeight * 0.02,
                left: screenHeight * 0.02,
                right: screenHeight * 0.01),
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
                      Visibility(
                        visible: false,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: ColorViewConstants.colorBlueSecondaryText,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              'IB',
                              style: AppTextStyles.medium.copyWith(
                                fontSize: 14,
                                color: ColorViewConstants.colorWhite,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                          visible: true,
                          child: Image.network(
                            imagePath,
                            width: 35,
                            height: 35,
                          ))
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          allCoinsList[position].bankName ??
                              allCoinsList[position].upiName!,
                          style: AppTextStyles.medium.copyWith(
                              fontSize: 14,
                              color: ColorViewConstants.colorPrimaryText),
                        ),
                        Visibility(
                          visible: false,
                          child: Text(
                            allCoinsList[position].country ?? '',
                            style: AppTextStyles.medium.copyWith(
                              fontSize: 14,
                              color: ColorViewConstants.colorPrimaryText,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.002,
                        ),
                        Text(
                          allCoinsList[position].accountNumber!,
                          style: AppTextStyles.medium.copyWith(
                            fontSize: 14,
                            color: ColorViewConstants.colorPrimaryTextHint,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.002,
                        ),
                        Text(
                          allCoinsList[position].accountHolderName!,
                          style: AppTextStyles.medium.copyWith(
                            fontSize: 14,
                            color: ColorViewConstants.colorPrimaryTextHint,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        completion(allCoinsList[position].id.toString());
                      },
                      child: Image.asset(
                        'assets/images/kyc/delete.png',
                        width: 25,
                        height: 25,
                        color: ColorViewConstants.colorBrightRed,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppDateUtils.getMonthInText(
                          allCoinsList[position].createdAt.toString(),
                          allCoinsList[position].updatedAt.toString()),
                      style: AppTextStyles.regular.copyWith(
                        fontSize: 13,
                        color: ColorViewConstants.colorPrimaryTextHint,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    ),
  );
}
