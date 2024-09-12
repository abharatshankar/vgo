import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/view/activity/transagent/inbound/inbound_transaction_view.dart';
import 'package:vgo_flutter_app/src/view/activity/transagent/upi/upi_bank_view.dart';

import '../../../model/response/settings_response.dart';
import '../../../model/settings_data.dart';
import 'outbound/outbound_transaction_view.dart';

Widget transAgentWidget(BuildContext context, List<TransAgent> list) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  var size = MediaQuery.of(context).size;
 final double itemHeight = (size.height - kToolbarHeight - 24) / 3.0;
  final double itemWidth = size.width / 1;


  return Padding(padding: EdgeInsets.only(top: 15,left: 15,
  right: 15),
      child: GridView.count(
      childAspectRatio: (itemWidth / itemHeight),
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: List.generate(list.length, (index) {
          return InkWell(
            onTap: () {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OutboundTransactionView()),
                );
              }
              else if (index == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            InboundTransactionView(
                            )));
              }
              else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UPIBankView(
                            )));
              }
            },
            child: Container(
              margin: EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ColorViewConstants.colorWhite,
              ),
              padding: EdgeInsets.only(
                  top: screenHeight * 0.03,
                  bottom: screenHeight * 0.02,
                  left: screenHeight * 0.01,
                  right: screenHeight * 0.01),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    list[index].categoryIconPath ?? '',
                    width: 25,
                    height: 25,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    list[index].categoryName ?? '',
                    style: AppTextStyles.medium.copyWith(
                      fontSize: 12,
                      color: ColorViewConstants.colorLightBlack,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        })
        ,
      ),
  );

}
