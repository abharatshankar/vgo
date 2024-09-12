import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';

import '../../../../model/coin.dart';
import '../../../../utils/app_string_utils.dart';
import '../../../services/inbound_outbound_transfer_confirm_view.dart';

Widget widgetInBoundList(BuildContext context, List<Coin>? allCoinsList,) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: allCoinsList?.length,
      itemBuilder: (context, position) {

        String imagePath = allCoinsList![position].bankIconPath ??
            AppStringUtils.noImageUrlWallet;
        return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => InboundOutboundTransferConfirmView()));
            },
            child: Padding(
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
                    SizedBox(
                      width: screenWidth * 0.50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                allCoinsList?[position].bankName ?? '',
                                style: AppTextStyles.medium.copyWith(
                                    fontSize: 14,
                                    color: ColorViewConstants.colorLightBlack),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                allCoinsList?[position].accountNumber ?? '',
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
                      width: screenWidth * 0.19,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                allCoinsList![position].transAmount!,
                                style: AppTextStyles.medium.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorLightBlack,
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
                                allCoinsList[position].transferOrder!,
                                style: AppTextStyles.medium.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorGreen,
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
                                AppStringUtils.subStringDate(
                                        allCoinsList[position]
                                            .createdAt
                                            .toString()) ??
                                    '',
                                style: AppTextStyles.regular.copyWith(
                                  fontSize: 13,
                                  color: ColorViewConstants.colorGray,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
  );
}
