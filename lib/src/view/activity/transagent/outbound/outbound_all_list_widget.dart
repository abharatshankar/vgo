import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

import '../../../../model/coin.dart';
import '../../../../utils/app_date_utils.dart';
import '../../../../utils/app_string_utils.dart';
import '../../../../utils/utils.dart';
import '../../../services/inbound_outbound_transfer_confirm_view.dart';

Widget widgetOutBoundAllList(BuildContext context, List<Coin>? allCoinsList,) {
  double screenWidth = MediaQuery
      .of(context)
      .size
      .width;
  double screenHeight = MediaQuery
      .of(context)
      .size
      .height;

  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: allCoinsList?.length,
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

      String status = '';
      Color? statusColor = ColorViewConstants.colorPrimaryText;
      // Show status
      if ("Payment".toLowerCase() == coin.transType?.toLowerCase()) {
        if ("OUTBOUND".toLowerCase() == coin.transferOrder?.toLowerCase()) {
          status = 'Waiting';
          statusColor = ColorViewConstants.colorGray;
          /* holder.binding.tvStatusOutBound.setTextColor(ContextCompat.getColor(mContext, R.color.color_green_dark));
          holder.binding.tvStatusOutBound.setVisibility(View.VISIBLE);*/
        } else if ("ACCEPT".toLowerCase() == coin.transferOrder?.toLowerCase()) {
          status = 'Accepted';
          statusColor = ColorViewConstants.colorYellow;
          /*   holder.binding.tvStatusOutBound.setTextColor(ContextCompat.getColor(mContext, R.color.color_green_dark));
          holder.binding.tvStatusOutBound.setVisibility(View.VISIBLE);*/
        } else if ("TRANSFER".toLowerCase() == coin.transferOrder?.toLowerCase()) {
          // holder.binding.tvStatusOutBound.setVisibility(View.GONE);
          status = 'Transferred';
          statusColor = ColorViewConstants.colorGreen;
        } else if ("DONE".toLowerCase() == coin.transferOrder?.toLowerCase()) {
          //holder.binding.tvStatusOutBound.setVisibility(View.GONE);
          statusColor = ColorViewConstants.colorBlueSecondaryText;
        }
      } else if ("Receipt".toLowerCase() == coin.transType?.toLowerCase()) {
        if ("INBOUND".toLowerCase() == coin.transferOrder?.toLowerCase()) {
          //holder.binding.tvStatusOutBound.setVisibility(View.GONE);
        } else if ("DONE".toLowerCase() == coin.transferOrder?.toLowerCase()) {
          //holder.binding.tvStatusOutBound.setVisibility(View.GONE);
        }
      }else{
        loggerNoStack.e("condition - success");
      }

      final String transferOrder = allCoinsList[position].transferOrder ?? '';
      var transAmount = StringBuffer();
      transAmount.write(allCoinsList[position].transCurrency ?? '');
      transAmount.write(' ');
      transAmount.write(allCoinsList[position].transAmount ?? '');

      return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        InboundOutboundTransferConfirmView(coin: allCoinsList[position],)));
          },
          child: Container(
            color: ColorViewConstants.colorWhite,
            margin: EdgeInsets.only(bottom: 5),
            padding: EdgeInsets.only(
                top: screenHeight * 0.025,
                bottom: screenHeight * 0.025,
                left: screenHeight * 0.02,
                right: screenHeight * 0.02),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        allCoinsList[position].bankName ?? '',
                        style: AppTextStyles.medium.copyWith(
                            fontSize: 14,
                            color: ColorViewConstants.colorLightBlack),
                      ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            allCoinsList[position].accountNumber ?? '',
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 14,
                          color: ColorViewConstants.colorLightBlack,
                        ),
                      ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            transAmount.toString(),
                            style: AppTextStyles.medium.copyWith(
                              fontSize: 14,
                          color: ColorViewConstants.colorBlack,
                        ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.005,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            status.toUpperCase(),
                        style: AppTextStyles.regular.copyWith(
                          fontSize: 12,
                          color: statusColor,
                        ),
                      ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.005,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            AppDateUtils.getMonthInText(
                                allCoinsList[position].createdAt.toString(),
                                allCoinsList[position].updatedAt.toString()),
                            style: AppTextStyles.regular.copyWith(
                              fontSize: 13,
                              color: ColorViewConstants.colorPrimaryOpacityText50,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
      );
    },
  );
}
