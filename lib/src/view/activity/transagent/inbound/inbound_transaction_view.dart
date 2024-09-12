import 'dart:math' as math;

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/model/transfers.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/view/activity/transagent/inbound/inbound_list_widget.dart';
import 'package:vgo_flutter_app/src/view/activity/transagent/inbound/inbound_new_list_widget.dart';
import 'package:vgo_flutter_app/src/view/common/common_tool_bar_transfer.dart';
import 'package:vgo_flutter_app/src/view_model/services_view_model.dart';

import '../../../../constants/string_view_constants.dart';
import '../../../../model/coin.dart';
import '../../../../model/request/transfers_request.dart';
import '../../../../session/session_manager.dart';
import '../../../../utils/toast_utils.dart';
import '../../../../utils/utils.dart';
import '../../../../view_model/activity_view_model.dart';
import '../../../common/no_data_found.dart';
import '../../../common/widget_loader.dart';
import '../transaction_success_view.dart';

class InboundTransactionView extends StatefulWidget {
  InboundTransactionView({super.key});

  List<Coin> allInboundList = [];
  List<Coin> newInboundList = [];
  bool showProgressCircle = false;

  @override
  State<StatefulWidget> createState() => InboundViewState();
}

class InboundViewState extends State<InboundTransactionView>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int _selectedIndex = 0;
  bool showProgressCircle = false;
  Coin? selectedCoin;

  String? userName;

  @override
  void initState() {
    super.initState();

    SessionManager.getUserName().then((value) {
      userName = value;
      loggerNoStack.e('userName :${userName!}');
      callGetBankerInboundTransferOrders();
      callGetUserNewInboundTransferOrders(userName!);
    });
    _controller = TabController(length: 2, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
        if (_selectedIndex == 0) {
          callGetUserNewInboundTransferOrders(userName!);
        } else {
          callGetBankerInboundTransferOrders();
        }
      });
      print("Selected Index: ${_controller.index}");
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void callGetBankerInboundTransferOrders() {
    setState(() {
      showProgressCircle = true;
    });

    final TransfersRequest request = TransfersRequest(
      userName: userName,
      tableName: '',
    );

    ActivityViewModel.instance.callGetBankerInboundTransferOrders(request,
        completion: (response) {
      setState(() {
        showProgressCircle = false;
      });
      widget.allInboundList = response!.allCoinsList!;
    });
  }

  void callGetUserNewInboundTransferOrders(
    String userName,
  ) {
    setState(() {
      showProgressCircle = true;
    });

    ActivityViewModel.instance.callGetUserNewInboundTransferOrders(userName,
        completion: (response) {
      setState(() {
        showProgressCircle = false;

        widget.newInboundList.clear();
        for (Coin coin in response!.allCoinsList!) {
          coin.colorCode = ((math.Random().nextDouble() * 0xFFFFFF).toInt());
          widget.newInboundList.add(coin);
        }
      });
    });
  }

  void callConfirmTransferOrder(String transactionId, String status) {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callConfirmTransferOrder(transactionId, status,
        completion: (response) {
      setState(() {
        showProgressCircle = false;
      });

      if (response!.success ?? true) {
        final Coin nextCoin = Coin(
            currency: response.coin!.currency,
            tableName: '',
            userName: response.coin!.userName,
            transCurrency: response.coin!.transCurrency,
            transAmount: response.coin!.transAmount,
            accountNumber: response.coin!.accountNumber,
            accountHolderName: response.coin!.accountHolderName,
            bankName: response.coin!.bankName,
            receiverName: response.coin!.receiverName);

        Transfers transfer = Transfers(
            name: 'Transfer',
            createdAt: response.coin!.createdAt,
            createdDate: response.coin!.updatedAt,
            updatedAt: response.coin!.updatedAt,
            transCurrency: response.coin!.transfer_currency ?? '',
            transactionNumber: response.coin!.id,
            amount: response.coin!.transfer_amount ?? '');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionSuccessView(
              isMobileTransfer: false,
              isAdminTransfer: true,
              transfers: transfer,
              status: status,
              navigationFrom: '',
            ),
          ),
        ).then((val) => val
            ? callGetUserNewInboundTransferOrders(userName!)
            : callGetBankerInboundTransferOrders());
      } else {
        ToastUtils.instance
            .showToast(response.message!, context: context, isError: true);
      }
    });
  }

  void showTransactionCheckAlert() {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.confirm,
        text: 'Did you received the same amount? ',
        confirmBtnText: StringViewConstants.matched,
        cancelBtnText: StringViewConstants.notMatched,
        confirmBtnColor: ColorViewConstants.colorBlueSecondaryText,
        onConfirmBtnTap: () {
          callConfirmTransferOrder(
              selectedCoin!.transactionRefNo.toString(), 'Match');
        },
        onCancelBtnTap: () {
          callConfirmTransferOrder(
              selectedCoin!.transactionRefNo.toString(), 'NotMatch');
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                toolBarTransferWidget(context, "Inbound Transfer", false),
                DefaultTabController(
                  initialIndex: _selectedIndex,
                  animationDuration: const Duration(milliseconds: 500),
                  length: 2,
                  child: TabBar(
                    controller: _controller,
                    physics: const NeverScrollableScrollPhysics(),
                    labelColor: ColorViewConstants.colorBlueSecondaryText,
                    unselectedLabelColor: ColorViewConstants.colorHintGray,
                    labelStyle: AppTextStyles.medium.copyWith(fontSize: 16),
                    indicatorColor: ColorViewConstants.colorBlueSecondaryText,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: const [
                      Tab(
                        text: "New",
                      ),
                      Tab(
                        text: "All",
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(controller: _controller, children: [
                    widgetInboundNewList(context, widget.newInboundList,
                        completion: (coin) {
                      selectedCoin = coin;
                      showTransactionCheckAlert();
                    }),
                    widgetInBoundList(
                      context,
                      widget.allInboundList,
                    ),
                  ]),
                ),
              ],
            ),
            widgetLoader(context, showProgressCircle),
            Visibility(
                visible: !showProgressCircle &&
                    widget.newInboundList.length == 0 &&
                    _selectedIndex == 0,
                child: widgetNoDataFound(context,
                    message: StringViewConstants.noNewTransactionsFound)),
            Visibility(
                visible: !showProgressCircle &&
                    widget.allInboundList.length == 0 &&
                    _selectedIndex == 1,
                child: widgetNoDataFound(context,
                    message: StringViewConstants.noInboundTransactionsFound))
          ],
        ));
  }
}
