import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/view/common/no_data_found.dart';
import 'package:vgo_flutter_app/src/view/services/stores/product_details_by_store_view.dart';

import '../../../constants/color_view_constants.dart';
import '../../../model/request/create_order_request.dart';
import '../../../model/response/store_list_response.dart';
import '../../../session/session_manager.dart';
import '../../../utils/app_string_utils.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/toast_utils.dart';
import '../../../utils/utils.dart';
import '../../../view_model/services_view_model.dart';
import '../../common/common_tool_bar_transfer.dart';
import '../../common/widget_loader.dart';
import '../order/create_order_view.dart';
import '../order/orders_list_by_users_view.dart';

class StoresListByCategoryView extends StatefulWidget {
  StoresListByCategoryView({
    super.key,
    required this.category,
  });

  String category = '';

  @override
  State<StatefulWidget> createState() => StoresListByCategoryState();
}

class StoresListByCategoryState extends State<StoresListByCategoryView>
    with SingleTickerProviderStateMixin {
  bool showProgressCircle = false;
  TabController? _controller;
  int _selectedIndex = 0;
  String userName = '';

  List<Industry>? industryList = [];
  List<Tab> tabList = [];

  @override
  void initState() {
    super.initState();

    SessionManager.getUserName().then((value) {
      loggerNoStack.e('gap id :${value!}');
      userName = value;
    });

    callGetStoresByCategory();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  callCreateOrderApi(String storeId, String storeUserName, String supplyItems) {
    setState(() {
      showProgressCircle = true;
    });

    CreateOrderRequest request = CreateOrderRequest(
        username: userName,
        store_username: storeUserName,
        store_id: storeId,
        order_items: supplyItems);

    ServicesViewModel.instance.callCreateOrder(request, completion: (response) {
      setState(() {
        showProgressCircle = false;
      });

      if (response!.success ?? true) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrdersListByUsersView(
                  category: widget.category,
                    )));
      } else {
        ToastUtils.instance
            .showToast(response.message!, context: context, isError: true);
      }
    });
  }

  void callGetStoresByCategory() {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callGetStoresByCategory(widget.category,
        completion: (response) {
      setState(() {
        showProgressCircle = false;

        if (response!.success ?? true) {
          industryList = response.industryList;

          //storeList = industryList == null ? [] : industryList![0].storeList;

          for (Industry industry in industryList!) {
            tabList.add(new Tab(
              text: industry.category,
            ));
          }

          _controller =
              TabController(length: industryList!.length, vsync: this);
          // _controller.length = industryList!.length;

          _controller?.addListener(() {
            setState(() {
              _selectedIndex = _controller!.index;

              if (_selectedIndex == 1) {
              } else {}
            });
            print("Selected Index: ${_controller?.index}");
          });
        } else {
          loggerNoStack.e('No stores');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorViewConstants.colorLightWhite,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: ColorViewConstants.colorBlueSecondaryText,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              toolBarTransferWidget(context, widget.category, false),
              Visibility(
                  visible: industryList!.length == 0 ? false : true,
                  child: DefaultTabController(
                    initialIndex: _selectedIndex,
                    animationDuration: const Duration(milliseconds: 500),
                    length: industryList!.length,
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
              Expanded(
                child: industryList!.isNotEmpty
                    ? TabBarView(
                        controller: _controller,
                        children: industryList!.isEmpty
                            ? <Widget>[]
                            : industryList!.map((dynamicContent) {
                                return ListView.builder(
                                    itemCount: dynamicContent.storeList?.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, position) {
                                      final String name = dynamicContent
                                              .storeList![position]
                                              .store_name ??
                                          '';
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetailsByStoreView(
                                                        store: dynamicContent
                                                                .storeList![
                                                            position],
                                                        category: '',
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
                                              Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: ColorViewConstants
                                                      .colorBlueSecondaryText
                                                      .withOpacity(1.0),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    textAlign: TextAlign.center,
                                                    AppStringUtils
                                                            .extractFirstLetter(
                                                                name) ??
                                                        '',
                                                    style: AppTextStyles
                                                        .semiBold
                                                        .copyWith(
                                                      fontSize: 14,
                                                      color: ColorViewConstants
                                                          .colorWhite,
                                                    ),
                                                  ),
                                                ),
                                              ),
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
                                                  Text(
                                                    StringUtils.capitalize(
                                                            name) ??
                                                        '',
                                                    style: AppTextStyles.medium
                                                        .copyWith(
                                                            color: ColorViewConstants
                                                              .colorPrimaryText,
                                                          fontSize: 14),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  dynamicContent
                                                          .storeList![position]
                                                          .supply_items ??
                                                      '',
                                                  style: AppTextStyles.regular
                                                      .copyWith(
                                                          color: ColorViewConstants
                                                              .colorBlueSecondaryText,
                                                          fontSize: 14),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  dynamicContent
                                                          .storeList![position]
                                                          .location ??
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
                                                  onTap: () {
                                                      loggerNoStack.e(
                                                          'category : ' +
                                                              widget.category);
                                                      loggerNoStack.e(
                                                          'industry : ' +
                                                              dynamicContent.category.toString());
                                                      /*    callCreateOrderApi(
                                                        dynamicContent
                                                            .storeList![
                                                                position]
                                                            .store_id!
                                                            .toString(),
                                                        dynamicContent
                                                            .storeList![
                                                                position]
                                                            .store_username!,
                                                        dynamicContent
                                                            .storeList![
                                                                position]
                                                            .supply_items!);*/
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  CreateOrderView(
                                                                    store: dynamicContent
                                                                            .storeList![
                                                                        position],
                                                                    category:
                                                                        widget.category ??
                                                                            '',
                                                                    travelType: dynamicContent.category ?? '',
                                                                  )));
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.only(
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
                                                        'Create Order',
                                                        style: AppTextStyles
                                                            .medium
                                                            .copyWith(
                                                                color: ColorViewConstants
                                                                    .colorWhite,
                                                                fontSize: 14),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }).toList(),
                      )
                    : Visibility(
                        visible: !showProgressCircle,
                        child: widgetNoDataFound(context)),
              ),
            ],
          ),
          widgetLoader(context, showProgressCircle),
        ],
      ),
    );
  }
}
