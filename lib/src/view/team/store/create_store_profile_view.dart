import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/model/request/create_store_request.dart';
import 'package:vgo_flutter_app/src/view_model/services_view_model.dart';

import '../../../constants/color_view_constants.dart';
import '../../../constants/string_view_constants.dart';
import '../../../model/store.dart';
import '../../../session/session_manager.dart';
import '../../../utils/app_box_decoration.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/toast_utils.dart';
import '../../../utils/utils.dart';
import '../../common/common_tool_bar_transfer.dart';
import '../../common/widget_loader.dart';
import '../product/product_service_list_view.dart';

class CreateStoreProfileView extends StatefulWidget {
  CreateStoreProfileView(
      {super.key,
      required this.title,
      required this.code,
      required this.categories});

  String title = '';
  String code = '';
  List<String>? categories = [];

  @override
  State<CreateStoreProfileView> createState() => CreateStoreProfileState();
}

class CreateStoreProfileState extends State<CreateStoreProfileView> {
  bool showProgressCircle = false;
  String userName = '';

  String toolBarTitle = '';
  String buttonTitle = '';
  String buttonTitleTwo = 'ADD SERVICES';

  Store? store;

  final storeNameController = TextEditingController();
  final storeTypeController = TextEditingController();
  final industryController = TextEditingController();
  final categoryController = TextEditingController();
  final supplyItemsController = TextEditingController();
  final locationController = TextEditingController();

  validateStoreCreation() {
    final CreateStoreRequest request = CreateStoreRequest(
        username: userName,
        status: 'Active',
        location: locationController.text,
        category: categoryController.text,
        industry: industryController.text,
        lat_location: '10.1011',
        lng_location: '11.1001',
        store_name: storeNameController.text,
        store_type: storeTypeController.text,
        supply_items: supplyItemsController.text);


      ServicesViewModel.instance.validateCreateStore(request, context,
          completion: (message, isValidForm) {
            if (isValidForm) {
              setState(() {
                showProgressCircle = true;
              });

              if(buttonTitle == 'UPDATE PROFILE'){
                ServicesViewModel.instance.calUpdateUserStore(store!.id.toString(),request,
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
                ServicesViewModel.instance.calCreateUserStore(request,
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

  callStoreList() {
    setState(() {
      showProgressCircle = true;
    });
    ServicesViewModel.instance.callGetUserStores(userName, widget.title,
        completion: (response) {
      setState(() {
        showProgressCircle = false;
      });

      setState(() {
        if (response!.success ?? true) {
          store = response.store!;

          if (widget.code == "FREELANCER") {
            toolBarTitle = 'UPDATE ' + widget.code + ' PROFILE';
            buttonTitle = 'UPDATE PROFILE';
            buttonTitleTwo = 'ADD PROFILE';
          } else {
            toolBarTitle = 'UPDATE ' + widget.code + ' STORE';
            buttonTitle = 'UPDATE STORE';
            buttonTitleTwo = 'ADD STORE';
          }

          storeNameController.text = store?.store_name ?? '';
          supplyItemsController.text = store?.supply_items ?? '';
          locationController.text = store?.location ?? '';
        } else {
          if (widget.code == "FREELANCER") {
            toolBarTitle = 'ADD ' + widget.code + ' PROFILE';
            buttonTitle = 'ADD PROFILE';
            buttonTitleTwo = 'ADD PROFILE';
          } else {
            toolBarTitle = 'ADD ' + widget.code + ' STORE';
            buttonTitle = 'ADD STORE';
            buttonTitleTwo = 'ADD STORE';
          }
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();

    SessionManager.getUserName().then((value) {
      userName = value!;
      loggerNoStack.e('userName :${userName}');
      callStoreList();
    });

    setState(() {
      storeTypeController.text = widget.code;
      industryController.text = widget.title;
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              toolBarTransferWidget(context, toolBarTitle, false),
              Visibility(
                visible: store != null,
                child: Padding(
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
                                builder: (context) => ProductServiceListView(
                                      title: widget.title,
                                      code: widget.code,
                                      store: store,
                                      categories: widget.categories!,
                                    )));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        buttonTitleTwo,
                        style: AppTextStyles.medium.copyWith(
                            fontSize: 16, color: ColorViewConstants.colorWhite),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
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
                              'Store Name',
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
                                controller: storeNameController,
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
                              'Store Type',
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
                                readOnly: true,
                                controller: storeTypeController,
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
                              'Industry',
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
                                controller: industryController,
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
                            Visibility(
                                visible: false,
                                child: Text(
                                  'Category',
                                  style: AppTextStyles.regular.copyWith(
                                      fontSize: 14,
                                      color: ColorViewConstants.colorDarkGray),
                                )),
                            Visibility(
                              visible: false,
                              child: Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                  color: ColorViewConstants.colorTransferGray,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: screenWidth,
                                child: TextField(
                                  controller: categoryController,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    hintText: '',
                                    hintStyle: AppTextStyles.regular.copyWith(
                                      fontSize: 14,
                                      color: ColorViewConstants.colorGray,
                                    ),
                                    enabledBorder:
                                        AppBoxDecoration.noInputBorder,
                                    focusedBorder:
                                        AppBoxDecoration.noInputBorder,
                                    border: AppBoxDecoration.noInputBorder,
                                  ),
                                  style: AppTextStyles.medium,
                                  //  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            Text(
                              'Supply Items',
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
                                controller: supplyItemsController,
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
                              'Location',
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
                                controller: locationController,
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
                      validateStoreCreation();
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
          ),
          widgetLoader(context, showProgressCircle),
        ],
      ),
    );
  }
}
