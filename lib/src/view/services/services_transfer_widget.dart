import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/view/services/bank_upi_transfer/bank_upi_transfer_view.dart';
import 'package:vgo_flutter_app/src/view/services/transfer/mobile_transfer_view.dart';
import 'package:vgo_flutter_app/src/view/services/vgo_wallet_transfer/vgo_wallet_transaction_list_view.dart';
import 'package:vgo_flutter_app/src/view/services/vgo_wallet_transfer/vgo_wallet_transfer_view.dart';

import '../../model/transfer.dart';
import 'bank_upi_transfer/bank_upi_transfer_recent_list_view.dart';

Widget servicesTransferWidget(
    BuildContext context, List<Transfer>? transferList) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  var size = MediaQuery.of(context).size;
  final double itemHeight = (size.height - kToolbarHeight - 24) / 3.5;
  final double itemWidth = size.width / 2;

  return GridView.count(
      childAspectRatio: (itemWidth / itemHeight),
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      scrollDirection: Axis.vertical,
      children: List.generate(transferList!.length, (index) {
        return InkWell(
          onTap: () {
            if (transferList[index].partnerTitle!.toLowerCase() == StringViewConstants.mobile) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MobileTransferView(number: '',)));
            } else if (transferList[index].partnerTitle!.toLowerCase() ==
                StringViewConstants.bankUpi) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BankUpiTransferRecentListView()));
            } else if (transferList[index].partnerTitle!.toLowerCase() ==
                StringViewConstants.cash) {
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VgoWalletTransactionListView()));
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                transferList != null ? transferList[index].iconPath! : '',
                width: 35,
                height: 35,
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Text(
                transferList[index].partnerTitle!,
                style: AppTextStyles.medium.copyWith(
                  fontSize: 12.5,
                  color: ColorViewConstants.colorWhite,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        );
      }));
}
