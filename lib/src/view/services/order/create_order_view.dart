import 'package:flutter/material.dart';

import '../../../constants/color_view_constants.dart';
import '../../../model/request/create_order_request.dart';
import '../../../model/store.dart';
import '../../../session/session_manager.dart';
import '../../../utils/app_box_decoration.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/toast_utils.dart';
import '../../../utils/utils.dart';
import '../../../view_model/services_view_model.dart';
import '../../common/common_tool_bar_transfer.dart';
import 'orders_list_by_users_view.dart';

class CreateOrderView extends StatefulWidget {
  CreateOrderView(
      {super.key,
      required this.store,
      required this.category,
      required this.travelType});

  Store? store;
  String category;
  String travelType;

  @override
  State<StatefulWidget> createState() => CreateOrderState();
}

class CreateOrderState extends State<CreateOrderView> {
  bool showProgressCircle = false;

  var orderItemController = TextEditingController();
  var travelTypeController = TextEditingController();
  var fromController = TextEditingController();
  var toController = TextEditingController();
  var dojController = TextEditingController();
  var ticketsController = TextEditingController();

  String userName = '';
  bool isTravelForm = false;

  @override
  void initState() {
    super.initState();
    loggerNoStack.e('category id :${widget.category}');
    loggerNoStack.e('travelType id :${widget.travelType}');

    if (widget.category.toLowerCase() == 'travel') {
      isTravelForm = true;
    } else {
      isTravelForm = false;
    }

    SessionManager.getUserName().then((value) {
      loggerNoStack.e('gap id :${value!}');
      userName = value;
    });

    orderItemController.text = widget.store!.supply_items ?? '';
    travelTypeController.text = widget.travelType ?? '';
  }

  callCreateOrderApi(String storeId, String storeUserName) {
    if (!isTravelForm && orderItemController.text.isEmpty) {
      ToastUtils.instance.showToast("Please enter order items!",
          context: context, isError: false, bg: ColorViewConstants.colorYellow);
    } else if (isTravelForm && travelTypeController.text.isEmpty) {
      ToastUtils.instance.showToast("Please enter travel type!",
          context: context, isError: false, bg: ColorViewConstants.colorYellow);
    } else if (isTravelForm && fromController.text.isEmpty) {
      ToastUtils.instance.showToast("Please enter FROM location!",
          context: context, isError: false, bg: ColorViewConstants.colorYellow);
    } else if (isTravelForm && toController.text.isEmpty) {
      ToastUtils.instance.showToast("Please enter TO location!",
          context: context, isError: false, bg: ColorViewConstants.colorYellow);
    } else if (isTravelForm && dojController.text.isEmpty) {
      ToastUtils.instance.showToast("Please enter Date Of Journey!",
          context: context, isError: false, bg: ColorViewConstants.colorYellow);
    } else if (isTravelForm && ticketsController.text.isEmpty) {
      ToastUtils.instance.showToast("Please enter No. Of Tickets!",
          context: context, isError: false, bg: ColorViewConstants.colorYellow);
    } else {
      setState(() {
        showProgressCircle = true;
      });

      final supplyItemsBuffer = StringBuffer();
      if(isTravelForm){
        supplyItemsBuffer.write("From: " + fromController.text);
        supplyItemsBuffer.write(",To: " + toController.text);
        supplyItemsBuffer.write(",Date: " + dojController.text);
        supplyItemsBuffer.write(",Tickets: " + ticketsController.text);
        supplyItemsBuffer.write(",Travel By: " + travelTypeController.text);
      } else {
        supplyItemsBuffer.write(orderItemController.text.toString());
      }

      CreateOrderRequest request = CreateOrderRequest(
          username: userName,
          store_username: storeUserName,
          store_id: storeId,
          order_items: supplyItemsBuffer.toString());

      ServicesViewModel.instance.callCreateOrder(request,
          completion: (response) {
        setState(() {
          showProgressCircle = false;
        });

        if (response!.success ?? true) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OrdersListByUsersView(
                        category: '',
                      )));
        } else {
          ToastUtils.instance
              .showToast(response.message!, context: context, isError: true);
        }
      });
    }
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
      bottomNavigationBar: BottomAppBar(
        color: ColorViewConstants.colorWhite,
        elevation: 0,
        child: MaterialButton(
          height: screenHeight * 0.06,
          color: ColorViewConstants.colorBlueSecondaryText,
          minWidth: screenWidth,
          onPressed: () {
            callCreateOrderApi(widget.store!.store_id.toString(),
                widget.store!.store_username!);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Text(
            'Create Order',
            style: AppTextStyles.semiBold
                .copyWith(fontSize: 16, color: ColorViewConstants.colorWhite),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              toolBarTransferWidget(
                  context, widget.store!.store_name ?? '', false),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Visibility(
                            visible: !isTravelForm,
                            child: Text(
                              'Order Items',
                              style: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorDarkGray),
                            )),
                        Visibility(
                            visible: !isTravelForm,
                            child: SizedBox(
                              height: screenHeight * 0.02,
                            )),
                        Visibility(
                            visible: !isTravelForm,
                            child: Container(
                              height: screenHeight * 0.1,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                color: ColorViewConstants.colorTransferGray,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: screenWidth,
                              child: TextField(
                                controller: orderItemController,
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
                                style: AppTextStyles.medium,
                                //  textAlign: TextAlign.center,
                              ),
                            )),
                        Visibility(
                            visible: isTravelForm,
                            child: SizedBox(
                              height: screenHeight * 0.02,
                            )),
                        Visibility(
                            visible: isTravelForm,
                            child: Text(
                              'Travel Type',
                              style: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorDarkGray),
                            )),
                        Visibility(
                            visible: isTravelForm,
                            child: SizedBox(
                              height: screenHeight * 0.02,
                            )),
                        Visibility(
                            visible: isTravelForm,
                            child: Container(
                              height: screenHeight * 0.06,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                color: ColorViewConstants.colorTransferGray,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: screenWidth,
                              child: TextField(
                                controller: travelTypeController,
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
                                style: AppTextStyles.medium,
                                //  textAlign: TextAlign.center,
                              ),
                            )),
                        Visibility(
                            visible: isTravelForm,
                            child: SizedBox(
                              height: screenHeight * 0.02,
                            )),
                        Visibility(
                            visible: isTravelForm,
                            child: Text(
                              'From',
                              style: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorDarkGray),
                            )),
                        Visibility(
                            visible: isTravelForm,
                            child: SizedBox(
                              height: screenHeight * 0.02,
                            )),
                        Visibility(
                            visible: isTravelForm,
                            child: Container(
                              height: screenHeight * 0.06,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                color: ColorViewConstants.colorTransferGray,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: screenWidth,
                              child: TextField(
                                controller: fromController,
                                keyboardType: TextInputType.text,
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
                                style: AppTextStyles.medium,
                                //  textAlign: TextAlign.center,
                              ),
                            )),
                        Visibility(
                            visible: isTravelForm,
                            child: SizedBox(
                              height: screenHeight * 0.02,
                            )),
                        Visibility(
                            visible: isTravelForm,
                            child: Text(
                              'To',
                              style: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorDarkGray),
                            )),
                        Visibility(
                            visible: isTravelForm,
                            child: SizedBox(
                              height: screenHeight * 0.02,
                            )),
                        Visibility(
                            visible: isTravelForm,
                            child: Container(
                              height: screenHeight * 0.06,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                color: ColorViewConstants.colorTransferGray,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: screenWidth,
                              child: TextField(
                                controller: toController,
                                keyboardType: TextInputType.text,
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
                                style: AppTextStyles.medium,
                                //  textAlign: TextAlign.center,
                              ),
                            )),
                        Visibility(
                            visible: isTravelForm,
                            child: SizedBox(
                              height: screenHeight * 0.02,
                            )),
                        Visibility(
                            visible: isTravelForm,
                            child: Text(
                              'Date Of Journey',
                              style: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorDarkGray),
                            )),
                        Visibility(
                            visible: isTravelForm,
                            child: SizedBox(
                              height: screenHeight * 0.02,
                            )),
                        Visibility(
                            visible: isTravelForm,
                            child: Container(
                              height: screenHeight * 0.06,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                color: ColorViewConstants.colorTransferGray,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: screenWidth,
                              child: TextField(
                                controller: dojController,
                                keyboardType: TextInputType.datetime,
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
                                style: AppTextStyles.medium,
                                //  textAlign: TextAlign.center,
                              ),
                            )),
                        Visibility(
                            visible: isTravelForm,
                            child: SizedBox(
                              height: screenHeight * 0.02,
                            )),
                        Visibility(
                            visible: isTravelForm,
                            child: Text(
                              'N0. Of Tickets',
                              style: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorDarkGray),
                            )),
                        Visibility(
                            visible: isTravelForm,
                            child: SizedBox(
                              height: screenHeight * 0.02,
                            )),
                        Visibility(
                            visible: isTravelForm,
                            child: Container(
                              height: screenHeight * 0.06,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                color: ColorViewConstants.colorTransferGray,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: screenWidth,
                              child: TextField(
                                controller: ticketsController,
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
                                style: AppTextStyles.medium,
                                //  textAlign: TextAlign.center,
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
