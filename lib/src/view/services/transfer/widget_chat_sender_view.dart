import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

import '../../../model/transfers.dart';

Widget widgetChatSender(
    BuildContext context, Transfers? transfer, int radioSelectedValue,
bool isMobileTransfer,
    {required Function(int status, Transfers transferred) completion}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  String amount = transfer!.transAmount! ?? '';
  String type = transfer.transCurrency ?? '';

  bool isRadioButtonsRequired = transfer.transfer_order != null
      ? transfer.transfer_order!.toLowerCase() != 'done' && !isMobileTransfer
      : false;

  String comments = transfer.comments != null ? transfer.comments! : '';

  return Align(
    alignment: Alignment.topRight,
    child: Container(
      width: screenWidth * 0.6,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          color: ColorViewConstants.colorChatBackground),
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
            StringViewConstants.paymentTo + ' ' + transfer.receiverName! ?? '',
            style: AppTextStyles.medium.copyWith(
                color: ColorViewConstants.colorPrimaryOpacityText80,
                fontSize: 14),
          ),
          Visibility(
              visible: comments.isNotEmpty,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    comments,
                    style: AppTextStyles.medium.copyWith(
                        color: ColorViewConstants.colorPrimaryOpacityText80,
                        fontSize: 13),
                  )
                ],
              )),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              transfer.createdAt ?? '',
              style: AppTextStyles.medium.copyWith(
                  color: ColorViewConstants.colorPrimaryOpacityText50,
                  fontSize: 13),
            ),
          ),
          Visibility(
              visible: isRadioButtonsRequired,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.05,
                      child: RadioListTile(
                          title: Text(
                            'Matched',
                            style: AppTextStyles.medium.copyWith(
                                color: ColorViewConstants.colorPrimaryText,
                                fontSize: 11),
                          ),
                          value: 1,
                          groupValue: radioSelectedValue,
                          onChanged: (value) {
                            completion(value!, transfer);
                          }),
                    ),
                    SizedBox(
                        height: screenHeight * 0.05,
                        child: RadioListTile(
                            title: Text(
                              'Not Matched',
                              style: AppTextStyles.medium.copyWith(
                                  color: ColorViewConstants.colorPrimaryText,
                                  fontSize: 11),
                            ),
                            value: 2,
                            groupValue: radioSelectedValue,
                            onChanged: (value) {
                              completion(value!, transfer);
                            })),
                    SizedBox(
                        height: screenHeight * 0.05,
                        child: RadioListTile(
                            title: Text(
                              'Fake Receipt',
                              style: AppTextStyles.medium.copyWith(
                                  color: ColorViewConstants.colorPrimaryText,
                                  fontSize: 11),
                            ),
                            value: 3,
                            groupValue: radioSelectedValue,
                            onChanged: (value) {
                              completion(value!, transfer);
                            })),
                  ],
                ),
              ))
        ],
      ),
    ),
  );
}
