import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/model/request/create_product_request.dart';
import 'package:vgo_flutter_app/src/view_model/services_view_model.dart';

import '../../../constants/color_view_constants.dart';
import '../../../constants/string_view_constants.dart';
import '../../../model/response/product_list_response.dart';
import '../../../model/store.dart';
import '../../../session/session_manager.dart';
import '../../../utils/app_box_decoration.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/toast_utils.dart';
import '../../../utils/utils.dart';
import '../../common/common_tool_bar_transfer.dart';
import '../../common/widget_loader.dart';

class CreateProductServiceView extends StatefulWidget {
  CreateProductServiceView(
      {super.key,
      required this.title,
      required this.code,
      required this.categories,
      required this.store,
      required this.isStore,
      required this.product,
      required this.isNew});

  String title = '';
  String code = '';
  List<String>? categories = [];
  Store? store;
  Product? product;
  bool isStore = false;
  bool isNew = false;

  @override
  State<CreateProductServiceView> createState() => CreateProductServiceState();
}

class CreateProductServiceState extends State<CreateProductServiceView> {
  bool showProgressCircle = false;
  String userName = '';

  String toolBarTitle = '';
  String buttonTitle = '';
  String buttonTitleTwo = 'ADD PROFILE';

  final productNameController = TextEditingController();
  final productDescController = TextEditingController();
  final priceController = TextEditingController();

  String selectedCategory = '';

  validateProductCreation() {
    final CreateProductRequest request = CreateProductRequest(
        store_id: widget.store!.id.toString(),
        category: selectedCategory,
        status: 'Active',
        price: priceController.text,
        product_name: productNameController.text,
        product_desc: productDescController.text);

    ServicesViewModel.instance.validateCreateProduct(request, context,
        completion: (message, isValidForm) {
      if (isValidForm) {
        setState(() {
          showProgressCircle = true;
        });

        if(!widget.isNew){
          ServicesViewModel.instance.calUpdateProductForStore(request, widget.product!.id.toString(),
              completion: (response) {
                setState(() {
                  showProgressCircle = false;
                });

                if (response!.success ?? true) {
                  showAlert(response.message!);
                } else {
                  ToastUtils.instance
                      .showToast(response.message!, context: context, isError: true);
                }
              });
        } else {
          ServicesViewModel.instance.calCreateProductForStore(request,
              completion: (response) {
                setState(() {
                  showProgressCircle = false;
                });

                if (response!.success ?? true) {
                  showAlert(response.message!);
                } else {
                  ToastUtils.instance
                      .showToast(response.message!, context: context, isError: true);
                }
              });
        }

      } else {
        ToastUtils.instance
            .showToast(message!, context: context, isError: true);
      }
    });
  }

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

  @override
  void initState() {
    super.initState();

    loggerNoStack.e('categories ' + widget.categories.toString());

    selectedCategory = widget.categories![0];

    if (widget.code == "FREELANCER") {
      if (widget.isNew) {
        toolBarTitle = 'ADD ' + widget.code + ' SERVICES';
        buttonTitle = 'ADD SERVICES';
        buttonTitleTwo = 'ADD PRODUCTS';
      } else {
        toolBarTitle = 'UPDATE ' + widget.code + ' SERVICES';
        buttonTitle = 'UPDATE SERVICES';
        buttonTitleTwo = 'UPDATE PRODUCTS';
      }
    } else {
      if (widget.isNew) {
        toolBarTitle = 'ADD ' + widget.code + ' PRODUCTS';
        buttonTitle = 'ADD PRODUCTS';
        buttonTitleTwo = 'ADD PRODUCTS';
      } else {
        toolBarTitle = 'UPDATE ' + widget.code + ' PRODUCTS';
        buttonTitle = 'UPDATE PRODUCTS';
        buttonTitleTwo = 'UPDATE PRODUCTS';
      }
    }

    SessionManager.getUserName().then((value) {
      userName = value!;
      loggerNoStack.e('userName :${userName}');
    });

    productNameController.text = widget.product!.product_name! ?? '';
    productDescController.text = widget.product!.product_desc! ?? '';
    priceController.text = widget.product!.price! ?? '';
    selectedCategory = widget.product!.category! ?? '';
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
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Visibility(
                visible: true,
                child: Expanded(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Product Name',
                              style: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorDarkGray),
                            ),
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
                                controller: productNameController,
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
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            Text(
                              'Category',
                              style: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorDarkGray),
                            ),
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
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    iconEnabledColor: ColorViewConstants
                                        .colorBlueSecondaryText,
                                    iconDisabledColor: ColorViewConstants
                                        .colorBlueSecondaryText,
                                    value: selectedCategory,
                                    isExpanded: false,
                                    style: AppTextStyles.medium
                                        .copyWith(fontSize: 16),
                                    items:
                                        widget.categories?.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(
                                          items,
                                          style: AppTextStyles.medium,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedCategory = value!;
                                      });
                                    },
                                  ),
                                )),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            SizedBox(
                              height: screenHeight * 0.005,
                            ),
                            Text(
                              'Description',
                              style: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorDarkGray),
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            Container(
                              height: screenHeight * 0.1,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                color: ColorViewConstants.colorTransferGray,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: screenWidth,
                              child: TextField(
                                controller: productDescController,
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
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            Text(
                              'Price',
                              style: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorDarkGray),
                            ),
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
                                controller: priceController,
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
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Align(
                  child: MaterialButton(
                    minWidth: screenWidth * 0.9,
                    height: screenHeight * 0.06,
                    color: ColorViewConstants.colorGreen,
                    onPressed: () {
                      validateProductCreation();
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
              )
            ],
          )
        ],
      ),
    );
  }
}
