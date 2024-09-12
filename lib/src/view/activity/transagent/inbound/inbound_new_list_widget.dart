import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

import '../../../../model/coin.dart';
import '../../../../utils/app_date_utils.dart';
import '../../../../utils/app_string_utils.dart';
import '../../../services/inbound_outbound_transfer_confirm_view.dart';

Widget widgetInboundNewList(BuildContext context, List<Coin>? allCoinsList, {required Function(Coin coin) completion}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return  ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: allCoinsList?.length ?? 0,
      itemBuilder: (context, position) {
      Coin? coin = allCoinsList?[position];
      String currencyType = coin?.transCurrency ?? '';
      String amount = coin?.transAmount ?? '';
      String currency = currencyType + ' ' + amount;
      String bankName = coin?.bankName ?? '';
      String imagePath = coin?.bankIconPath ??
          AppStringUtils.noImageUrlWallet;

     /* if (bankName.toLowerCase() == 'icici bank') {
        imagePath = 'assets/images/bank/icici_bank.png';
      } else if (bankName.toLowerCase() == 'axis bank') {
        imagePath = 'assets/images/bank/axis_bank.png';
      } else if (bankName.toLowerCase() == 'hdfc bank') {
        imagePath = 'assets/images/bank/hdfc_bank.jpg';
      }else if (bankName.toLowerCase() == 'hdfc bank') {
        imagePath = 'assets/images/bank/hdfc_bank.jpg';
      } else if (bankName.toLowerCase() == 'paytm') {
        imagePath = 'assets/images/bank/paytm.jpg';
      } else if (bankName.toLowerCase() == 'phonepe') {
        imagePath = 'assets/images/bank/phonepe.jpg';
      } else if (bankName.toLowerCase() == 'google pay') {
        imagePath = 'assets/images/bank/gpay.png';
      }*/

      return InkWell(
        onTap: () {
        /*  Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InboundOutboundTransferConfirmView(
                coin: allCoinsList![position], // Asserting non-null
              ),
            ),
          );*/
        },
        child: Container(
          color: ColorViewConstants.colorWhite,
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          padding: EdgeInsets.only(
            top: screenHeight * 0.02,
            left: screenWidth * 0.02,
            right: screenWidth * 0.01,
            bottom: screenHeight * 0.02,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
              SizedBox(
                width: screenWidth * 0.55,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coin?.bankName ?? '',
                      style: AppTextStyles.medium.copyWith(
                        fontSize: 14,
                        color: ColorViewConstants.colorLightBlack,
                      ),
                    ),
                    Text(
                      coin?.accountNumber ?? '',
                      style: AppTextStyles.medium.copyWith(
                        fontSize: 13,
                        color: ColorViewConstants.colorLightBlack,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: screenWidth * 0.22,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      currency,
                      style: AppTextStyles.medium.copyWith(
                        fontSize: 14,
                        color: ColorViewConstants.colorLightBlack,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.005,
                    ),
                    InkWell(
                      onTap: (){
                        completion(coin!);
                      },
                      child: Text(
                        'Confirm',
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 14,
                          color: ColorViewConstants.colorGreen,
                        ),
                      ),
                    )
                    ,
                    SizedBox(
                      height: screenHeight * 0.005,
                    ),
                    Text(
                      AppDateUtils.getTimeAgo(coin!.createdAt!, coin.updatedAt!) ,
                      style: AppTextStyles.regular.copyWith(
                        fontSize: 13,
                        color: ColorViewConstants.colorGray,
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
