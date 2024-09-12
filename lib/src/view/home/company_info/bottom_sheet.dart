import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/view/home/company_info/type_widget.dart';
import 'package:vgo_flutter_app/src/view/services/transfer/transfer_blue_button_widget.dart';

import '../../../model/company.dart';
import '../../../model/request/create_buyer_seller_order_request.dart';
import '../../../session/session_manager.dart';
import '../../../utils/utils.dart';
import '../../../view_model/home_view_model.dart';
import 'company_info_widget.dart';

class BottomSheetHelper {
  static void showBottomSheet(BuildContext context, Company? company, {required bool isBuy}
      ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetContent(company: company, isBuy: true);
      },
    );
  }
}

class BottomSheetContent extends StatefulWidget {
  final Company? company;
  final bool isBuy;


  const BottomSheetContent({super.key, this.company, required this.isBuy});

  @override
  State<StatefulWidget> createState() => BottomSheetContentState();
}

class BottomSheetContentState extends State<BottomSheetContent> {
  String? userName;

  @override
  void initState() {
    super.initState();
    SessionManager.getUserName().then((value) {
      userName = value!;
      loggerNoStack.e('userName : ' + userName!);
    });
        }

  bool showProgressCircle = false;


  void callCreateBuyerOrder() {
    setState(() {
      showProgressCircle = true;
    });

    final CreateBuyerSellerOrderRequest request = CreateBuyerSellerOrderRequest(
      userName: userName,
      symbol: '1',
      units: '1',
      stockPrice: '1',
    );

    HomeViewModel.instance.callCreateBuyerOrder(request,
        completion: (response) {
      setState(() {
        showProgressCircle = false;
      });
    });
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

    return BottomSheet(
      onClosing: () {},
      builder: (BuildContext context) {
        return Container(
          height: screenHeight * 0.45,
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(35),
              topLeft: Radius.circular(35),
            ),
            color: ColorViewConstants.colorWhite,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              widgetCompanyInfo(context, widget.company),

              widgetType(context),

              //  widgetQuantityPrice(context),

              widgetTransferBlueButton(
                context,
               widget.isBuy ? "PROCEED TO BUY" : "PROCEED TO SEll",
                widget.isBuy ? ColorViewConstants.colorBlueSecondaryText : ColorViewConstants.colorRed,
                '1',
                " please enter quantity ",
                completion: (value) {
                  if (widget.isBuy) {
                    callCreateBuyerOrder();
                  } else {
                    callCreateSellerOrder();
                  }

                },
              ),
            ],
          ),
        );
      },
    );
  }
}
