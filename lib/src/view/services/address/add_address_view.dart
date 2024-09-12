import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/model/request/create_address_request.dart';
import 'package:vgo_flutter_app/src/view/services/address/address_view_model.dart';

import '../../../session/session_manager.dart';
import '../../../utils/app_box_decoration.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/toast_utils.dart';
import '../../../utils/utils.dart';
import '../../common/common_tool_bar_transfer.dart';
import '../../common/widget_loader.dart';

class AddAddressView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddAddressState();
}

class AddAddressState extends State<AddAddressView> {
  bool showProgressCircle = false;

  final addressTypeController = TextEditingController();
  final houseNoController = TextEditingController();
  final addressOneController = TextEditingController();
  final addressTwoController = TextEditingController();
  final landMarkController = TextEditingController();
  final cityController = TextEditingController();
  final postelCodeController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();

  String userName = '';

  @override
  void initState() {
    super.initState();

    SessionManager.getUserName().then((value) {
      loggerNoStack.e('gap id :${value!}');
      userName = value;
    });
  }

  validateAddress() {
    setState(() {
      showProgressCircle = true;
    });

    CreateAddressRequest request = CreateAddressRequest(
      username: userName,
      address1: addressOneController.text,
      address2: addressTwoController.text,
      address_type: addressTypeController.text,
      city: cityController.text,
      country: countryController.text,
      house_no: houseNoController.text,
      land_mark: landMarkController.text,
      postal_code: postelCodeController.text,
      state: stateController.text,
    );

    AddressViewModel.instance.validateCreateStore(request, context,
        completion: (message, isValidForm) {
      if (isValidForm) {
        AddressViewModel.instance.callCreateAddress(request,
            completion: (response) {
          setState(() {
            showProgressCircle = false;
            if (response!.success ?? true) {
              Navigator.pop(context, true);
            } else {
              ToastUtils.instance.showToast(response.message!,
                  context: context, isError: true);
            }
          });
        });
      } else {
        ToastUtils.instance
            .showToast(message!, context: context, isError: true);
      }
    });
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
              validateAddress();
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Text(
              'Create Address',
              style: AppTextStyles.medium
                  .copyWith(fontSize: 16, color: ColorViewConstants.colorWhite),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                toolBarTransferWidget(context, 'New Address', false),
                Expanded(
                    child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Address Type',
                                  style: AppTextStyles.regular.copyWith(
                                      color: ColorViewConstants
                                          .colorPrimaryOpacityText80,
                                      fontSize: 14)),
                              TextSpan(
                                  text: ' *',
                                  style: AppTextStyles.medium.copyWith(
                                      color: ColorViewConstants.colorRed,
                                      fontSize: 14)),
                            ])),
                        SizedBox(height: screenHeight * 0.02),
                        Container(
                          width: screenWidth * 0.92,
                          height: screenHeight * 0.06,
                          decoration: BoxDecoration(
                            color: ColorViewConstants.colorTransferGray,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: TextField(
                              controller: addressTypeController,
                              decoration: InputDecoration(
                                hintStyle: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color:
                                      ColorViewConstants.colorPrimaryTextHint,
                                ),
                                enabledBorder: AppBoxDecoration.noInputBorder,
                                focusedBorder: AppBoxDecoration.noInputBorder,
                                border: AppBoxDecoration.noInputBorder,
                              ),
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorPrimaryText),
                              onChanged: (value) {},
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'House/Flat Number',
                                  style: AppTextStyles.regular.copyWith(
                                      color: ColorViewConstants
                                          .colorPrimaryOpacityText80,
                                      fontSize: 14)),
                              TextSpan(
                                  text: ' *',
                                  style: AppTextStyles.medium.copyWith(
                                      color: ColorViewConstants.colorRed,
                                      fontSize: 14)),
                            ])),
                        SizedBox(height: screenHeight * 0.02),
                        Container(
                          width: screenWidth * 0.92,
                          height: screenHeight * 0.06,
                          decoration: BoxDecoration(
                            color: ColorViewConstants.colorTransferGray,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: TextField(
                              controller: houseNoController,
                              decoration: InputDecoration(
                                hintStyle: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color:
                                      ColorViewConstants.colorPrimaryTextHint,
                                ),
                                enabledBorder: AppBoxDecoration.noInputBorder,
                                focusedBorder: AppBoxDecoration.noInputBorder,
                                border: AppBoxDecoration.noInputBorder,
                              ),
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorPrimaryText),
                              onChanged: (value) {},
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Address 1',
                                  style: AppTextStyles.regular.copyWith(
                                      color: ColorViewConstants
                                          .colorPrimaryOpacityText80,
                                      fontSize: 14)),
                              TextSpan(
                                  text: ' *',
                                  style: AppTextStyles.medium.copyWith(
                                      color: ColorViewConstants.colorRed,
                                      fontSize: 14)),
                            ])),
                        SizedBox(height: screenHeight * 0.02),
                        Container(
                          width: screenWidth * 0.92,
                          height: screenHeight * 0.06,
                          decoration: BoxDecoration(
                            color: ColorViewConstants.colorTransferGray,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: TextField(
                              controller: addressOneController,
                              decoration: InputDecoration(
                                hintStyle: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color:
                                      ColorViewConstants.colorPrimaryTextHint,
                                ),
                                enabledBorder: AppBoxDecoration.noInputBorder,
                                focusedBorder: AppBoxDecoration.noInputBorder,
                                border: AppBoxDecoration.noInputBorder,
                              ),
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorPrimaryText),
                              onChanged: (value) {},
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Address 2',
                                  style: AppTextStyles.regular.copyWith(
                                      color: ColorViewConstants
                                          .colorPrimaryOpacityText80,
                                      fontSize: 14)),
                              TextSpan(
                                  text: ' *',
                                  style: AppTextStyles.medium.copyWith(
                                      color: ColorViewConstants.colorRed,
                                      fontSize: 14)),
                            ])),
                        SizedBox(height: screenHeight * 0.02),
                        Container(
                          width: screenWidth * 0.92,
                          height: screenHeight * 0.06,
                          decoration: BoxDecoration(
                            color: ColorViewConstants.colorTransferGray,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: TextField(
                              controller: addressTwoController,
                              decoration: InputDecoration(
                                hintStyle: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color:
                                      ColorViewConstants.colorPrimaryTextHint,
                                ),
                                enabledBorder: AppBoxDecoration.noInputBorder,
                                focusedBorder: AppBoxDecoration.noInputBorder,
                                border: AppBoxDecoration.noInputBorder,
                              ),
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorPrimaryText),
                              onChanged: (value) {},
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Land Mark',
                                  style: AppTextStyles.regular.copyWith(
                                      color: ColorViewConstants
                                          .colorPrimaryOpacityText80,
                                      fontSize: 14)),
                              TextSpan(
                                  text: ' *',
                                  style: AppTextStyles.medium.copyWith(
                                      color: ColorViewConstants.colorRed,
                                      fontSize: 14)),
                            ])),
                        SizedBox(height: screenHeight * 0.02),
                        Container(
                          width: screenWidth * 0.92,
                          height: screenHeight * 0.06,
                          decoration: BoxDecoration(
                            color: ColorViewConstants.colorTransferGray,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: TextField(
                              controller: landMarkController,
                              decoration: InputDecoration(
                                hintStyle: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color:
                                      ColorViewConstants.colorPrimaryTextHint,
                                ),
                                enabledBorder: AppBoxDecoration.noInputBorder,
                                focusedBorder: AppBoxDecoration.noInputBorder,
                                border: AppBoxDecoration.noInputBorder,
                              ),
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorPrimaryText),
                              onChanged: (value) {},
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'City',
                                  style: AppTextStyles.regular.copyWith(
                                      color: ColorViewConstants
                                          .colorPrimaryOpacityText80,
                                      fontSize: 14)),
                              TextSpan(
                                  text: ' *',
                                  style: AppTextStyles.medium.copyWith(
                                      color: ColorViewConstants.colorRed,
                                      fontSize: 14)),
                            ])),
                        SizedBox(height: screenHeight * 0.02),
                        Container(
                          width: screenWidth * 0.92,
                          height: screenHeight * 0.06,
                          decoration: BoxDecoration(
                            color: ColorViewConstants.colorTransferGray,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: TextField(
                              controller: cityController,
                              decoration: InputDecoration(
                                hintStyle: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color:
                                      ColorViewConstants.colorPrimaryTextHint,
                                ),
                                enabledBorder: AppBoxDecoration.noInputBorder,
                                focusedBorder: AppBoxDecoration.noInputBorder,
                                border: AppBoxDecoration.noInputBorder,
                              ),
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorPrimaryText),
                              onChanged: (value) {},
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'State',
                                  style: AppTextStyles.regular.copyWith(
                                      color: ColorViewConstants
                                          .colorPrimaryOpacityText80,
                                      fontSize: 14)),
                              TextSpan(
                                  text: ' *',
                                  style: AppTextStyles.medium.copyWith(
                                      color: ColorViewConstants.colorRed,
                                      fontSize: 14)),
                            ])),
                        SizedBox(height: screenHeight * 0.02),
                        Container(
                          width: screenWidth * 0.92,
                          height: screenHeight * 0.06,
                          decoration: BoxDecoration(
                            color: ColorViewConstants.colorTransferGray,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: TextField(
                              controller: stateController,
                              decoration: InputDecoration(
                                hintStyle: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color:
                                      ColorViewConstants.colorPrimaryTextHint,
                                ),
                                enabledBorder: AppBoxDecoration.noInputBorder,
                                focusedBorder: AppBoxDecoration.noInputBorder,
                                border: AppBoxDecoration.noInputBorder,
                              ),
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorPrimaryText),
                              onChanged: (value) {},
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Country',
                                  style: AppTextStyles.regular.copyWith(
                                      color: ColorViewConstants
                                          .colorPrimaryOpacityText80,
                                      fontSize: 14)),
                              TextSpan(
                                  text: ' *',
                                  style: AppTextStyles.medium.copyWith(
                                      color: ColorViewConstants.colorRed,
                                      fontSize: 14)),
                            ])),
                        SizedBox(height: screenHeight * 0.02),
                        Container(
                          width: screenWidth * 0.92,
                          height: screenHeight * 0.06,
                          decoration: BoxDecoration(
                            color: ColorViewConstants.colorTransferGray,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: TextField(
                              controller: countryController,
                              decoration: InputDecoration(
                                hintStyle: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color:
                                      ColorViewConstants.colorPrimaryTextHint,
                                ),
                                enabledBorder: AppBoxDecoration.noInputBorder,
                                focusedBorder: AppBoxDecoration.noInputBorder,
                                border: AppBoxDecoration.noInputBorder,
                              ),
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorPrimaryText),
                              onChanged: (value) {},
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Postel code',
                                  style: AppTextStyles.regular.copyWith(
                                      color: ColorViewConstants
                                          .colorPrimaryOpacityText80,
                                      fontSize: 14)),
                              TextSpan(
                                  text: ' *',
                                  style: AppTextStyles.medium.copyWith(
                                      color: ColorViewConstants.colorRed,
                                      fontSize: 14)),
                            ])),
                        SizedBox(height: screenHeight * 0.02),
                        Container(
                          width: screenWidth * 0.92,
                          height: screenHeight * 0.06,
                          decoration: BoxDecoration(
                            color: ColorViewConstants.colorTransferGray,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 17.0),
                            child: TextField(
                              controller: postelCodeController,
                              decoration: InputDecoration(
                                hintStyle: AppTextStyles.regular.copyWith(
                                  fontSize: 14,
                                  color:
                                      ColorViewConstants.colorPrimaryTextHint,
                                ),
                                enabledBorder: AppBoxDecoration.noInputBorder,
                                focusedBorder: AppBoxDecoration.noInputBorder,
                                border: AppBoxDecoration.noInputBorder,
                              ),
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 14,
                                  color: ColorViewConstants.colorPrimaryText),
                              onChanged: (value) {},
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
              ],
            ),
            widgetLoader(context, showProgressCircle),
          ],
        ));
  }
}
