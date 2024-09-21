import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:vgo_flutter_app/src/utils/app_date_utils.dart';

import '../../../../constants/color_view_constants.dart';
import '../../../../constants/string_view_constants.dart';
import '../../../../model/request/update_order_request.dart';
import '../../../../model/response/order_list_response.dart';
import '../../../../session/session_manager.dart';
import '../../../../utils/app_string_utils.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/toast_utils.dart';
import '../../../../utils/utils.dart';
import '../../../../view_model/services_view_model.dart';
import '../../../common/common_tool_bar_transfer.dart';
import '../../../common/widget_loader.dart';
import '../../../team/store/store_chat_list_view.dart';

class OrdersDeliveryListByUsersView extends StatefulWidget {
  OrdersDeliveryListByUsersView({
    super.key,
    required this.category,
  });

  String category = '';

  @override
  State<StatefulWidget> createState() => OrdersDeliveryListByUsersState();
}

class OrdersDeliveryListByUsersState
    extends State<OrdersDeliveryListByUsersView>
    with SingleTickerProviderStateMixin {
  bool showProgressCircle = false;
  TabController? _controller;
  int _selectedIndex = 0;
  String userName = '';

  List<OrderStatusTab>? orderStatusTabList = [];
  List<Tab> tabList = [];
  String tabName = '';
  OtpFieldController otpController = OtpFieldController();
  var otpValue = '';

  @override
  void initState() {
    super.initState();

    loggerNoStack.e('category:  ' + widget.category);
    loggerNoStack.e('isOwnerOrder:  ' + isOwnerOrder().toString());

    SessionManager.getUserName().then((value) {
      loggerNoStack.e('gap id :${value!}');
      userName = value;

      /*  if (StringViewConstants.CONSTANT_OWNER_STORE_ORDER == widget.category) {
        callGetUserStoreOrders();
      } else {
        callGetUserOrders();
      }*/

      callGetUserDeliveryOrders();
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  bool isOwnerOrder() {
    return StringViewConstants.CONSTANT_OWNER_STORE_ORDER == widget.category;
  }

  void callDeliveryAcceptApi(Order order) {
    setState(() {
      showProgressCircle = true;
    });

    final UpdateOrderRequest request = UpdateOrderRequest(
        username: userName,
        store_id: order.storeId.toString() ?? '',
        order_items: order.orderItems ?? '',
        gst_amount: order.gstAmount ?? '',
        total_amount: order.totalAmount ?? '',
        order_amount: order.orderAmount ?? '',
        order_status: 'Accept',
        delivery_address_id: '');

    ServicesViewModel.instance.callUpdateOrder(
        request, order.orderNo.toString(), completion: (response) {
      setState(() {
        showProgressCircle = false;
        if (response!.success ?? true) {
          callGetUserDeliveryOrders();
        } else {
          ToastUtils.instance
              .showToast(response.message!, context: context, isError: true);
        }
      });
    });
  }

  void callPayOrderApi(Order order) {
    setState(() {
      showProgressCircle = true;
    });

    final UpdateOrderRequest request = UpdateOrderRequest(
        username: userName,
        store_id: order.storeId.toString() ?? '',
        order_items: order.orderItems ?? '',
        gst_amount: order.gstAmount ?? '',
        total_amount: order.totalAmount ?? '',
        order_amount: order.orderAmount ?? '',
        order_status: 'Dispatch',
        delivery_address_id: '');

    ServicesViewModel.instance.callUpdateOrder(
        request, order.orderNo.toString(), completion: (response) {
      setState(() {
        showProgressCircle = false;
        if (response!.success ?? true) {
          // Navigator.pop(context, true);
        } else {
          ToastUtils.instance
              .showToast(response.message!, context: context, isError: true);
        }
      });
    });
  }

  void callDispatchOrderApi(Order order) {
    setState(() {
      showProgressCircle = true;
    });

    final UpdateOrderRequest request = UpdateOrderRequest(
        username: userName,
        store_id: order.storeId.toString() ?? '',
        order_items: order.orderItems ?? '',
        gst_amount: order.gstAmount ?? '',
        total_amount: order.totalAmount ?? '',
        order_amount: order.orderAmount ?? '',
        order_status: 'Dispatch',
        delivery_address_id: '');

    ServicesViewModel.instance.callUpdateOrder(
        request, order.orderNo.toString(), completion: (response) {
      setState(() {
        showProgressCircle = false;
        if (response!.success ?? true) {
          // Navigator.pop(context, true);
        } else {
          ToastUtils.instance
              .showToast(response.message!, context: context, isError: true);
        }
      });
    });
  }

  void callVerifyDispatchOrderFromStoreApi(
      String orderId, String otp, Order order) {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.verifyDispatchOrderFromStore(
        userName, orderId, otp, completion: (response) {
      setState(() {
        showProgressCircle = false;
        if (response!.success ?? true) {
          callDispatchOrderApi(order);
        } else {
          ToastUtils.instance
              .showToast(response.message!, context: context, isError: true);
        }
      });
    });
  }

  void callVerifyReceivedOrderFromCustomerApi(
      String orderId, String otp, Order order) {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.verifyDispatchOrderFromCustomer(
        userName, orderId, otp, completion: (response) {
      setState(() {
        showProgressCircle = false;
        if (response!.success ?? true) {
        } else {
          ToastUtils.instance
              .showToast(response.message!, context: context, isError: true);
        }
      });
    });
  }

  void callGetUserDeliveryOrders() {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callGetUserDeliveryOrders(userName,
        completion: (response) {
      setState(() {
        showProgressCircle = false;

        orderStatusTabList!.clear();
        tabList.clear();
        if (response!.success ?? true) {
          orderStatusTabList = response.industryList;

          for (OrderStatusTab tab in orderStatusTabList!) {
            tabList.add(new Tab(
              text: tab.status,
            ));
          }
          tabName = orderStatusTabList![0].status ?? '';

          _controller =
              TabController(length: orderStatusTabList!.length, vsync: this);

          _controller?.addListener(() {
            setState(() {
              _selectedIndex = _controller!.index;
              tabName = orderStatusTabList![_selectedIndex].status ?? '';
            });
          });
        } else {
          loggerNoStack.e('No stores');
        }
      });
    });
  }

  void callGetUserStoreOrders() {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callGetUserStoreOrders(userName,"","",
        completion: (response) {
      setState(() {
        showProgressCircle = false;

        orderStatusTabList!.clear();
        tabList.clear();

        if (response!.success ?? true) {
          orderStatusTabList = response.industryList;

          for (OrderStatusTab tab in orderStatusTabList!) {
            tabList.add(new Tab(
              text: tab.status,
            ));
          }

          _controller =
              TabController(length: orderStatusTabList!.length, vsync: this);

          _controller?.addListener(() {
            setState(() {
              _selectedIndex = _controller!.index;
              tabName = orderStatusTabList![_selectedIndex].status ?? '';
              loggerNoStack.e('tabName : ' + tabName);
            });
          });
        } else {
          loggerNoStack.e('No stores');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorViewConstants.colorLightWhite,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: ColorViewConstants.colorBlueSecondaryText,
      ),
      body: Stack(
        children: [
          widgetLoader(context, showProgressCircle),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              toolBarTransferWidget(context, 'Orders', false),
              Visibility(
                  visible: orderStatusTabList!.length == 0 ? false : true,
                  child: DefaultTabController(
                    initialIndex: _selectedIndex,
                    animationDuration: const Duration(milliseconds: 500),
                    length: orderStatusTabList!.length,
                    child: TabBar(
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        controller: _controller,
                        physics: const NeverScrollableScrollPhysics(),
                        labelColor: ColorViewConstants.colorBlueSecondaryText,
                        unselectedLabelColor: ColorViewConstants.colorHintGray,
                        labelStyle: AppTextStyles.medium.copyWith(fontSize: 14),
                        indicatorColor:
                            ColorViewConstants.colorBlueSecondaryText,
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: tabList),
                  )),
              Visibility(
                  visible: orderStatusTabList!.length == 0 ? false : true,
                  child: Expanded(
                    child: TabBarView(
                      controller: _controller,
                      children: orderStatusTabList!.isEmpty
                          ? <Widget>[]
                          : orderStatusTabList!.map((dynamicContent) {
                              return ListView.builder(
                                  itemCount: dynamicContent.orderList?.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, position) {
                                    var itemsBuilder = StringBuffer();
                                    var items = dynamicContent
                                        .orderList![position].orderItems!
                                        .split(',');
                                    for (String item in items) {
                                      itemsBuilder.write(item + "\n");
                                    }

                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    StoreChatListView(
                                                      title: dynamicContent
                                                              .orderList![
                                                                  position]
                                                              .orderNo
                                                              .toString() ??
                                                          '',
                                                      category: widget.category,
                                                    )));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15, top: 15),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Visibility(
                                                visible: false,
                                                child: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: ColorViewConstants
                                                        .colorBlueSecondaryText
                                                        .withOpacity(1.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      AppStringUtils
                                                              .extractFirstLetter(
                                                                  itemsBuilder
                                                                      .toString()) ??
                                                          '',
                                                      style: AppTextStyles
                                                          .semiBold
                                                          .copyWith(
                                                        fontSize: 14,
                                                        color:
                                                            ColorViewConstants
                                                                .colorWhite,
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                                child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text:
                                                              'Ordered Number',
                                                          style: AppTextStyles
                                                              .regular
                                                              .copyWith(
                                                                  color: ColorViewConstants
                                                                      .colorPrimaryText,
                                                                  fontSize:
                                                                      14)),
                                                      TextSpan(
                                                          text: ' : ',
                                                          style: AppTextStyles
                                                              .medium
                                                              .copyWith(
                                                                  color: ColorViewConstants
                                                                      .colorPrimaryText,
                                                                  fontSize:
                                                                      14)),
                                                      TextSpan(
                                                          text: dynamicContent
                                                              .orderList![
                                                                  position]
                                                              .orderNo!
                                                              .toString(),
                                                          style: AppTextStyles
                                                              .medium
                                                              .copyWith(
                                                                  color: ColorViewConstants
                                                                      .colorPrimaryText,
                                                                  fontSize:
                                                                      14)),
                                                    ])),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                RichText(
                                                    textAlign: TextAlign.start,
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: 'Ordered Items',
                                                          style: AppTextStyles
                                                              .regular
                                                              .copyWith(
                                                                  color: ColorViewConstants
                                                                      .colorPrimaryText,
                                                                  fontSize:
                                                                      14)),
                                                      TextSpan(
                                                          text: ' : ',
                                                          style: AppTextStyles
                                                              .medium
                                                              .copyWith(
                                                                  color: ColorViewConstants
                                                                      .colorPrimaryText,
                                                                  fontSize:
                                                                      14)),
                                                      TextSpan(
                                                          text: '\n' +
                                                                  StringUtils.capitalize(
                                                                      itemsBuilder
                                                                          .toString()) ??
                                                              '',
                                                          style: AppTextStyles
                                                              .medium
                                                              .copyWith(
                                                                  color: ColorViewConstants
                                                                      .colorPrimaryText,
                                                                  fontSize:
                                                                      14)),
                                                    ])),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: 'Store ID',
                                                          style: AppTextStyles
                                                              .regular
                                                              .copyWith(
                                                                  color: ColorViewConstants
                                                                      .colorPrimaryText,
                                                                  fontSize:
                                                                      14)),
                                                      TextSpan(
                                                          text: ' : ',
                                                          style: AppTextStyles
                                                              .medium
                                                              .copyWith(
                                                                  color: ColorViewConstants
                                                                      .colorPrimaryText,
                                                                  fontSize:
                                                                      14)),
                                                      TextSpan(
                                                          text: dynamicContent
                                                                  .orderList![
                                                                      position]
                                                                  .storeId
                                                                  .toString() ??
                                                              '',
                                                          style: AppTextStyles
                                                              .medium
                                                              .copyWith(
                                                                  color: ColorViewConstants
                                                                      .colorPrimaryText,
                                                                  fontSize:
                                                                      14)),
                                                    ])),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: 'Ordered Date',
                                                          style: AppTextStyles
                                                              .regular
                                                              .copyWith(
                                                                  color: ColorViewConstants
                                                                      .colorPrimaryText,
                                                                  fontSize:
                                                                      14)),
                                                      TextSpan(
                                                          text: ' : ',
                                                          style: AppTextStyles
                                                              .medium
                                                              .copyWith(
                                                                  color: ColorViewConstants
                                                                      .colorPrimaryText,
                                                                  fontSize:
                                                                      14)),
                                                      TextSpan(
                                                          text: AppDateUtils.getDateINYMD(
                                                                  '',
                                                                  dynamicContent
                                                                      .orderList![
                                                                          position]
                                                                      .orderDate) ??
                                                              '',
                                                          style: AppTextStyles
                                                              .medium
                                                              .copyWith(
                                                                  color: ColorViewConstants
                                                                      .colorPrimaryText,
                                                                  fontSize:
                                                                      14)),
                                                    ])),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  dynamicContent
                                                          .orderList![position]
                                                          .deliveryConfirmDate.toString() ??
                                                      '',
                                                  style: AppTextStyles.regular
                                                      .copyWith(
                                                          color: ColorViewConstants
                                                              .colorPrimaryTextHint,
                                                          fontSize: 14),
                                                )
                                              ],
                                            )),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                InkWell(
                                                    onTap: () {},
                                                    child: Visibility(
                                                      visible: false,
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10,
                                                                right: 10,
                                                                top: 5,
                                                                bottom: 5),
                                                        decoration: BoxDecoration(
                                                            color: ColorViewConstants
                                                                .colorBlueSecondaryDarkText,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5))),
                                                        child: Text(
                                                          'Update Order',
                                                          style: AppTextStyles
                                                              .medium
                                                              .copyWith(
                                                                  color: ColorViewConstants
                                                                      .colorWhite,
                                                                  fontSize: 14),
                                                        ),
                                                      ),
                                                    ))
                                              ],
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Visibility(
                                                  visible: tabName != 'New',
                                                  child: RichText(
                                                      textAlign:
                                                          TextAlign.center,
                                                      text: TextSpan(children: [
                                                        TextSpan(
                                                            text:
                                                                'Order Amount',
                                                            style: AppTextStyles
                                                                .regular
                                                                .copyWith(
                                                                    color: ColorViewConstants
                                                                        .colorPrimaryText,
                                                                    fontSize:
                                                                        14)),
                                                        TextSpan(
                                                            text: ' : ',
                                                            style: AppTextStyles
                                                                .medium
                                                                .copyWith(
                                                                    color: ColorViewConstants
                                                                        .colorPrimaryText,
                                                                    fontSize:
                                                                        14)),
                                                        TextSpan(
                                                            text: dynamicContent
                                                                    .orderList![
                                                                        position]
                                                                    .orderAmount ??
                                                                '',
                                                            style: AppTextStyles
                                                                .medium
                                                                .copyWith(
                                                                    color: ColorViewConstants
                                                                        .colorPrimaryText,
                                                                    fontSize:
                                                                        14)),
                                                      ])),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Visibility(
                                                    visible: tabName != 'New',
                                                    child: RichText(
                                                        textAlign:
                                                            TextAlign.center,
                                                        text:
                                                            TextSpan(children: [
                                                          TextSpan(
                                                              text:
                                                                  'GST Amount',
                                                              style: AppTextStyles
                                                                  .regular
                                                                  .copyWith(
                                                                      color: ColorViewConstants
                                                                          .colorPrimaryText,
                                                                      fontSize:
                                                                          14)),
                                                          TextSpan(
                                                              text: ' : ',
                                                              style: AppTextStyles
                                                                  .medium
                                                                  .copyWith(
                                                                      color: ColorViewConstants
                                                                          .colorPrimaryText,
                                                                      fontSize:
                                                                          14)),
                                                          TextSpan(
                                                              text: dynamicContent
                                                                      .orderList![
                                                                          position]
                                                                      .gstAmount ??
                                                                  '',
                                                              style: AppTextStyles
                                                                  .medium
                                                                  .copyWith(
                                                                      color: ColorViewConstants
                                                                          .colorPrimaryText,
                                                                      fontSize:
                                                                          14)),
                                                        ]))),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Visibility(
                                                    visible: tabName != 'New',
                                                    child: RichText(
                                                        textAlign:
                                                            TextAlign.center,
                                                        text:
                                                            TextSpan(children: [
                                                          TextSpan(
                                                              text:
                                                                  'Total Amount',
                                                              style: AppTextStyles
                                                                  .regular
                                                                  .copyWith(
                                                                      color: ColorViewConstants
                                                                          .colorPrimaryText,
                                                                      fontSize:
                                                                          14)),
                                                          TextSpan(
                                                              text: ' : ',
                                                              style: AppTextStyles
                                                                  .medium
                                                                  .copyWith(
                                                                      color: ColorViewConstants
                                                                          .colorPrimaryText,
                                                                      fontSize:
                                                                          14)),
                                                          TextSpan(
                                                              text: dynamicContent
                                                                      .orderList![
                                                                          position]
                                                                      .totalAmount ??
                                                                  '',
                                                              style: AppTextStyles
                                                                  .medium
                                                                  .copyWith(
                                                                      color: ColorViewConstants
                                                                          .colorPrimaryText,
                                                                      fontSize:
                                                                          14)),
                                                        ]))),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Visibility(
                                                    visible:
                                                        tabName == 'Payment',
                                                    child: MaterialButton(
                                                      height: 30,
                                                      minWidth: 30,
                                                      color: ColorViewConstants
                                                          .colorRed,
                                                      onPressed: () {
                                                        callDeliveryAcceptApi(
                                                            dynamicContent
                                                                    .orderList![
                                                                position]);
                                                      },
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40)),
                                                      child: Text(
                                                        'ACCEPT',
                                                        style: AppTextStyles
                                                            .medium
                                                            .copyWith(
                                                                fontSize: 14,
                                                                color: ColorViewConstants
                                                                    .colorWhite),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    )),
                                                Visibility(
                                                    visible:
                                                        tabName == 'Dispatch',
                                                    child: MaterialButton(
                                                      height: 30,
                                                      minWidth: 30,
                                                      color: ColorViewConstants
                                                          .colorRed,
                                                      onPressed: () {
                                                        // dispatch to customer - 178363
                                                        showMaterialModalBottomSheet(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    Container(
                                                                      height:
                                                                          screenHeight *
                                                                              0.5,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsets.only(
                                                                                left: 10,
                                                                                top: 40,
                                                                                right: 10),
                                                                            child:
                                                                                Align(
                                                                              alignment: Alignment.center,
                                                                              child: Text(
                                                                                'Please verify the OTP is sent for Dispatch this order',
                                                                                style: AppTextStyles.medium.copyWith(color: ColorViewConstants.colorPrimaryText),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                20,
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child: OTPTextField(
                                                                                controller: otpController,
                                                                                width: screenWidth * 0.8,
                                                                                length: 6,
                                                                                textFieldAlignment: MainAxisAlignment.spaceAround,
                                                                                fieldWidth: 45,
                                                                                fieldStyle: FieldStyle.underline,
                                                                                outlineBorderRadius: 10,
                                                                                style: AppTextStyles.medium.copyWith(color: ColorViewConstants.colorBlueSecondaryText, fontSize: 16),
                                                                                onChanged: (pin) {
                                                                                  otpValue = pin;
                                                                                  if (pin.length == 6) {
                                                                                    callVerifyReceivedOrderFromCustomerApi(dynamicContent.orderList![position].orderNo.toString(), pin, dynamicContent.orderList![position]);
                                                                                  }
                                                                                },
                                                                                onCompleted: (pin) {
                                                                                  otpValue = pin;
                                                                                }),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ));
                                                      },
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40)),
                                                      child: Text(
                                                        'DISPATCH',
                                                        style: AppTextStyles
                                                            .medium
                                                            .copyWith(
                                                                fontSize: 14,
                                                                color: ColorViewConstants
                                                                    .colorWhite),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }).toList(),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
