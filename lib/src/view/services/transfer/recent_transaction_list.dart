import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/model/transfers.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';
import 'package:vgo_flutter_app/src/view/services/transfer/transfer_chat_view.dart';

import '../../../utils/app_string_utils.dart';

Widget recentTransactionList(
    BuildContext context, List<Transfers>? transferList, String transferType, {String userName = '', bool isMobileTransfer = false}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

/*  loggerNoStack.e('recentTransactionList transferList:  ' + transferList!.length.toString());
  loggerNoStack.e('recentTransactionList transferType $transferType');*/

  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
   // itemCount: transferList?.length ?? 0,
    itemCount: transferList?.length,
    itemBuilder: (context, position) {
      Transfers? transfers = transferList?[position];

      String name = '';
      String number = '';
      String fNameLName = '';

     // loggerNoStack.e('recentTransactionList receiverUserName'  + transfers!.receiverUserName!);

      if (transferType == 'mobile') {
        if(userName == transfers!.receiverUserName!){
          name = transfers.transfererName ?? '';
          number = transfers.transfererMobileNumber ?? '';
        } else {
          name = transfers.receiverName ?? '';
          number = transfers.receiverMobileNumber ?? '';
        }
      } else if (transferType.toUpperCase() == 'BANK') {
        // loggerNoStack.e('Split name BANK');
        name = transfers!.receiverUserName ?? '';
        number = transfers.accountNumber ?? '';
      } else if (transferType == 'UPI') {
        loggerNoStack.e('recentTransactionList receiverUserName' +
            transfers!.receiverUserName!);
        name = transfers!.receiverUserName ?? '';
        number = transfers.accountNumber ?? '';
      } else if (transferType == 'VGO') {
        name = transfers!.receiverName ?? '';
        number = transfers.accountNumber ?? '';
      } else {
        /*    name = transfers!.receiverUserName ?? '';
        number = transfers.accountNumber ?? '';*/
      }

      //loggerNoStack.e('Split name $name');
      if (name.contains(' ')) {
        var arrayName = name.split(' ');
        fNameLName = StringUtils.capitalize(arrayName[0].substring(0, 1));
        fNameLName = fNameLName +
            (arrayName.length > 1
                ? StringUtils.capitalize(arrayName[1].substring(0, 1))
                : '');
      } else {
        fNameLName = StringUtils.capitalize(name.substring(0, 1));
      }

      return InkWell(
        onTap: () {
          if (transferType != 'VGO') {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TransferChatView(isMobileTransfer: isMobileTransfer,
                          transfers: transferList?[position],
                        ))).then((val)=>val?'':'');
          } else {
            loggerNoStack.e('Transfer type is ' + transferType);
          }
        },
        child: Container(
          color: ColorViewConstants.colorWhite,
          padding: EdgeInsets.only(
              top: screenHeight * 0.02,
              bottom: screenHeight * 0.01,
              left: screenHeight * 0.02,
              right: screenHeight * 0.02),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(transfers!.colorCode!).withOpacity(1.0),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    fNameLName,
                    style: AppTextStyles.semiBold.copyWith(
                      fontSize: 16,
                      color: ColorViewConstants.colorWhite,
                    ),
                  ),
                ),
              ),
              // SizedBox(width: screenWidth * 0.03),
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      StringUtils.capitalize(name),
                      style: AppTextStyles.medium.copyWith(
                          fontSize: 14,
                          color: ColorViewConstants.colorPrimaryText),
                    ),
                    Visibility(
                        visible:
                           // (transferList?[position].receiverMobileNumber ?? '')
                              (number).isNotEmpty,
                        child: Wrap(
                          children: [
                            SizedBox(
                              height: screenHeight * 0.001,
                            ),
                            Text(
                              number,
                              //  transferList?[position].receiverMobileNumber ?? '',
                              style: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorPrimaryText),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: screenHeight * 0.001,
                    ),
                    Text(
                      '${transferList?[position].transCurrency! ?? ''} ${transferList?[position].transAmount! ?? ''} transferred successfully ',
                      style: AppTextStyles.regular.copyWith(
                        fontSize: 12,
                        color: ColorViewConstants.colorPrimaryTextHint,
                      ),
                    ),
                    Visibility(
                      visible: false,
                      child: Row(
                        children: [
                          Text(
                            StringUtils.capitalize(
                                    transferList?[position].receiverName ?? ''),
                            style: AppTextStyles.medium.copyWith(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.34),
                          Text(
                              AppStringUtils.subStringDate(transferList?[position]
                                    .createdAt
                                    .toString()) ??
                                    '',
                            style: AppTextStyles.regular.copyWith(
                              fontSize: 10,
                              color: ColorViewConstants.colorGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      AppStringUtils.subStringDate(
                          transferList?[position].createdAt.toString()) ??
                          '',

                      style: AppTextStyles.medium.copyWith(
                        fontSize: 12,
                        color: ColorViewConstants.colorPrimaryTextHint,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    SvgPicture.asset(
                      'assets/images/services/right_arrow.svg',
                      width: 23,
                      height: 23,
                      color: ColorViewConstants.colorPrimaryOpacityText50,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}


