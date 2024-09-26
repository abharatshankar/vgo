import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vgo_flutter_app/src/view/common/widget_loader.dart';

import '../../constants/color_view_constants.dart';
import '../../model/coin.dart';
import '../../utils/app_text_style.dart';
import 'common_tool_bar_transfer.dart';

class TransactionStatusView extends StatefulWidget {
  TransactionStatusView({super.key, required this.coin});

  Coin? coin;

  @override
  State<StatefulWidget> createState() => TransactionStatusState();
}

class TransactionStatusState extends State<TransactionStatusView> {
  bool showProgressCircle = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    var currency = widget.coin?.transCurrency ?? '';
    var amount = widget.coin?.transAmount ?? '';
    var totalAmount = currency + ' ' + amount;

    var loyaltyCoin = widget.coin?.loyaltyCoins ?? '';

    return Scaffold(
        backgroundColor: ColorViewConstants.colorWhite,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: ColorViewConstants.colorBlueSecondaryText,
        ),
        body: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              toolBarTransferWidget(context, 'Transaction successful', false),
              Expanded(
                  child: SingleChildScrollView(
                      child: Container(
                        color: ColorViewConstants.colorWhite,
                        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              'Paid to',
                              style: AppTextStyles.semiBold.copyWith(
                                fontSize: 16,
                                color: ColorViewConstants.colorPrimaryText,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: ColorViewConstants.colorBlue,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/images/sep/ic_uptrend_arrow.svg',
                                    width: 10,
                                    height: 10,
                                    color: ColorViewConstants.colorRed,
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.02,
                                ),
                                Expanded(
                                    child: Wrap(
                                      direction: Axis.vertical,
                                      children: [
                                        Text(
                                          textAlign: TextAlign.start,
                                          widget.coin?.receiverName ?? '',
                                          style: AppTextStyles.semiBold
                                              .copyWith(
                                            fontSize: 13,
                                            color: ColorViewConstants
                                                .colorPrimaryText,
                                          ),
                                        ),
                                        Text(
                                          textAlign: TextAlign.start,
                                          widget.coin?.receiverMobileNumber ??
                                              '',
                                          style: AppTextStyles.medium.copyWith(
                                            fontSize: 12,
                                            color:
                                            ColorViewConstants
                                                .colorBlueSecondaryText,
                                          ),
                                        )
                                      ],
                                    )),
                                SizedBox(
                                  width: screenWidth * 0.02,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 2, bottom: 2),
                                  decoration: BoxDecoration(
                                      color: ColorViewConstants.colorWhite),
                                  child: Wrap(
                                    direction: Axis.vertical,
                                    crossAxisAlignment: WrapCrossAlignment.end,
                                    children: [
                                      Text(
                                        textAlign: TextAlign.start,
                                        totalAmount,
                                        style: AppTextStyles.medium.copyWith(
                                          fontSize: 14,
                                          color: ColorViewConstants
                                              .colorPrimaryText,
                                        ),
                                      ),
                                      Container(
                                        color: ColorViewConstants.colorGreenBg,
                                        padding: EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            top: 3,
                                            bottom: 5),
                                        child: Text(
                                          textAlign: TextAlign.start,
                                          'Loyalty earned ' + loyaltyCoin,
                                          style: AppTextStyles.semiBold
                                              .copyWith(
                                            fontSize: 11,
                                            color: ColorViewConstants
                                                .colorGreen,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.03,
                            ),
                            Text(
                              textAlign: TextAlign.start,
                              'Transaction ID',
                              style: AppTextStyles.medium.copyWith(
                                fontSize: 12,
                                color: ColorViewConstants.colorSecondaryText,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Text(
                              widget.coin?.transaction_id.toString() ?? '',
                              textAlign: TextAlign.start,
                              style: AppTextStyles.semiBold.copyWith(
                                fontSize: 13,
                                color: ColorViewConstants.colorPrimaryText,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  direction: Axis.vertical,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  children: [
                                    Text(
                                      textAlign: TextAlign.end,
                                      'Debited from',
                                      style: AppTextStyles.medium.copyWith(
                                        fontSize: 12,
                                        color: ColorViewConstants
                                            .colorSecondaryText,
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.01,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: ColorViewConstants.colorBlue,
                                            borderRadius: BorderRadius.circular(
                                                30),
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/images/sep/ic_bank_logo.svg',
                                            width: 10,
                                            height: 10,
                                            color: ColorViewConstants
                                                .colorBlueSecondaryDarkText,
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.03,
                                        ),
                                        Wrap(
                                            direction: Axis.vertical,
                                            crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                            children: [
                                              Text(
                                                textAlign: TextAlign.end,
                                                widget.coin?.transfererName ??
                                                    '',
                                                style: AppTextStyles.medium
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: ColorViewConstants
                                                      .colorPrimaryTextMedium,
                                                ),
                                              ),
                                              Text(
                                                textAlign: TextAlign.end,
                                                widget.coin
                                                    ?.transfererMobileNumber ??
                                                    '',
                                                style: AppTextStyles.medium
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: ColorViewConstants
                                                      .colorSecondaryText,
                                                ),
                                              ),
                                            ])
                                      ],
                                    )
                                  ],
                                ),
                                Text(
                                  textAlign: TextAlign.start,
                                  totalAmount,
                                  style: AppTextStyles.medium.copyWith(
                                    fontSize: 16,
                                    color: ColorViewConstants.colorPrimaryText,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              'Order details',
                              style: AppTextStyles.semiBold.copyWith(
                                fontSize: 16,
                                color: ColorViewConstants.colorPrimaryText,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Text(
                              textAlign: TextAlign.start,
                              'Order ID',
                              style: AppTextStyles.medium.copyWith(
                                fontSize: 12,
                                color: ColorViewConstants.colorSecondaryText,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Text(
                              textAlign: TextAlign.start,
                              widget.coin?.transactionRefNo.toString() ?? '',
                              style: AppTextStyles.semiBold.copyWith(
                                fontSize: 13,
                                color: ColorViewConstants.colorPrimaryText,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: ColorViewConstants.colorBlue,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/images/sep/ic_bank_logo.svg',
                                    width: 10,
                                    height: 10,
                                    color:
                                    ColorViewConstants
                                        .colorBlueSecondaryDarkText,
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.03,
                                ),
                                Expanded(
                                    child: Wrap(
                                        direction: Axis.vertical,
                                        crossAxisAlignment: WrapCrossAlignment
                                            .start,
                                        children: [
                                          Text(
                                            textAlign: TextAlign.end,
                                            'Service',
                                            style: AppTextStyles.medium
                                                .copyWith(
                                              fontSize: 12,
                                              color:
                                              ColorViewConstants
                                                  .colorPrimaryTextMedium,
                                            ),
                                          ),
                                          Text(
                                            textAlign: TextAlign.end,
                                            widget.coin?.transDesc.toString() ??
                                                '',
                                            style: AppTextStyles.medium
                                                .copyWith(
                                              fontSize: 12,
                                              color: ColorViewConstants
                                                  .colorSecondaryText,
                                            ),
                                          ),
                                        ])),
                                Wrap(
                                  direction: Axis.vertical,
                                  crossAxisAlignment: WrapCrossAlignment.end,
                                  children: [
                                    Text(
                                      textAlign: TextAlign.end,
                                      'Qty',
                                      style: AppTextStyles.medium.copyWith(
                                        fontSize: 12,
                                        color: ColorViewConstants
                                            .colorSecondaryText,
                                      ),
                                    ),
                                    Text(
                                      textAlign: TextAlign.end,
                                      '2',
                                      style: AppTextStyles.medium.copyWith(
                                        fontSize: 13,
                                        color: ColorViewConstants
                                            .colorPrimaryText,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.03,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              'Trans agent bank details',
                              style: AppTextStyles.semiBold.copyWith(
                                fontSize: 16,
                                color: ColorViewConstants.colorPrimaryText,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: ColorViewConstants.colorBlue,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/images/sep/ic_bank_logo.svg',
                                    width: 10,
                                    height: 10,
                                    color:
                                    ColorViewConstants
                                        .colorBlueSecondaryDarkText,
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.02,
                                ),
                                Wrap(
                                  direction: Axis.vertical,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  children: [
                                    Text(
                                      textAlign: TextAlign.center,
                                      widget.coin?.accountNumber ?? '',
                                      style: AppTextStyles.medium.copyWith(
                                        fontSize: 13,
                                        color: ColorViewConstants
                                            .colorPrimaryText,
                                      ),
                                    ),
                                    Text(
                                      textAlign: TextAlign.center,
                                      widget.coin?.bankName ?? '',
                                      style: AppTextStyles.medium.copyWith(
                                        fontSize: 13,
                                        color: ColorViewConstants
                                            .colorSecondaryText,
                                      ),
                                    ),
                                    Text(
                                      textAlign: TextAlign.center,
                                      'B.Ramana rao.',
                                      style: AppTextStyles.medium.copyWith(
                                        fontSize: 13,
                                        color: ColorViewConstants.colorGreen,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            // SizedBox(
                            //   height: screenHeight * 0.04,
                            // ),
                            // Row(
                            //   mainAxisSize: MainAxisSize.max,
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //
                            //     Wrap(
                            //       direction: Axis.vertical,
                            //       crossAxisAlignment: WrapCrossAlignment.center,
                            //       children: [
                            //         Container(
                            //           width: 50,
                            //           height: 50,
                            //           padding: EdgeInsets.all(15),
                            //           decoration: BoxDecoration(
                            //             color: ColorViewConstants
                            //                 .colorBlueSecondaryDarkText,
                            //             borderRadius: BorderRadius.circular(13),
                            //           ),
                            //           child: SvgPicture.asset(
                            //             'assets/images/service/arrow.svg',
                            //             width: 10,
                            //             height: 10,
                            //             color: ColorViewConstants.colorWhite,
                            //           ),
                            //         ),
                            //         SizedBox(
                            //           height: screenHeight * 0.01,
                            //         ),
                            //         Text(
                            //           textAlign: TextAlign.center,
                            //           'History',
                            //           style: AppTextStyles.medium.copyWith(
                            //             fontSize: 13,
                            //             color: ColorViewConstants
                            //                 .colorBlueSecondaryDarkText,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     SizedBox(
                            //       width: screenWidth * 0.08,
                            //     ),
                            //     Wrap(
                            //       direction: Axis.vertical,
                            //       crossAxisAlignment: WrapCrossAlignment.center,
                            //       children: [
                            //         Container(
                            //           width: 50,
                            //           height: 50,
                            //           padding: EdgeInsets.all(13),
                            //           decoration: BoxDecoration(
                            //             color: ColorViewConstants
                            //                 .colorBlueSecondaryDarkText,
                            //             borderRadius: BorderRadius.circular(13),
                            //           ),
                            //           child: SvgPicture.asset(
                            //             'assets/images/sep/ic_uptrend_arrow.svg',
                            //             width: 10,
                            //             height: 10,
                            //             color: ColorViewConstants.colorWhite,
                            //           ),
                            //         ),
                            //         SizedBox(
                            //           height: screenHeight * 0.01,
                            //         ),
                            //         Text(
                            //           textAlign: TextAlign.center,
                            //           'Order gain',
                            //           style: AppTextStyles.medium.copyWith(
                            //             fontSize: 13,
                            //             color: ColorViewConstants
                            //                 .colorBlueSecondaryDarkText,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     SizedBox(
                            //       width: screenWidth * 0.08,
                            //     ),
                            //     Wrap(
                            //       direction: Axis.vertical,
                            //       crossAxisAlignment: WrapCrossAlignment.center,
                            //       children: [
                            //         Container(
                            //           width: 50,
                            //           height: 50,
                            //           padding: EdgeInsets.all(12),
                            //           decoration: BoxDecoration(
                            //             color: ColorViewConstants
                            //                 .colorBlueSecondaryDarkText,
                            //             borderRadius: BorderRadius.circular(13),
                            //           ),
                            //           child: SvgPicture.asset(
                            //             'assets/images/sep/ic_share.svg',
                            //             width: 10,
                            //             height: 10,
                            //             color: ColorViewConstants.colorWhite,
                            //           ),
                            //         ),
                            //         SizedBox(
                            //           height: screenHeight * 0.01,
                            //         ),
                            //         Text(
                            //           textAlign: TextAlign.center,
                            //           'Share',
                            //           style: AppTextStyles.medium.copyWith(
                            //             fontSize: 13,
                            //             color: ColorViewConstants
                            //                 .colorBlueSecondaryDarkText,
                            //           ),
                            //         ),
                            //       ],
                            //     )
                            //   ],
                            // )
                          ],
                        ),
                      ))),
            ],
          ),
          widgetLoader(context, showProgressCircle),
        ]));
  }
}
