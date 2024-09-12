import 'package:flutter/cupertino.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

import '../../../model/transfers.dart';

Widget widgetChatReceiver(BuildContext context, Transfers? transfer) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  String amount = transfer!.transAmount! ?? '';
  String type = transfer.transCurrency ?? '';

  return Align(
    alignment: Alignment.topLeft,
    child: Container(
      width: screenWidth * 0.6,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          color: ColorViewConstants.colorWhite),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            type + ' ' + amount,
            style: AppTextStyles.medium.copyWith(
                color: ColorViewConstants.colorPrimaryText, fontSize: 16),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Text(
            StringViewConstants.paymentReceived,
            style: AppTextStyles.medium.copyWith(
                color: ColorViewConstants.colorPrimaryOpacityText80,
                fontSize: 14),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
                transfer?.createdAt ?? '',
              style: AppTextStyles.medium.copyWith(
                  color: ColorViewConstants.colorPrimaryOpacityText50,
                  fontSize: 13),
            ),
          )
        ],
      ),
    ),
  );
}
