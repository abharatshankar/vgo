import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_date_utils.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';

import '../../../../model/coin.dart';
import '../../../../utils/app_string_utils.dart';

Widget widgetOutBoundList(BuildContext context, List<Coin>? allCoinsList, {required Function(Coin coin) completion}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: allCoinsList?.length ?? 0,
    itemBuilder: (context, position) {

      final Coin coin = allCoinsList![position];

      String bankName = coin.bankName ?? '';
      String imagePath = coin.bankIconPath ??
          AppStringUtils.noImageUrlWallet;

     /* if (bankName.toLowerCase() == 'icici bank') {
        imagePath = 'assets/images/bank/icici_bank.png';
      } else if (bankName.toLowerCase() == 'axis bank') {
        imagePath = 'assets/images/bank/axis_bank.png';
      } else if (bankName.toLowerCase() == 'hdfc bank') {
        imagePath = 'assets/images/bank/hdfc_bank.jpg';
      } else if (bankName.toLowerCase() == 'google pay') {
        imagePath = 'assets/images/bank/gpay.png';
      } else if (bankName.toLowerCase() == 'paytm') {
        imagePath = 'assets/images/bank/paytm.jpg';
      } else if (bankName.toLowerCase() == 'phonepe') {
        imagePath = 'assets/images/bank/phonepe.jpg';
      }*/

      final String transferOrder = allCoinsList[position].transferOrder ?? '';
      var transAmount = StringBuffer();
      transAmount.write(allCoinsList[position].transCurrency ?? '');
      transAmount.write(' ');
      transAmount.write(allCoinsList[position].transAmount ?? '');

      String status = '';
      // Show status
      if ("Payment".toLowerCase() == coin.transType?.toLowerCase()) {
        if ("OUTBOUND".toLowerCase() == coin.transferOrder?.toLowerCase()) {
          status = 'Waiting';
         /* holder.binding.tvStatusOutBound.setTextColor(ContextCompat.getColor(mContext, R.color.color_green_dark));
          holder.binding.tvStatusOutBound.setVisibility(View.VISIBLE);*/
        } else if ("ACCEPT".toLowerCase() == coin.transferOrder?.toLowerCase()) {
          status = 'Accepted';
       /*   holder.binding.tvStatusOutBound.setTextColor(ContextCompat.getColor(mContext, R.color.color_green_dark));
          holder.binding.tvStatusOutBound.setVisibility(View.VISIBLE);*/
        } else if ("TRANSFER".toLowerCase() == coin.transferOrder?.toLowerCase()) {
         // holder.binding.tvStatusOutBound.setVisibility(View.GONE);
        } else if ("DONE".toLowerCase() == coin.transferOrder?.toLowerCase()) {
          //holder.binding.tvStatusOutBound.setVisibility(View.GONE);
        }
      } else if ("Receipt".toLowerCase() == coin.transType?.toLowerCase()) {
        if ("INBOUND".toLowerCase() == coin.transferOrder?.toLowerCase()) {
          //holder.binding.tvStatusOutBound.setVisibility(View.GONE);
        } else if ("DONE".toLowerCase() == coin.transferOrder?.toLowerCase()) {
          //holder.binding.tvStatusOutBound.setVisibility(View.GONE);
        }
      }else{
        //loggerNoStack.e("condition - success");
      }

      return InkWell(
        onTap: () {
          completion(coin);
          /*Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InboundOutboundTransferConfirmView(
                coin: coin,
              ),
            ),
          );*/
        },

        child: Container(
          color: ColorViewConstants.colorWhite,
          margin: EdgeInsets.only(bottom: 5),
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.025,
            horizontal: screenHeight * 0.03,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: screenWidth * 0.13,
                child: Image.network(
                  imagePath,
                  width: 35,
                  height: 35,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bankName,
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 14,
                          color: ColorViewConstants.colorPrimaryText,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.002),
                      Text(
                        coin.accountNumber ?? '',
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 14,
                          color: ColorViewConstants.colorPrimaryOpacityText80,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.22,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (transferOrder.isNotEmpty)
                      Text(
                        transferOrder,
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 14,
                          color: ColorViewConstants.colorGreen,
                        ),
                      ),
                    SizedBox(height: screenHeight * 0.005),
                    Text(
                      AppDateUtils.getMonthInText(
                            coin.createdAt.toString(),
                            coin.updatedAt.toString(),
                          ) +
                          ' ' +
                          AppDateUtils.extractTimeFromDateTime(
                            coin.createdAt.toString(),
                            coin.updatedAt.toString(),
                          ),
                      style: AppTextStyles.regular.copyWith(
                        fontSize: 13,
                        color: ColorViewConstants.colorPrimaryOpacityText80,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
