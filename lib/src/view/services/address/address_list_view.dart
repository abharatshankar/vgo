import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/model/response/order_list_response.dart';
import 'package:vgo_flutter_app/src/view/services/address/address_view_model.dart';

import '../../../constants/string_view_constants.dart';
import '../../../model/request/update_order_request.dart';
import '../../../model/response/address_list_response.dart';
import '../../../session/session_manager.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/toast_utils.dart';
import '../../../utils/utils.dart';
import '../../../view_model/services_view_model.dart';
import '../../common/common_tool_bar_transfer.dart';
import '../../common/widget_loader.dart';
import 'add_address_view.dart';
import 'address_list_widget.dart';

class AddressListView extends StatefulWidget {
  AddressListView({
    super.key,
    required this.order,
  });

  Order? order;
  @override
  State<StatefulWidget> createState() => AddressState();
}

class AddressState extends State<AddressListView> {
  bool showProgressCircle = false;

  String userName = '';
  List<Address> addressList = [];

  @override
  void initState() {
    super.initState();
    SessionManager.getUserName().then((value) {
      loggerNoStack.e('userName :${value!}');
      userName = value;

      callAddressListApi();
    });
  }

  callAddressListApi() {
    setState(() {
      showProgressCircle = true;
    });
    AddressViewModel.instance.callGetAddressList(userName,
        completion: (response) {
      setState(() {
        showProgressCircle = false;
        if (response!.success ?? true) {
          addressList = response.addressList!;
        } else {
          ToastUtils.instance
              .showToast(response.message!, context: context, isError: true);
        }
      });
    });
  }

  callDeleteAddressApi(String id) {
    setState(() {
      showProgressCircle = true;
    });
    AddressViewModel.instance.callDeleteAddress(id, completion: (response) {
      setState(() {
        showProgressCircle = false;
        if (response!.success ?? true) {
          callAddressListApi();
        } else {
          ToastUtils.instance
              .showToast(response.message!, context: context, isError: true);
        }
      });
    });
  }

  void callCreatePaymentApi(Order order, String addressId) {
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
        order_status: 'Payment',
        delivery_address_id: addressId);

    ServicesViewModel.instance.callUpdateOrder(
        request, order.orderNo.toString(), completion: (response) {
      setState(() {
        showProgressCircle = false;
        if (response!.success ?? true) {
          //Navigator.pop(context, true);
        } else {
          ToastUtils.instance
              .showToast(response.message!, context: context, isError: true);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final addressTypeController = TextEditingController();

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
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddAddressView()))
                  .then((val) =>
                      val ? callAddressListApi() : callAddressListApi());
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Text(
              'Add Address',
              style: AppTextStyles.medium
                  .copyWith(fontSize: 16, color: ColorViewConstants.colorWhite),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: Stack(
          children: [
            widgetLoader(context, showProgressCircle),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                toolBarTransferWidget(
                    context, 'Select Delivery Address', false),
                widgetAddressList(context, addressList,
                    completion: (isDelete, address) {
                  if (isDelete) {
                    callDeleteAddressApi(address.id.toString());
                  } else {
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.confirm,
                      text: 'Do you want to deliver to this address?',
                      confirmBtnText: StringViewConstants.yes,
                      cancelBtnText: StringViewConstants.no,
                      confirmBtnColor:
                          ColorViewConstants.colorBlueSecondaryText,
                      onConfirmBtnTap: () {
                        callCreatePaymentApi(widget.order!, address.id.toString());
                      },
                    );
                  }
                })
              ],
            ),
          ],
        ));
  }
}
