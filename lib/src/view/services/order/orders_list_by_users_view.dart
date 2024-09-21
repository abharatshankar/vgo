import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:vgo_flutter_app/src/utils/app_date_utils.dart';
import 'package:vgo_flutter_app/src/view/maps/GoogleMapView.dart';
import 'package:vgo_flutter_app/src/view/services/order/model/direct_order_response.dart';

import '../../../constants/color_view_constants.dart';
import '../../../constants/string_view_constants.dart';
import '../../../model/request/update_order_request.dart';
import '../../../model/response/order_list_response.dart';
import '../../../model/response/settings_response.dart';
import '../../../session/session_manager.dart';
import '../../../utils/app_string_utils.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/toast_utils.dart';
import '../../../utils/utils.dart';
import '../../../view_model/services_view_model.dart';
import '../address/address_list_view.dart';
import '../../common/common_tool_bar_transfer.dart';
import '../../common/widget_loader.dart';
import '../../team/store/store_chat_list_view.dart';
import 'order_generate_invoice_view.dart';

class OrdersListByUsersView extends StatefulWidget {
  OrdersListByUsersView({
    super.key,
    required this.category,this.subCategory,this.selectedType,this.subCategories,
  });

  String category = '';
  String? subCategory = '';
  String? selectedType = '';
  List<SubCategory>? subCategories = [];

  @override
  State<StatefulWidget> createState() => OrdersListByUsersState();
}

class OrdersListByUsersState extends State<OrdersListByUsersView>
    with TickerProviderStateMixin {
  bool showProgressCircle = false;
  late TabController _controller;
  int _selectedIndex = 0;
  String userName = '';
  String profession = '';
  bool isFilter = false;

  int tabsLength = 0;

  List<OrderStatusTab>? orderStatusTabList = [];
  List<OrderStatusTab>? filterOrderStatusTabList = [];

  List<DirectOrder> DirectOrdersList = [];

  List<Tab> tabList = [];
  String tabName = '';
  OtpFieldController otpController = OtpFieldController();
  var otpValue = '';
  SubCategory? _selectedValue;
  bool isFiltered = false;

  @override
  void initState() {
    super.initState();
    // SubCategory subCategory = SubCategory(name: 'Select One', items: []);
    // widget.subCategories!.insert(0,subCategory);
    loggerNoStack.e('category:  ' + widget.category);
    loggerNoStack.e('isOwnerOrder:  ' + isOwnerOrder().toString());

    SessionManager.getUserName().then((value) {
      loggerNoStack.e('gap id :${value!}');
      userName = value;
      SessionManager.getProfession().then((value) {
        profession = value!;
        if (widget.category == "store") {
          isFilter = true;
          _selectedValue =  widget.subCategories![0];
          callGetUserStoreOrders("main",profession);
        } else if (widget.category == "direct") {
          isFilter = false;
          print('profession is : $profession');
          callGetDirectOrders(widget.selectedType!,profession);
        }
        else{
          isFilter = true;
          callGetUserOrders("main",profession);
          _selectedValue =  widget.subCategories![0];
        }
      });
    });
  }

  bool isOwnerOrder() {
    return StringViewConstants.CONSTANT_OWNER_STORE_ORDER == widget.category;
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

  void callVerifyReceivedOrderFromCustomerApi(String orderId, String otp, Order order) {
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void callGetDirectOrders(String cat,String subCat) {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callGetDirectOrders(cat,subCat,
        completion: (response) {
          setState(() {
            showProgressCircle = false;
            DirectOrdersList.clear();
            if (response!.success ?? true) {
              DirectOrdersList = response.data;
            } else {
              loggerNoStack.e('No stores');
            }
          });
        });
  }

  void callGetUserOrders(String? type,String subcat) {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callGetUserOrders(userName,widget.category,subcat,
        completion: (response) {
      setState(() {
        showProgressCircle = false;
        tabList.clear();
        orderStatusTabList!.clear();

        if (response!.success ?? true) {
          orderStatusTabList = response.industryList;
          for (OrderStatusTab tab in orderStatusTabList!) {
            tabList.add(new Tab(
              text: tab.status,
            ));
          }
          tabsLength = orderStatusTabList!.length;
          if(orderStatusTabList!.length > 0){
            tabName = orderStatusTabList![0].status ?? '';
          }
          _controller =
              TabController(length: tabsLength, vsync: this,);

          _controller.addListener(() {
            setState(() {
              _selectedIndex = _controller.index;
              tabName = orderStatusTabList![_selectedIndex].status ?? '';
            });
          });
        } else {
          loggerNoStack.e('No stores');
        }
      });
    });
  }

  void callGetUserStoreOrders(String? type,String subcat) {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callGetUserStoreOrders(userName,widget.selectedType!,subcat,
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
          if(orderStatusTabList!.length > 0){
            tabName = orderStatusTabList![0].status ?? '';
          }
          tabsLength = orderStatusTabList!.length;
          _controller =
              TabController(length: tabsLength, vsync: this);
          _controller.addListener(() {
            setState(() {
              _selectedIndex = _controller.index;
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

   _updateTabs(List<OrderStatusTab>? filterOption,bool filter) async{
     _controller.dispose();
    tabList.clear();
    setState(() {});
    for (OrderStatusTab tab in filterOption!) {
      tabList.add(new Tab(
        text: tab.status,
      ));
    }

    tabName = filterOption[0].status ?? '';

    _controller =
        TabController(length: filterOption.length, vsync: this);

    _controller.addListener(() {
      _selectedIndex = _controller.index;
      tabName = filterOption[_selectedIndex].status ?? '';
    });
     setState(() {
       showProgressCircle = false;
     });
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorViewConstants.colorLightWhite,
      appBar: AppBar(
        toolbarHeight: isFilter ? 50.0 : 0,
        backgroundColor: ColorViewConstants.colorBlueSecondaryText,
        title:Text(
          "${widget.selectedType}",
          style: AppTextStyles.medium
              .copyWith(fontSize: 16, color: ColorViewConstants.colorWhite),
        ),
        actions: [
          isFilter == true ?
          DropdownButton<SubCategory>(
            value: _selectedValue,
            hint: Text('Select One'),
            icon: Icon(Icons.arrow_drop_down, color: Colors.white),
            dropdownColor: Colors.blue,
            underline: Container(), // Hides the underline
            style: TextStyle(color: Colors.white), // Text color in the dropdown
            onChanged: (SubCategory? newValue) async {
              orderStatusTabList!.clear();
              setState(() {
                isFiltered = true;
                _selectedValue = newValue!;
                showProgressCircle = true;
              });
              if(widget.category == "store"){
                callGetUserStoreOrders("drop",newValue!.name);
              }else{
                callGetUserOrders("drop",newValue!.name);
                // ServicesViewModel.instance.callGetUserOrders(userName,widget.category,newValue!.name,
                //     completion: (response) {
                //       setState(() {
                //         showProgressCircle = false;
                //         tabList.clear();
                //         orderStatusTabList!.clear();
                //         if (response!.success ?? true) {
                //           orderStatusTabList = response.industryList;
                //           for (OrderStatusTab tab in orderStatusTabList!) {
                //             tabList.add(new Tab(
                //               text: tab.status,
                //             ));
                //           }
                //           if(orderStatusTabList!.length > 0){
                //             tabName = orderStatusTabList![0].status ?? '';
                //           }
                //
                //           tabsLength = orderStatusTabList!.length;
                //           _controller =
                //               TabController(length: orderStatusTabList!.length, vsync: this);
                //
                //           _controller.addListener(() {
                //             setState(() {
                //               _selectedIndex = _controller.index;
                //               tabName = orderStatusTabList![_selectedIndex].status ?? '';
                //             });
                //           });
                //         } else {
                //           loggerNoStack.e('No stores');
                //         }
                //       });
                //     });
              }

            },
            items: widget.subCategories!.map((SubCategory subcat) {
              return DropdownMenuItem<SubCategory>(
                value: subcat,
                child: Text(subcat.name),
              );
            }).toList(),
          ) : Container(),
          SizedBox(width: 20),
        ],
        iconTheme: IconThemeData(color: Colors.white,),
      ),
      body: Stack(
        children: [
          widgetLoader(context, showProgressCircle),

          widget.category == "direct" ?
          showProgressCircle == true ? Container() :
              Container(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    widgetLoader(context, showProgressCircle),
                    isFilter == false ?
                    toolBarTransferWidget(context, "Direct ${widget.selectedType}", false,isBack: true) : Container(),
                  //  Text('Direct Orders'),
                    DirectOrdersList.isEmpty ?  Expanded(child: Center(child: Text('No Data found'))) :
                    Expanded(
                      child: ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount:DirectOrdersList.length,
                          itemBuilder: (context,index){
                            DirectOrder order = DirectOrdersList[index];
                            return Container(
                              padding: EdgeInsets.all(10),
                              child: Card(
                                elevation: 10,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    SizedBox(height: 10,),

                                    Row(
                                      children: [
                                        SizedBox(width: 15,),
                                        Expanded(
                                          child: Text(order.subCategory,
                                            style: TextStyle(color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        )
                                      ],
                                    ),

                                    SizedBox(height: 10,),

                                    Row(
                                      children: [
                                        SizedBox(width: 15,),
                                        Expanded(
                                          child: Text(order.itemName,
                                            style: TextStyle(color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        )
                                      ],
                                    ),

                                    SizedBox(height: 10,),

                                    Row(
                                      children: [
                                        SizedBox(width: 15,),
                                        Expanded(
                                          child: Text(order.orderItems,
                                            style: TextStyle(color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        )
                                      ],
                                    ),

                                    SizedBox(height: 10,),

                                    Row(
                                      children: [
                                        SizedBox(width: 15,),
                                        Expanded(
                                          child: Text(order.orderStatus,
                                            style: TextStyle(color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        )
                                      ],
                                    ),

                                    SizedBox(height: 10,),

                                    Row(
                                      children: [
                                        SizedBox(width: 15,),
                                        Expanded(
                                          child: Text(order.orderPriority,
                                            style: TextStyle(color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),

                                        GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              showProgressCircle = true;
                                              DirectOrdersList.clear();
                                            });
                                            ServicesViewModel.instance.callRetailerAcceptOrders(order.id.toString(),userName,
                                                completion: (response) {
                                                  setState(() {
                                                    showProgressCircle = false;
                                                    if (response!.data['success'] ?? true) { ToastUtils.instance
                                                        .showToast(response.data['message'], context: context, isError: false, bg: ColorViewConstants.colorYellow);

                                                    callGetDirectOrders("order",profession);
                                                    } else {
                                                      ToastUtils.instance
                                                          .showToast(response.data['message'], context: context, isError: true, bg: ColorViewConstants.colorRed);
                                                    }
                                                  });
                                                });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(25, 13, 25, 13),
                                            decoration: BoxDecoration(

                                                borderRadius: BorderRadius.circular(15),
                                                border: Border.all(
                                                    color: ColorViewConstants
                                                        .colorBlueSecondaryText)),
                                            child: Text('Accept',style: TextStyle(color: Colors.black,fontSize: 17,),),
                                          ),
                                        ),

                                        SizedBox(width: 15,),

                                      ],
                                    ),
                                    SizedBox(height: 15,),

                                  ],
                                ),
                              ),
                            );
                          }),
                    )

                  ],
                ),
              )
          :
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              isFilter == false ?
              toolBarTransferWidget(context, "Store ${widget.selectedType}" , false,isBack: true) : Container(),
              orderStatusTabList!.length == 0 ?
              Expanded(child: Center(child: Text(showProgressCircle == true ? "" :'No Data found',style: TextStyle(color: Colors.black,fontSize: 20),))) :
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
              orderStatusTabList!.length == 0 ? Container() :
              Visibility(
                  visible:  orderStatusTabList!.length == 0 ? false : true,
                  child: Expanded(
                    child: TabBarView(
                      controller: _controller,
                      children:  orderStatusTabList!.isEmpty
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
                                                                .orderDate.toString()) ??
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
                                                    visible: isOwnerOrder() &&
                                                        tabName == 'New',
                                                    child: MaterialButton(
                                                      height: 30,
                                                      minWidth: 30,
                                                      color: ColorViewConstants
                                                          .colorRed,
                                                      onPressed: () {
                                                        if (isOwnerOrder()) {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      OrderGenerateInvoiceView(
                                                                        order: dynamicContent
                                                                            .orderList![position],
                                                                      ))).then(
                                                              (val) => val &&
                                                                      isOwnerOrder()
                                                                  ? callGetUserStoreOrders("main",profession)
                                                                  : callGetUserOrders("main",profession));
                                                        } else {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      AddressListView(
                                                                        order: dynamicContent
                                                                            .orderList![position],
                                                                      ))).then(
                                                              (val) => val &&
                                                                      isOwnerOrder()
                                                                  ? callGetUserStoreOrders("main",profession)
                                                                  : callGetUserOrders("main",profession));
                                                        }
                                                      },
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40)),
                                                      child: Text(
                                                        'INVOICE',
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
                                                    visible: !isOwnerOrder() &&
                                                        tabName == 'Payment',
                                                    child: MaterialButton(
                                                      height: 30,
                                                      minWidth: 30,
                                                      color: ColorViewConstants
                                                          .colorRed,
                                                      onPressed: () {
                                                        //callDispatchOrderApi(dynamicContent.orderList![position]);
                                                        loggerNoStack.e(
                                                            'tab clicked ' +
                                                                tabName);
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
                                                        'RECEIVED',
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
                                                    visible: isOwnerOrder() &&
                                                        tabName == 'Accept',
                                                    child: MaterialButton(
                                                      height: 30,
                                                      minWidth: 30,
                                                      color: ColorViewConstants
                                                          .colorRed,
                                                      onPressed: () {
                                                        //callDispatchOrderApi(dynamicContent.orderList![position]);
                                                        loggerNoStack.e(
                                                            'tab clicked ' +
                                                                tabName);
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
                                                                                    callVerifyDispatchOrderFromStoreApi(dynamicContent.orderList![position].orderNo.toString(), pin, dynamicContent.orderList![position]);
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
                                                    )), Visibility(
                                                    visible: !isOwnerOrder() &&
                                                        tabName == 'Invoice',
                                                    child: MaterialButton(
                                                      height: 30,
                                                      minWidth: 30,
                                                      color: ColorViewConstants
                                                          .colorRed,
                                                      onPressed: () {
                                                        //callDispatchOrderApi(dynamicContent.orderList![position]);
                                                        loggerNoStack.e(
                                                            'tab clicked ' +
                                                                tabName);

                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    AddressListView(
                                                                      order: dynamicContent
                                                                          .orderList![position],
                                                                    ))).then(
                                                                (val) => val &&
                                                                isOwnerOrder()
                                                                ? callGetUserStoreOrders("main",profession)
                                                                : callGetUserOrders("main",profession));
                                                      },
                                                      shape:
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              40)),
                                                      child: Text(
                                                        'PAY',
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
                                                        tabName == 'Accept',
                                                    child: InkWell(
                                                      onTap: (){

                                                        MapsLauncher.createQueryUri('Post Office VIJAYAWADA (HEAD OFFICE), KRISHNA, ANDHRA PRADESH (AP), India (IN), Pin Code:- 520001 ');

/*                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => GoogleMapView(
                                                                )));*/

                                                      },
                                                      child:     Image.asset(
                                                        'assets/images/map/map_icon.png',
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                    )
                                              ),
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
