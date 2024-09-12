import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vgo_flutter_app/src/model/transfers.dart';
import 'package:vgo_flutter_app/src/utils/app_date_utils.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';
import 'package:vgo_flutter_app/src/view/services/transfer/transfer_chat_view.dart';
import 'package:vgo_flutter_app/src/view/services/vgo_wallet_transfer/vgo_wallet_transaction_list_view.dart';

import '../../../constants/color_view_constants.dart';
import '../../../utils/app_text_style.dart';

class TransactionSuccessView extends StatefulWidget {
  TransactionSuccessView(
      {super.key,
      required this.isMobileTransfer,
      required this.isAdminTransfer,
      required this.transfers,
      required this.status,
      required this.navigationFrom});

  bool isMobileTransfer;
  bool isAdminTransfer;
  String status;
  String navigationFrom;
  Transfers? transfers;

  @override
  State<TransactionSuccessView> createState() => _TransactionSuccessState();
}

class _TransactionSuccessState extends State<TransactionSuccessView> {
  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  void initState() {
    super.initState();
    FocusManager.instance.primaryFocus?.unfocus();
    loggerNoStack
        .e('Transaction success page ' + widget.isMobileTransfer.toString());
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    String name = widget.transfers!.name ?? '';
    String currencyType = widget.transfers!.transCurrency ?? 'INR';
    String createdDate = widget.transfers!.createdAt ?? '';
    String updatedDate = widget.transfers!.updatedAt ?? '';
    String transactionId = widget.transfers!.transactionNumber.toString() ?? '';

    String createDate = widget.transfers!.createdDate?.substring(0, 10) ?? '';
    String createdTime = widget.transfers!.createdDate?.substring(11, 16) ?? '';
    String date = AppDateUtils.getDateINYMD(createDate, '');

    // Get amount
    String amount = '';

    if (widget.transfers!.amount != null) {
      loggerNoStack.e("amount inside");
      amount = widget.transfers!.amount ?? '';
    } else {
      loggerNoStack.e("amount outside");
      amount = widget.transfers!.transferAmount ?? '';
    }

    String message = 'Payment of ' +
        currencyType +
        ' ' +
        amount +
        ' to ' +
        name +
        '\nSuccessful';

    if (widget.status == 'NotMatch') {
      message = 'Payment of ' +
          currencyType +
          ' ' +
          amount +
          ' to ' +
          name +
          '\nNot Matched';
    } else {
      message = 'Payment of ' +
          currencyType +
          ' ' +
          amount +
          ' to ' +
          name +
          '\nSuccessful';
    }

    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorViewConstants.colorBlueSecondaryText,
            toolbarHeight: 0,
          ),
          bottomNavigationBar: BottomAppBar(
            height: screenHeight * 0.075,
            color: ColorViewConstants.colorBlueSecondaryDarkText,
            elevation: 0,
            child: InkWell(
                onTap: () {
                  loggerNoStack.e('clicked on Done');

                  if (widget.navigationFrom == 'VGO WALLET') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VgoWalletTransactionListView(),
                      ),
                    );
                  } else {
                    Navigator.pop(context, true);
                  }
                },
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'DONE',
                        style: AppTextStyles.medium.copyWith(
                            fontSize: 16, color: ColorViewConstants.colorWhite),
                      ),
                    ))),
          ),
          body: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              height: screenHeight,
              width: screenWidth,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        ColorViewConstants.colorBlueSecondaryDarkText,
                        ColorViewConstants.colorBlueSecondaryText,
                      ],
                      begin: const FractionalOffset(1.0, 1.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp)),
              child: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.status == 'NotMatch'
                            ? SvgPicture.asset(
                                'assets/images/services/ic_failure.svg',
                                width: screenWidth,
                                height: screenHeight * 0.18,
                                color: ColorViewConstants.colorRed
                                /*      color: widget.status == 'NotMatch'
                              ? ColorViewConstants.colorRed
                              : ColorViewConstants.colorGreen,*/
                                )
                            : SvgPicture.asset(
                                'assets/images/services/ic_success.svg',
                                width: screenWidth,
                                height: screenHeight * 0.18,
                                /*      color: widget.status == 'NotMatch'
                              ? ColorViewConstants.colorRed
                              : ColorViewConstants.colorGreen,*/
                              ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Text(message,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.medium.copyWith(
                                color: ColorViewConstants.colorWhite,
                                fontSize: 20)),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Text('Transaction ID : ' + transactionId,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.regular.copyWith(
                                color: ColorViewConstants.colorWhite,
                                fontSize: 14)),
                        Text(date + ' at ' + createdTime,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.regular.copyWith(
                                color: ColorViewConstants.colorWhite,
                                fontSize: 14)),
                        SizedBox(
                          height: screenHeight * 0.04,
                        ),
                        Visibility(
                          visible: !widget.isAdminTransfer,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TransferChatView(
                                          isMobileTransfer:
                                              widget.isMobileTransfer,
                                          transfers: widget.transfers,
                                        )),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 25, right: 25, top: 8, bottom: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorViewConstants.colorWhite),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text('View Details',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.medium.copyWith(
                                      color: ColorViewConstants.colorWhite,
                                      fontSize: 14)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.04,
                        ),
                        Image.asset(
                          'assets/images/services/ic_success_banner.png',
                          width: screenWidth,
                          height: screenHeight * 0.3,
                        )
                      ],
                    ),
                  ))),
        ),
        onWillPop: _onWillPop);
  }
}
