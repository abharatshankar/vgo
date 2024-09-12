import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/color_view_constants.dart';
import '../../../session/session_manager.dart';
import '../../../utils/app_text_style.dart';
import '../../common/common_tool_bar_transfer.dart';
import '../../common/widget_loader.dart';

class OrderInvoiceDetailView extends StatefulWidget {
  OrderInvoiceDetailView({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => OrderInvoiceDetailState();
}

class OrderInvoiceDetailState extends State<OrderInvoiceDetailView> {
  bool showProgressCircle = false;
  String? userName;
  final orderItemsController = TextEditingController();
  final orderAmountController = TextEditingController();
  final gstAmountController = TextEditingController();
  final totalAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SessionManager.getUserName().then((value) {
      userName = value;
    });
  }

  void calculateGstAmount() {
    double orderAmount =
        !StringUtils.isNullOrEmpty(orderAmountController.text.toString())
            ? double.parse(orderAmountController.text.toString())
            : 0;
    double gstAmount = (orderAmount / 100) * 18;
    double totalAmount = orderAmount + gstAmount;
    gstAmountController.text = gstAmount.toString();
    totalAmountController.text = totalAmount.toString();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: ColorViewConstants.colorWhite,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: ColorViewConstants.colorBlueSecondaryText,
        ),
        body: Stack(children: [
          Column(
            children: [
              toolBarTransferWidget(context, 'Order Invoice', false),
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(1.0),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              'IN',
                              style: AppTextStyles.semiBold.copyWith(
                                fontSize: 16,
                                color: ColorViewConstants.colorWhite,
                              ),
                            ),
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
                              'ORDER ID: #7654321',
                              style: AppTextStyles.semiBold.copyWith(
                                fontSize: 13,
                                color: ColorViewConstants.colorPrimaryText,
                              ),
                            ),
                            Text(
                              textAlign: TextAlign.start,
                              'Order on Thu, 25 Jul 2024 06:17 AM',
                              style: AppTextStyles.medium.copyWith(
                                fontSize: 12,
                                color: ColorViewConstants.colorSecondaryText,
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
                              color: ColorViewConstants.colorHintBlue),
                          child: Wrap(
                            direction: Axis.vertical,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                textAlign: TextAlign.start,
                                'Store ID',
                                style: AppTextStyles.medium.copyWith(
                                  fontSize: 12,
                                  color: ColorViewConstants.colorSecondaryText,
                                ),
                              ),
                              Text(
                                textAlign: TextAlign.start,
                                '#254',
                                style: AppTextStyles.semiBold.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorGreen,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Divider(
                      color: ColorViewConstants.colorGray,
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          direction: Axis.vertical,
                          children: [
                            Text(
                              textAlign: TextAlign.start,
                              'From',
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
                              'HYDERABAD',
                              style: AppTextStyles.semiBold.copyWith(
                                fontSize: 13,
                                color: ColorViewConstants.colorPrimaryText,
                              ),
                            ),
                          ],
                        ),
                        SvgPicture.asset(
                          'assets/images/services/ic_needle_arrow_right.svg',
                          width: 23,
                          height: 23,
                          color: ColorViewConstants.colorBlueSecondaryDarkText,
                        ),
                        Wrap(
                          direction: Axis.vertical,
                          crossAxisAlignment: WrapCrossAlignment.end,
                          children: [
                            Text(
                              textAlign: TextAlign.end,
                              'To',
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
                              'VISAKHAPATNAM',
                              style: AppTextStyles.semiBold.copyWith(
                                fontSize: 13,
                                color: ColorViewConstants.colorPrimaryText,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Divider(
                      color: ColorViewConstants.colorGray,
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          direction: Axis.vertical,
                          children: [
                            Text(
                              textAlign: TextAlign.start,
                              'Date of journey',
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
                              '26 Jul,2024',
                              style: AppTextStyles.semiBold.copyWith(
                                fontSize: 13,
                                color: ColorViewConstants.colorPrimaryText,
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          direction: Axis.vertical,
                          crossAxisAlignment: WrapCrossAlignment.end,
                          children: [
                            Text(
                              textAlign: TextAlign.end,
                              'Passangers',
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
                              '2',
                              style: AppTextStyles.semiBold.copyWith(
                                fontSize: 13,
                                color: ColorViewConstants.colorPrimaryText,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Divider(
                      color: ColorViewConstants.colorGray,
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Text(
                      textAlign: TextAlign.start,
                      'Payment summary',
                      style: AppTextStyles.semiBold.copyWith(
                        fontSize: 14,
                        color: ColorViewConstants.colorPrimaryText,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          direction: Axis.vertical,
                          children: [
                            Text(
                              textAlign: TextAlign.start,
                              'Base Fare',
                              style: AppTextStyles.semiBold.copyWith(
                                fontSize: 12,
                                color: ColorViewConstants.colorPrimaryText,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Text(
                              textAlign: TextAlign.start,
                              'CGST',
                              style: AppTextStyles.medium.copyWith(
                                fontSize: 13,
                                color: ColorViewConstants.colorSecondaryText,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Text(
                              textAlign: TextAlign.start,
                              'SGST',
                              style: AppTextStyles.medium.copyWith(
                                fontSize: 13,
                                color: ColorViewConstants.colorSecondaryText,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            Text(
                              textAlign: TextAlign.start,
                              'Total',
                              style: AppTextStyles.semiBold.copyWith(
                                fontSize: 13,
                                color: ColorViewConstants.colorPrimaryText,
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          direction: Axis.vertical,
                          crossAxisAlignment: WrapCrossAlignment.end,
                          children: [
                            Text(
                              textAlign: TextAlign.end,
                              '₹3000.0',
                              style: AppTextStyles.semiBold.copyWith(
                                fontSize: 12,
                                color: ColorViewConstants.colorPrimaryText,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Text(
                              textAlign: TextAlign.start,
                              '₹270.0',
                              style: AppTextStyles.medium.copyWith(
                                fontSize: 13,
                                color: ColorViewConstants.colorSecondaryText,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Text(
                              textAlign: TextAlign.start,
                              '₹270.0',
                              style: AppTextStyles.medium.copyWith(
                                fontSize: 13,
                                color: ColorViewConstants.colorSecondaryText,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            Text(
                              textAlign: TextAlign.start,
                              '₹3500.0',
                              style: AppTextStyles.semiBold.copyWith(
                                fontSize: 13,
                                color: ColorViewConstants.colorPrimaryText,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Divider(
                      color: ColorViewConstants.colorGray,
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    MaterialButton(
                      height: screenHeight * 0.06,
                      color: ColorViewConstants.colorGreen,
                      minWidth: screenWidth,
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'Proceed to pay',
                        style: AppTextStyles.medium.copyWith(
                            fontSize: 16, color: ColorViewConstants.colorWhite),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ))),
            ],
          ),
          widgetLoader(context, showProgressCircle),
        ]));
  }
}
