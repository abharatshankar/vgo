import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/view/home/company_info/quantity_price_widget.dart';
import 'package:vgo_flutter_app/src/view/home/company_info/type_widget.dart';
import 'package:vgo_flutter_app/src/view/home/company_info/widgetQuantityPriceNew.dart';
import 'package:vgo_flutter_app/src/view/services/transfer/transfer_blue_button_widget.dart';

import '../../../model/company.dart';
import '../../../model/request/create_buyer_seller_order_request.dart';
import '../../../session/session_manager.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/toast_utils.dart';
import '../../../utils/utils.dart';
import '../../../view_model/home_view_model.dart';
import '../../common/widget_loader.dart';
import 'company_info_view.dart';
import 'company_info_widget.dart';
import 'models/BuyerOrderResponse.dart';

class BottomSheetHelper {
  static void showBottomSheet(BuildContext context1, Company? company, {required bool isBuy}
      ) {
    showModalBottomSheet(
      context: context1,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return BottomSheetContent(company: company, isBuy: true,completion: (response){
          print('success');
          Fluttertoast.showToast(msg: response!.message,
              toastLength: Toast.LENGTH_SHORT,
              fontSize: 15,
              backgroundColor: Colors.white,
              textColor: Colors.black);
        },);
      },
    ).whenComplete((){
      Navigator.of(context1).pop();
      Navigator.push(context1,
          MaterialPageRoute(builder: (context) => CompanyInfoView(company: company)));
    });
  }
}
void _onBottomSheetClosed(BuildContext context) {
  print("Closed bottomsheet");

}
class BottomSheetContent extends StatefulWidget {
  final Company? company;
  final bool isBuy;
  final Function(BuyerOrderResponse? response) completion;



  const BottomSheetContent({super.key,this.company, required this.isBuy, required this.completion});

  @override
  State<StatefulWidget> createState() => BottomSheetContentState();
}

class BottomSheetContentState extends State<BottomSheetContent> {
  String? userName;

  double qtyValue = 0.0;
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    SessionManager.getUserName().then((value) {
      userName = value!;
      loggerNoStack.e('userName : ' + userName!);
    });
    totalPrice = double.parse(widget.company!.stockPrice!);
        }

  bool showProgressCircle = false;


  bool callCreateBuyerOrder() {
    bool retVal = false;
    setState(() {
      showProgressCircle = true;
    });

    final CreateBuyerSellerOrderRequest request = CreateBuyerSellerOrderRequest(
      userName: userName,
      symbol:  widget.company!.symbol!,
      units: '$qtyValue',
      stockPrice: '$totalPrice',
    );

    HomeViewModel.instance.callCreateBuyerOrder(request,
        completion: (response) {
      setState(() {
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
    setState(() {
      showProgressCircle = true;
    });

    final CreateBuyerSellerOrderRequest request = CreateBuyerSellerOrderRequest(
      userName: userName,
      symbol: '1',
      units: '1',
      stockPrice: '1',
    );

    HomeViewModel.instance.callCreateSellerOrder(request,
        completion: (response) {
      setState(() {
        showProgressCircle = false;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ListView(
      reverse: true,
      physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap:true,
      children: [
        Container(
          height: screenHeight * 0.75,
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
              widgetCompanyInfo(context, widget.company),

              widgetType(context),

              Container(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.01,
                  left: screenHeight * 0.02,
                  right: screenHeight * 0.01,
                  bottom: screenHeight * 0.02,
                ),
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
                        SizedBox(
                          width: screenWidth * 0.5,
                          height: screenHeight * 0.01,
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
                              if(val!.isEmpty){
                                qtyValue = 0.0;
                                totalPrice = double.parse(widget.company!.stockPrice!);
                              }else{
                                qtyValue = double.parse(val.toString());
                                totalPrice = qtyValue * double.parse(widget.company!.stockPrice!);
                              }
                              setState(() {});
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
                        SizedBox(
                          width: screenWidth * 0.5,
                          height: screenHeight * 0.01,
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
              SizedBox(height: 25),
              widgetTransferBlueButton(
                context,
                showProgressCircle == true ? "Loading ..." :
                widget.isBuy ? "PROCEED TO BUY" : "PROCEED TO SEll",
                widget.isBuy ? ColorViewConstants.colorBlueSecondaryText : ColorViewConstants.colorRed,
                '1',
                " please enter quantity ",
                completion: (value) {
                  if(qtyValue != 0.0){
                    if (widget.isBuy) {
                      setState(() {
                        showProgressCircle = true;
                      });

                      final CreateBuyerSellerOrderRequest request = CreateBuyerSellerOrderRequest(
                        userName: userName,
                        symbol:  widget.company!.symbol!,
                        units: '$qtyValue',
                        stockPrice: '$totalPrice',
                      );

                      HomeViewModel.instance.callCreateBuyerOrder(request,
                          completion: (response) {
                            setState(() {
                              showProgressCircle = false;
                            });
                            if(response!.success == true){
                              widget.completion(response);
                              Navigator.pop(context, true);
                            }else{
                              widget.completion(response);
                            }
                          });
                      // Future.delayed(Duration(seconds: 2),() {
                      //   Navigator.pop(context, true);
                      // },);

                    } else {
                      callCreateSellerOrder();
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
    );
  }
}
