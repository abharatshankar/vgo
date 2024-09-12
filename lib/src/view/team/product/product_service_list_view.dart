import 'package:basic_utils/basic_utils.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/view/team/product/create_product_service_view.dart';
import 'package:vgo_flutter_app/src/view_model/services_view_model.dart';

import '../../../constants/color_view_constants.dart';
import '../../../constants/string_view_constants.dart';
import '../../../model/response/product_list_response.dart';
import '../../../model/store.dart';
import '../../../session/session_manager.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/utils.dart';
import '../../common/common_tool_bar_transfer.dart';
import '../../common/widget_loader.dart';

class ProductServiceListView extends StatefulWidget {
  ProductServiceListView(
      {super.key,
      required this.title,
      required this.code,
      required this.store,
      required this.categories});

  String title = '';
  String code = '';
  Store? store;
  List<String> categories = [];

  @override
  State<ProductServiceListView> createState() => CreateProductServiceState();
}

class CreateProductServiceState extends State<ProductServiceListView> {
  bool showProgressCircle = false;
  String userName = '';

  String toolBarTitle = '';
  String buttonTitle = '';
  String buttonTitleTwo = 'ADD PROFILE';

  List<Product>? productList = [];

  void showAlert(String message) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      text: message,
      confirmBtnText: StringViewConstants.okay,
      confirmBtnColor: ColorViewConstants.colorBlueSecondaryText,
      onConfirmBtnTap: () {
        Navigator.pop(
          context,
        );
      },
    );
  }

  callProductProfileList() {
    setState(() {
      showProgressCircle = true;
    });

    final String storeId =
        widget.store == null ? '' : widget.store!.id.toString() ?? '';

    if (storeId.isNotEmpty) {
      ServicesViewModel.instance.callGetProductsByStore(storeId,
          completion: (response) {
        setState(() {
          showProgressCircle = false;
        });

        setState(() {
          if (response!.success ?? true) {
            productList = response.productList;

            if (widget.code == "FREELANCER") {
              /* toolBarTitle = 'UPDATE ' + widget.code + ' PROFILE';
            buttonTitle = 'UPDATE PROFILE';
            buttonTitleTwo = 'ADD PROFILE';*/
              toolBarTitle = 'ADD SERVICES';
              buttonTitle = 'ADD SERVICES';
            } else {
              /*toolBarTitle = 'UPDATE ' + widget.code + ' STORE';
            buttonTitle = 'UPDATE STORE';
            buttonTitleTwo = 'ADD STORE';*/
              toolBarTitle = 'ADD PRODUCTS';
              buttonTitle = 'ADD PRODUCTS';
            }
          } else {
            if (widget.code == "FREELANCER") {
              toolBarTitle = 'ADD ' + widget.code + ' SERVICES';
              buttonTitle = 'ADD PROFILE';
              buttonTitleTwo = 'ADD PRODUCTS';
            } else {
              toolBarTitle = 'ADD ' + widget.code + ' SERVICES';
              buttonTitle = 'ADD PRODUCTS';
              buttonTitleTwo = 'ADD PRODUCTS';
            }
          }
        });
      });
    } else {
      loggerNoStack.e('store id is empty');
    }
  }

  @override
  void initState() {
    super.initState();

    SessionManager.getUserName().then((value) {
      userName = value!;
      loggerNoStack.e('userName :${userName}');
      callProductProfileList();
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
              toolBarTransferWidget(context, toolBarTitle, false),
              Padding(
                padding: EdgeInsets.all(20),
                child: Align(
                  child: MaterialButton(
                    minWidth: screenWidth * 0.9,
                    height: screenHeight * 0.06,
                    color: ColorViewConstants.colorGreen,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateProductServiceView(
                                    title: widget.title,
                                    code: widget.code,
                                    categories: widget.categories,
                                    store: widget.store,
                                    isStore: false,
                                    product: Product(),
                                    isNew: true,
                                  )));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      buttonTitle,
                      style: AppTextStyles.medium.copyWith(
                          fontSize: 16, color: ColorViewConstants.colorWhite),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: productList?.length,
                  itemBuilder: (context, position) {
                    final String name =
                        productList![position].product_name.toString();
                    String fNameLName = '';
                    if (name.contains(' ')) {
                      var arrayName = name.split(' ');
                      fNameLName =
                          StringUtils.capitalize(arrayName[0].substring(0, 1));
                      fNameLName = fNameLName +
                          (arrayName.length > 1
                              ? StringUtils.capitalize(
                                  arrayName[1].substring(0, 1))
                              : '');
                    } else {
                      fNameLName = StringUtils.capitalize(name.substring(0, 1));
                    }

                    return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CreateProductServiceView(
                                        title: widget.title,
                                        code: widget.code,
                                        categories: widget.categories,
                                        store: widget.store,
                                        isStore: false,
                                        product: productList![position],
                                        isNew: false,
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                          padding: EdgeInsets.only(left: 10, right: 10, top: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: ColorViewConstants
                                      .colorBlueSecondaryText
                                      .withOpacity(1.0),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    fNameLName,
                                    style: AppTextStyles.semiBold.copyWith(
                                      fontSize: 16,
                                      color: ColorViewConstants.colorWhite,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productList![position].product_name ?? '',
                                      style: AppTextStyles.medium.copyWith(
                                          fontSize: 14,
                                          color: ColorViewConstants
                                              .colorPrimaryText),
                                    ),
                                    Text(
                                      productList![position].product_desc ?? '',
                                      style: AppTextStyles.medium.copyWith(
                                          fontSize: 13,
                                          color: ColorViewConstants
                                              .colorPrimaryTextHint),
                                    ),
                                    Text(
                                      productList![position].category ?? '',
                                      style: AppTextStyles.medium.copyWith(
                                          fontSize: 13,
                                          color: ColorViewConstants
                                              .colorPrimaryTextHint),
                                    )
                                  ],
                                ),
                              )),
                              Text(
                                productList![position].price ?? '',
                                style: AppTextStyles.semiBold.copyWith(
                                    color: ColorViewConstants
                                        .colorBlueSecondaryDarkText,
                                    fontSize: 15),
                              )
                            ],
                          ),
                        ));
                  })
            ],
          )
        ],
      ),
    );
  }
}
