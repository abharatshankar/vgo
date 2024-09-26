import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/model/company.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';
import 'package:vgo_flutter_app/src/view/home/company_info/type_widget.dart';

import '../../../model/request/create_buyer_seller_order_request.dart';
import '../../../utils/toast_utils.dart';
import '../../../view_model/home_view_model.dart';
import '../../services/transfer/transfer_blue_button_widget.dart';
import 'bottom_sheet.dart';
import 'company_info_widget.dart';


Widget widgetBuySell(BuildContext context, Company? company, String username, {required bool isBuy}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    margin: const EdgeInsets.only(top: 5, bottom: 10),
    padding: EdgeInsets.only(
        top: screenHeight * 0.02,
        left: screenHeight * 0.02,
        right: screenHeight * 0.02,
        bottom: screenHeight * 0.02),
    decoration: BoxDecoration(
      color: ColorViewConstants.colorBlue,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Want to buy/sell',
          style: AppTextStyles.medium.copyWith(
              fontSize: 16, color: ColorViewConstants.colorBlack),
        ),
        Container(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0,top: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              MaterialButton(
                  height: screenHeight * 0.05,
                  minWidth: screenWidth * 0.3,
                  color: ColorViewConstants.colorRed,
                  onPressed: () {
                    BottomSheetHelper.showBottomSheet(context, company,isBuy: true);
                },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: Text(
                    'SELL',
                    style: AppTextStyles.medium.copyWith(
                        fontSize: 14, color: ColorViewConstants.colorWhite),
                    textAlign: TextAlign.center,
                  ),
                ),


              MaterialButton(
                height: screenHeight * 0.05,
                minWidth: screenWidth * 0.3,
                color: ColorViewConstants.colorBlueSecondaryText,
                onPressed: () {
                  loggerNoStack.e("button pressed");
                  BottomSheetHelper.showBottomSheet(context, company, isBuy: true);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                child: Text(
                  'Buy',
                  style: AppTextStyles.medium.copyWith(
                      fontSize: 14, color: ColorViewConstants.colorWhite),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

selectCategorySheet(Company? company,bool isBuy,String? username){
  double qtyValue = 0.0;
  double totalPrice = 0.0;

  return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState1) {
        totalPrice = double.parse(company!.stockPrice!);
        bool showProgressCircle = false;


        bool callCreateBuyerOrder() {
          bool retVal = false;
          setState1(() {
            showProgressCircle = true;
          });

          final CreateBuyerSellerOrderRequest request = CreateBuyerSellerOrderRequest(
            userName: username!,
            symbol:  company.symbol!,
            units: '$qtyValue',
            stockPrice: '$totalPrice',
          );

          HomeViewModel.instance.callCreateBuyerOrder(request,
              completion: (response) {
                setState1(() {
                  showProgressCircle = false;
                });
                if(response!.success == true){
                  retVal = true;
                  ToastUtils.instance.showToast("${response.message}",
                      context: context, isError: false, bg: ColorViewConstants.colorYellow);
                }else{
                  retVal = false;
                  ToastUtils.instance.showToast("${response.message}",
                      context: context, isError: false, bg: ColorViewConstants.colorRed);
                }
              });
          return retVal;
        }

        void callCreateSellerOrder() {
          setState1(() {
            showProgressCircle = true;
          });

          final CreateBuyerSellerOrderRequest request = CreateBuyerSellerOrderRequest(
            userName: username,
            symbol: '1',
            units: '1',
            stockPrice: '1',
          );

          HomeViewModel.instance.callCreateSellerOrder(request,
              completion: (response) {
                setState1(() {
                  showProgressCircle = false;
                });
              });
        }

        return showProgressCircle == true ? CircularProgressIndicator() :
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.of(context).pop();
          },
          child: DraggableScrollableSheet(
            initialChildSize: 0.68,
            builder: (_, controller) => Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Divider(thickness: 4, color: Colors.grey.shade300, endIndent: 160, indent: 160,),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(35),
                        topLeft: Radius.circular(35),
                      ),
                      color: ColorViewConstants.colorWhite,
                    ),
                    child:Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        widgetCompanyInfo(context, company),

                        widgetType(context),

                        Container(
                          decoration: BoxDecoration(
                            color: ColorViewConstants.colorWhite,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(child:   Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Quantity',
                                        style: AppTextStyles.bold.copyWith(
                                          fontSize: 14,
                                          color: ColorViewConstants.colorLightBlack,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Container(
                                    decoration: BoxDecoration(
                                      color: ColorViewConstants.colorGrayTransparent,
                                      borderRadius:  BorderRadius.circular(10),
                                    ),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintStyle: AppTextStyles.regular.copyWith(
                                          fontSize: 14,
                                          color: ColorViewConstants.colorBlack,
                                        ),
                                        contentPadding: EdgeInsets.only(left: 15),
                                        hintText: 'Enter Quantity',
                                        border: InputBorder.none,
                                      ),
                                      style: AppTextStyles.medium,
                                      autofocus: false,
                                      onChanged: (String? val){
                                        setState1(() {
                                          if(val!.isEmpty){
                                            qtyValue = 0.0;
                                            totalPrice = double.parse(company.stockPrice!);
                                          }else{
                                            qtyValue = double.parse(val.toString());
                                            totalPrice = qtyValue * double.parse(company.stockPrice!);
                                          }
                                        });
                                      },
                                    ),
                                  ),

                                ],
                              ),),
                              SizedBox(width: 10,),
                              Expanded(child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Price',
                                        style: AppTextStyles.bold.copyWith(
                                          fontSize: 14,
                                          color: ColorViewConstants.colorLightBlack,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(right: 15),
                                    padding: EdgeInsets.all(13.0),
                                    decoration: BoxDecoration(
                                        color: ColorViewConstants.colorGrayTransparent,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      "$totalPrice",
                                      style: AppTextStyles.bold.copyWith(
                                        fontSize: 14,
                                        color: ColorViewConstants.colorLightBlack,
                                      ),
                                    ),
                                  ),

                                ],
                              ),),
                            ],
                          ),
                        ),

                        widgetTransferBlueButton(
                          context,
                          isBuy ? "PROCEED TO BUY" : "PROCEED TO SEll",
                          isBuy ? ColorViewConstants.colorBlueSecondaryText : ColorViewConstants.colorRed,
                          '1',
                          " please enter quantity ",
                          completion: (value) {
                            if(qtyValue != 0.0){
                              if (isBuy) {
                                Navigator.of(context).pop();
                              } else {

                              }
                            }else {
                              ToastUtils.instance.showToast("Please Enter Quantity ",
                                  context: context, isError: false, bg: ColorViewConstants.colorRed);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
  );
}

