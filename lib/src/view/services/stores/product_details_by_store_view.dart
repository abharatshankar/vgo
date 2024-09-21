import 'package:basic_utils/basic_utils.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/model/response/product_list_response.dart';

import '../../../constants/color_view_constants.dart';
import '../../../constants/string_view_constants.dart';
import '../../../model/request/create_order_request.dart';
import '../../../model/store.dart';
import '../../../session/session_manager.dart';
import '../../../utils/app_string_utils.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/toast_utils.dart';
import '../../../utils/utils.dart';
import '../../../view_model/services_view_model.dart';
import '../../common/common_tool_bar_transfer.dart';
import '../../common/widget_loader.dart';
import '../order/orders_list_by_users_view.dart';
import '../order_form.dart';

class ProductDetailsByStoreView extends StatefulWidget {
    ProductDetailsByStoreView({
    super.key,
    required this.store,
    required this.category,
    required this.subCategory,
    required this.type,
  });

  Store? store;
  String category = '';
  String subCategory = '';
  String type = '';

  @override
  State<StatefulWidget> createState() => ProductDetailsByStoreState();
}

class ProductDetailsByStoreState extends State<ProductDetailsByStoreView> {
  bool showProgressCircle = false;

  String userName = '';
  bool isTravelForm = false;

  @override
  void initState() {
    super.initState();

    SessionManager.getUserName().then((value) {
      loggerNoStack.e('gap id :${value!}');
      userName = value;
    });

    if (widget.category.toLowerCase() == 'travel') {
      isTravelForm = true;
    } else {
      isTravelForm = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  callCreateOrderApi(String storeId, String storeUserName, Product product) {
    setState(() {
      showProgressCircle = true;
    });

    final supplyItemsBuffer = StringBuffer();
    if (isTravelForm) {
      /*  supplyItemsBuffer.write("From: " + product.);
      supplyItemsBuffer.write(",To: " + toController.text);
      supplyItemsBuffer.write(",Date: " + dojController.text);
      supplyItemsBuffer.write(",Tickets: " + ticketsController.text);
      supplyItemsBuffer.write(",Travel By: " + travelTypeController.text);*/
      supplyItemsBuffer.write(product.product_desc);
    } else {
      supplyItemsBuffer.write(product.product_desc);
    }

    CreateOrderRequest request = CreateOrderRequest(
        username: userName,
        store_username: storeUserName,
        store_id: storeId,
        order_items: supplyItemsBuffer.toString());

    ServicesViewModel.instance.callCreateOrder(request, completion: (response) {
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

  void showAlert(Product product) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.confirm,
        text: 'Do you want to create order for this product?',
        confirmBtnText: StringViewConstants.yes,
        cancelBtnText: StringViewConstants.no,
        confirmBtnColor: ColorViewConstants.colorBlueSecondaryText,
        onConfirmBtnTap: () {
          loggerNoStack.e('Store id : ' + widget.store!.store_id!.toString());
          loggerNoStack.e('Store username : ' + widget.store!.store_username!.toString());
          // Create order for a product alone
          callCreateOrderApi(widget.store!.store_id!.toString() ?? '',
              widget.store!.store_username! ?? '', product);
        },
        onCancelBtnTap: () {
          loggerNoStack.e('....Order creation cancelled....');
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
              toolBarTransferWidget(
                  context, widget.store?.store_name! ?? '', false),
              Container(
                  padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                  margin: EdgeInsets.all(0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: ColorViewConstants.colorBlueSecondaryText
                              .withOpacity(1.0),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            AppStringUtils.extractFirstLetter(
                                    widget.store!.store_name!) ??
                                '',
                            style: AppTextStyles.semiBold.copyWith(
                              fontSize: 14,
                              color: ColorViewConstants.colorWhite,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Visibility(
                              visible: true,
                              child: Text('Store Details : ',
                                  style: AppTextStyles.semiBold.copyWith(
                                    fontSize: 15,
                                    color: ColorViewConstants
                                        .colorBlueSecondaryDarkText,
                                  ))),
                          SizedBox(
                            height: 10,
                          ),
                          Visibility(
                              visible: true,
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: 'Store Name : ',
                                      style: AppTextStyles.medium.copyWith(
                                          color: ColorViewConstants
                                              .colorPrimaryTextHint,
                                          fontSize: 14),
                                    ),
                                    TextSpan(
                                        text: widget.store!.store_name!,
                                        style: AppTextStyles.medium.copyWith(
                                            color: ColorViewConstants
                                                .colorPrimaryText,
                                            fontSize: 14)),
                                  ]))),
                          SizedBox(
                            height: 10,
                          ),
                          Visibility(
                              visible: true,
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: 'Store Location : ',
                                      style: AppTextStyles.medium.copyWith(
                                          color: ColorViewConstants
                                              .colorPrimaryTextHint,
                                          fontSize: 14),
                                    ),
                                    TextSpan(
                                        text: widget.store!.location!,
                                        style: AppTextStyles.medium.copyWith(
                                            color: ColorViewConstants
                                                .colorPrimaryText,
                                            fontSize: 14)),
                                  ]))),
                          SizedBox(
                            height: 10,
                          ),
                          Visibility(
                              visible: false,
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: 'Supply Items : ',
                                      style: AppTextStyles.medium.copyWith(
                                          color: ColorViewConstants
                                              .colorPrimaryTextHint,
                                          fontSize: 14),
                                    ),
                                    TextSpan(
                                        text: widget.store!.supply_items!,
                                        style: AppTextStyles.medium.copyWith(
                                            color: ColorViewConstants
                                                .colorPrimaryText,
                                            fontSize: 14)),
                                  ])))
                        ],
                      ),
                      Visibility(
                          visible: false,
                          child: MaterialButton(
                            minWidth: screenWidth * 0.3,
                            height: screenHeight * 0.05,
                            color: ColorViewConstants.colorGreen,
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Create Order',
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 15,
                                  color: ColorViewConstants.colorWhite),
                              textAlign: TextAlign.center,
                            ),
                          )),
                    ],
                  )),
              Visibility(
                  visible: false,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text('Available Products : ',
                        style: AppTextStyles.semiBold.copyWith(
                          fontSize: 15,
                          color: ColorViewConstants.colorBlueSecondaryDarkText,
                        )),
                  )),
              Divider(
                color: ColorViewConstants.colorGrayTransparent80,
              ),
              loadSubList(context, widget.store!.productList!, widget.store!,widget.category,widget.subCategory, completion: (product){
                showAlert(product);
              })
            ],
          ),
        ],
      ),
    );
  }
}



Widget loadSubList(BuildContext context, List<Product> list, Store store,String category,String subCat,
    {required Function(Product product) completion}) {
  loggerNoStack.e("product list : " + list.length.toString());

  return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, position) {
        final String name = list[position].product_name ?? '';
        final String cat = list[position].category ?? '';

        return InkWell(
          onTap: () {
/*            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TeamSubEarningsListView(title: StringUtils.capitalize(name) ?? '',teamDetail:  list[position],)));*/
          },
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: ColorViewConstants.colorBlueSecondaryText
                        .withOpacity(1.0),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      AppStringUtils.extractFirstLetter(name) ?? '',
                      style: AppTextStyles.semiBold.copyWith(
                        fontSize: 14,
                        color: ColorViewConstants.colorWhite,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          StringUtils.capitalize(name) ?? '',
                          style: AppTextStyles.medium.copyWith(
                              color: ColorViewConstants.colorPrimaryText,
                              fontSize: 14),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          list[position].product_desc ?? '',
                          style: AppTextStyles.regular.copyWith(
                              color: ColorViewConstants.colorBlueSecondaryText,
                              fontSize: 14),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                      ],
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      list[position].price ?? '',
                      style: AppTextStyles.regular.copyWith(
                          color: ColorViewConstants.colorBlueSecondaryText,
                          fontSize: 14),
                    ),
                    MaterialButton(
                      color: ColorViewConstants.colorBlueSecondaryText,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderForm(
                                itemName: StringUtils.capitalize(name) ?? "",
                                cat: category,
                                subcat: subCat,
                                type: "Order",
                              )),
                        );
                       // completion(list[position]);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'Order',
                        style: AppTextStyles.medium.copyWith(
                            fontSize: 16, color: ColorViewConstants.colorWhite),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
