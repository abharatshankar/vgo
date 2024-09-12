import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/model/coin.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/view/activity/transagent/outbound/outbound_all_list_widget.dart';
import 'package:vgo_flutter_app/src/view/activity/transagent/outbound/outbound_list_widget.dart';
import 'package:vgo_flutter_app/src/view/common/common_tool_bar_transfer.dart';
import 'package:vgo_flutter_app/src/view/common/no_data_found.dart';
import 'package:vgo_flutter_app/src/view/common/widget_loader.dart';
import 'package:vgo_flutter_app/src/view_model/activity_view_model.dart';

import '../../../../model/request/transfers_request.dart';
import '../../../../session/session_manager.dart';
import '../../../../utils/toast_utils.dart';
import '../../../../utils/utils.dart';
import '../../../../view_model/services_view_model.dart';
import '../../../services/inbound_outbound_transfer_confirm_view.dart';

class OutboundTransactionView extends StatefulWidget {
  OutboundTransactionView({super.key});

  @override
  State<StatefulWidget> createState() => OutboundViewState();
}

class OutboundViewState extends State<OutboundTransactionView>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int _selectedIndex = 0;
  bool showProgressCircle = false;

  String? userName;

  List<Coin> newOutboundList = [];
  List<Coin> allOutboundList = [];

  Coin? nextCoin;

  String errorMessage = 'Transactions not found.';

  @override
  void initState() {
    super.initState();

    SessionManager.getUserName().then((value) {
      userName = value;
      callGetNewOutboundTransferOrders();
      loggerNoStack.e('userName :${userName!}');
    });

    _controller = TabController(length: 2, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
        if (_selectedIndex == 0) {
          callGetNewOutboundTransferOrders();
        } else {
          callGetBankerOutboundTransferOrders();
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

  void callGetNewOutboundTransferOrders() {
    setState(() {
      showProgressCircle = true;
    });

    final TransfersRequest request = TransfersRequest(
      userName: userName,
      tableName: '',
    );

    ActivityViewModel.instance.apiGetNewOutboundTransfersOrders(request,
        completion: (response) {
          setState(() {
            showProgressCircle = false;

            if (response!.success ?? true) {
              newOutboundList = response.allCoinsList!;
            } else {
              newOutboundList = [];
            }

            errorMessage =  response.message!;

          });
        });
  }


  void callGetBankerOutboundTransferOrders() {
    setState(() {
      showProgressCircle = true;
    });

    final TransfersRequest request = TransfersRequest(
      userName: userName,
      tableName: '',
    );

    ActivityViewModel.instance.callGetBankerOutboundTransferOrders(request,
        completion: (response) {
      setState(() {
        showProgressCircle = false;
        allOutboundList = response!.allCoinsList!;
      });
    });
  }

  void callAcceptOutboundOrder(String id) {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callAcceptOutboundTransferOrder(
        id, userName!, completion: (response) {
      setState(() {
        showProgressCircle = false;
      });

      if (response!.success ?? true) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InboundOutboundTransferConfirmView(
              coin: nextCoin, // Asserting non-null
            ),
          ),
        ).then((val)=>val?callGetNewOutboundTransferOrders():null);
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
        text: 'Do you want to accept this transaction? ',
        confirmBtnText: StringViewConstants.yes,
        cancelBtnText: StringViewConstants.no,
        confirmBtnColor: ColorViewConstants.colorBlueSecondaryText,
        onConfirmBtnTap: () {
          callAcceptOutboundOrder(nextCoin!.id.toString());
        },
        onCancelBtnTap: () {
          loggerNoStack.e('Not accepted by transaget $userName');
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
                toolBarTransferWidget(context, "Outbound Transfer", false),
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
                        text: StringViewConstants.New ,
                      ),
                      Tab(
                        text: StringViewConstants.all,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(controller: _controller, children: [
                    widgetOutBoundList(context, newOutboundList,
                        completion: (value) {
                      nextCoin = value;
                      showTransactionCheckAlert();
                    }),
                    widgetOutBoundAllList(context, allOutboundList),
                  ]),
                )
              ],
            ),
            widgetLoader(context, showProgressCircle),
            Visibility(
                visible: !showProgressCircle && newOutboundList.length == 0 && _selectedIndex == 0,
                child: widgetNoDataFound(context, message: errorMessage)),
            Visibility(
                visible: !showProgressCircle && allOutboundList.length == 0 && _selectedIndex == 1,
                child: widgetNoDataFound(context, message: StringViewConstants.noOutboundTransactionsFound))
          ],
        ));
  }
}
