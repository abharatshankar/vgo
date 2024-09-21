import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';
import 'package:vgo_flutter_app/src/view_model/services_view_model.dart';

import '../../../constants/color_view_constants.dart';
import '../../../model/request/update_order_request.dart';
import '../../../model/response/order_list_response.dart';
import '../../../session/session_manager.dart';
import '../../../utils/app_box_decoration.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/toast_utils.dart';
import '../../common/common_tool_bar_transfer.dart';
import '../../common/widget_loader.dart';

class OrderGenerateInvoiceView extends StatefulWidget {
  OrderGenerateInvoiceView({
    super.key,
    required this.order,
  });

  Order? order;

  @override
  State<StatefulWidget> createState() => OrderGenerateInvoiceState();
}

class OrderGenerateInvoiceState extends State<OrderGenerateInvoiceView> {
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

    getOrderItems();
  }

  void getOrderItems() {
    var split = widget.order!.orderItems!.split(',');
    var orderItems = StringBuffer();
    for (String item in split) {
      orderItems.write(item);
      orderItems.write('\n\n');
    }

    loggerNoStack.e('getOrderItems : ' + orderItems.toString());
    orderItemsController.text = orderItems.toString();
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

  void callGenerateInvoiceApi() {
    if (orderItemsController.text.isEmpty) {
      ToastUtils.instance.showToast("Please enter order items!",
          context: context, isError: false, bg: ColorViewConstants.colorYellow);
    } else if (orderAmountController.text.isEmpty) {
      ToastUtils.instance.showToast("Please enter order amount!",
          context: context, isError: false, bg: ColorViewConstants.colorYellow);
    } else {
      setState(() {
        showProgressCircle = true;
      });

      final UpdateOrderRequest request = UpdateOrderRequest(
          username: userName,
          store_id: widget.order?.storeId.toString() ?? '',
          order_items: orderItemsController.text.toString(),
          gst_amount: gstAmountController.text.toString(),
          total_amount: totalAmountController.text.toString(),
          order_amount: orderAmountController.text.toString(),
          order_status: 'Invoice',
          delivery_address_id: '');

      ServicesViewModel.instance.callUpdateOrder(
          request, widget.order!.orderNo.toString(), completion: (response) {
        setState(() {
          showProgressCircle = false;
          if (response!.success ?? true) {
            Navigator.pop(context, true);
          } else {
            ToastUtils.instance
                .showToast(response.message!, context: context, isError: true);
          }
        });
      });
    }
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
        bottomNavigationBar: BottomAppBar(
          color: ColorViewConstants.colorWhite,
          elevation: 0,
          child: MaterialButton(
            height: screenHeight * 0.06,
            color: ColorViewConstants.colorBlueSecondaryText,
            minWidth: screenWidth,
            onPressed: () {
              callGenerateInvoiceApi();
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Text(
              'Generate Invoice',
              style: AppTextStyles.medium
                  .copyWith(fontSize: 16, color: ColorViewConstants.colorWhite),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: Stack(children: [
          Column(
            children: [
              toolBarTransferWidget(context, 'Generate Invoice', false),
              Expanded(
                  child: SingleChildScrollView(
                      child: Container(
                color: ColorViewConstants.colorWhite,
                padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'ORDER NUMBER : ',
                            style: AppTextStyles.medium.copyWith(
                              color: ColorViewConstants.colorPrimaryTextHint,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                              text: widget.order!.orderNo.toString() ?? '',
                              style: AppTextStyles.medium.copyWith(
                                  color: ColorViewConstants.colorPrimaryText,
                                  fontSize: 14)),
                        ])),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Order Items : ',
                            style: AppTextStyles.regular.copyWith(
                              color: ColorViewConstants.colorPrimaryTextHint,
                              fontSize: 16,
                            ),
                          ),
                        ])),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Container(
                      height: screenHeight * 0.2,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: ColorViewConstants.colorTransferGray,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: screenWidth,
                      child: TextField(
                        controller: orderItemsController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: '',
                          hintStyle: AppTextStyles.regular.copyWith(
                            fontSize: 14,
                            color: ColorViewConstants.colorGray,
                          ),
                          enabledBorder: AppBoxDecoration.noInputBorder,
                          focusedBorder: AppBoxDecoration.noInputBorder,
                          border: AppBoxDecoration.noInputBorder,
                        ),
                        style: AppTextStyles.medium.copyWith(
                            color: ColorViewConstants.colorPrimaryText),
                        onChanged: (value) {
                          orderItemsController.text = value;
                        },
                        //  textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Order Amount : ',
                            style: AppTextStyles.regular.copyWith(
                              color: ColorViewConstants.colorPrimaryTextHint,
                              fontSize: 16,
                            ),
                          ),
                        ])),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: ColorViewConstants.colorTransferGray,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: screenWidth,
                      child: TextField(
                        controller: orderAmountController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: '',
                          hintStyle: AppTextStyles.regular.copyWith(
                            fontSize: 14,
                            color: ColorViewConstants.colorGray,
                          ),
                          enabledBorder: AppBoxDecoration.noInputBorder,
                          focusedBorder: AppBoxDecoration.noInputBorder,
                          border: AppBoxDecoration.noInputBorder,
                        ),
                        style: AppTextStyles.medium.copyWith(
                            color: ColorViewConstants.colorPrimaryText),
                        onChanged: (value) {
                          calculateGstAmount();
                        },
                        //  textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'GST Amount : ',
                            style: AppTextStyles.regular.copyWith(
                              color: ColorViewConstants.colorPrimaryTextHint,
                              fontSize: 16,
                            ),
                          ),
                        ])),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: ColorViewConstants.colorTransferGray,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: screenWidth,
                      child: TextField(
                        enabled: false,
                        controller: gstAmountController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: '',
                          hintStyle: AppTextStyles.regular.copyWith(
                            fontSize: 14,
                            color: ColorViewConstants.colorGray,
                          ),
                          enabledBorder: AppBoxDecoration.noInputBorder,
                          focusedBorder: AppBoxDecoration.noInputBorder,
                          border: AppBoxDecoration.noInputBorder,
                        ),
                        style: AppTextStyles.medium.copyWith(
                            color: ColorViewConstants.colorPrimaryText),
                        onChanged: (value) {
                          orderItemsController.text = value;
                        },
                        //  textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Total Amount : ',
                            style: AppTextStyles.regular.copyWith(
                              color: ColorViewConstants.colorPrimaryTextHint,
                              fontSize: 16,
                            ),
                          ),
                        ])),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: ColorViewConstants.colorTransferGray,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: screenWidth,
                      child: TextField(
                        enabled: false,
                        controller: totalAmountController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: '',
                          hintStyle: AppTextStyles.regular.copyWith(
                            fontSize: 14,
                            color: ColorViewConstants.colorGray,
                          ),
                          enabledBorder: AppBoxDecoration.noInputBorder,
                          focusedBorder: AppBoxDecoration.noInputBorder,
                          border: AppBoxDecoration.noInputBorder,
                        ),
                        style: AppTextStyles.medium.copyWith(
                            color: ColorViewConstants.colorPrimaryText),
                        onChanged: (value) {
                          orderItemsController.text = value;
                        },
                        //  textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
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
