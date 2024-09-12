import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/model/request/create_transfer_request.dart';
import 'package:vgo_flutter_app/src/model/request/transfers_request.dart';
import 'package:vgo_flutter_app/src/model/transfers.dart';
import 'package:vgo_flutter_app/src/model/user.dart';
import 'package:vgo_flutter_app/src/session/session_manager.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';
import 'package:vgo_flutter_app/src/view/activity/transagent/transaction_success_view.dart';
import 'package:vgo_flutter_app/src/view/common/common_profile_name.dart';
import 'package:vgo_flutter_app/src/view/common/widget_loader.dart';
import 'package:vgo_flutter_app/src/view/services/transfer/recent_transaction_list.dart';
import 'package:vgo_flutter_app/src/view/services/transfer/transfer_amount_widget.dart';
import 'package:vgo_flutter_app/src/view/services/transfer/transfer_blue_button_widget.dart';
import 'package:vgo_flutter_app/src/view/services/transfer/transfer_view_transfer_widget.dart';
import 'package:vgo_flutter_app/src/view/services/transfer/widget_transfer_phone_number.dart';
import 'package:vgo_flutter_app/src/view_model/home_view_model.dart';
import 'package:vgo_flutter_app/src/view_model/services_view_model.dart';

import '../../../model/request/mobile_number_request.dart';
import '../../../model/wallet.dart';
import '../../../utils/toast_utils.dart';
import '../../../view_model/wallet_view_model.dart';
import '../../common/common_tool_bar_transfer.dart';

class MobileTransferView extends StatefulWidget {
  MobileTransferView({super.key, required this.number});

  String number;

  @override
  State<MobileTransferView> createState() => MobileTransferViewState();
}

class MobileTransferViewState extends State<MobileTransferView> {
  List<Transfers> transferList = [];
  List<Wallet> walletList = [];
  User? recipientUser = User();
  String userName = '';
  String loggedInUserNumber = '';
  String transferAmount = '';
  String currencyUser = '';

  bool showProgressCircle = false;
  bool showUserInfo = false;

  double walletBalanceUser = 0.0;

  @override
  void initState() {
    super.initState();
    setState(() {
      SessionManager.getUserName().then((value) {
        userName = value!;
        callGetMobileTransaction(userName);
        callWallet(userName);

        if (widget.number.isNotEmpty) {
          numberController.text = widget.number;
          callCheckUserExistsOrNot(widget.number);
        }
      });
    });

    SessionManager.getMobileNumber().then((value) {
      loggedInUserNumber = value!;
    });

    SessionManager.getCurrency().then((value) {
      currencyUser = value!;
    });
  }

  void callGetMobileTransaction(String userName) {
    setState(() {
      showProgressCircle = true;
    });

    final TransfersRequest request =
    TransfersRequest(userName: userName, tableName: '');

    ServicesViewModel.instance.callGetMobileTransaction(request,
        completion: (response) {
          setState(() {
            showProgressCircle = false;
            List<Transfers> transferListDup = response!.transferList!;
            for(Transfers transfer in  transferListDup){
              transfer.colorCode =
              ((math.Random().nextDouble() * 0xFFFFFF).toInt());

          /* if(userName == transfer.transferUserName){
                transferList.add(transfer);
              }*/
          transferList.add(transfer);
        }
          });
        });
  }

  void callCheckUserExistsOrNot(final String number) {
    if (number != loggedInUserNumber) {
      setState(() {
        showProgressCircle = true;
      });
      MobileNumberRequest request = MobileNumberRequest(mobileNumber: number);
      HomeViewModel.instance.callUserExistsOrNot(request,
          completion: (response) {
            setState(() {
              showProgressCircle = false;
            });

            if (response!.success ?? true) {
              setState(() {
                showUserInfo = true;
                recipientUser = response.user!;
              });
            } else {
              showUserInfo = false;
              ToastUtils.instance
                  .showToast(response.message!, context: context, isError: true);
            }
          });
    } else {
      ToastUtils.instance.showToast(
          StringViewConstants.recipientMobileNumber,
          context: context,
          isError: true);
    }
  }

  void callCreateMobileTransfer() {
    double amount = double.parse(transferAmount);

    if (amount > walletBalanceUser) {
      ToastUtils.instance.showToast('You don\'t have enough balance to transfer from wallet. You have $walletBalanceUser only',
          context: context, isError: true);
    } else {
      final CreateTransferRequest request = CreateTransferRequest(
        transferAmount: transferAmount,
        userName: userName,
        receiveUserName: recipientUser!.username,
        transferType: 'INR',
        transferPurpose: '',
      );

      setState(() {
        showProgressCircle = true;
      });

      ServicesViewModel.instance.callCreateTransfer(request,
          completion: (response) {
            setState(() {
              showProgressCircle = false;
            });

            if (response!.success ?? true) {
              setState(() {
                showUserInfo = false;

            transferAmount = '';
            numberController.text = '';
            //callGetMobileTransaction(userName);

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TransactionSuccessView(
                        isMobileTransfer: true,
                        isAdminTransfer: false,
                        transfers: response.transfers,
                        status: '',
                        navigationFrom: '',
                      )),
            ).then((val) => val
                ? callGetMobileTransaction(userName)
                : callGetMobileTransaction(userName));
            ;
          });
            } else {
              ToastUtils.instance
                  .showToast(response.message!, context: context, isError: true);
            }
          });
    }
  }

  void callWallet(String userName) {
    setState(() {
      showProgressCircle = true;
    });

    WalletViewModel.instance.callWallet(userName, completion: (response) {
      setState(() {
        showProgressCircle = false;
        walletList = response!.walletList!;

        for (Wallet wallet in walletList) {
          if (currencyUser.toLowerCase() == wallet.symbol!.toLowerCase()) {
            walletBalanceUser = wallet.quantity!.isNotEmpty
                ? double.parse(wallet.quantity!)
                : 0;

            loggerNoStack.e('walletBalanceUser : $walletBalanceUser');
          }
        }
      });
    });
  }

  final numberController = TextEditingController();

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
              children: [
                toolBarTransferWidget(context, StringViewConstants.transferToMobile, false),
                Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),

                          widgetTransferPhoneNumberCompletion(
                              context,
                              numberController,
                              TextInputAction.next,
                              StringViewConstants.recipientLoggedMobileNumber,
                              true,
                              true,
                              0.55, completion: (value) {
                            setState(() {
                              if (value.toString().length == 10) {
                                callCheckUserExistsOrNot(value);
                              } else {
                                showUserInfo = false;
                              }
                            });
                          }),

                          Visibility(
                              visible: showUserInfo,
                              child: widgetTransferViewTransfer(context)),
                          Visibility(
                            visible: showUserInfo && recipientUser != null,
                            child: Container(
                                color: ColorViewConstants.colorWhite,
                                padding: EdgeInsets.only(left: 15),
                                child: profileName(context, recipientUser,
                                    textColor: ColorViewConstants.colorWhite,
                                    nameColor: ColorViewConstants.colorPrimaryText,
                                    numberColor:
                                    ColorViewConstants.colorPrimaryText)),
                          ),

                          Visibility(
                              visible: showUserInfo,
                              child: widgetTransferAmount(context,
                                  completion: (number) {
                                    setState(() {
                                      transferAmount = number;
                                    });
                                  })),

                          Visibility(
                              visible: showUserInfo,
                              child: widgetTransferBlueButton(
                                  context,
                                  StringViewConstants.transfer,
                                  ColorViewConstants.colorBlueSecondaryText,
                                  transferAmount,
                                  StringViewConstants.pleaseEnterAmount, completion: (amount) {
                                callCreateMobileTransfer();
                              })),

                          SizedBox(
                            height: screenHeight * 0.003,
                          ),
                          Container(
                            width: screenWidth,
                            color: ColorViewConstants.colorWhite,
                            padding: EdgeInsets.only(
                                left: 15, right: 15, top: 15, bottom: 15),
                            child: Text(
                              StringViewConstants.recentTransaction,
                              style: AppTextStyles.medium.copyWith(
                            fontSize: 16,
                            backgroundColor: ColorViewConstants.colorWhite,
                            color: ColorViewConstants.colorPrimaryTextMedium,
                          ),
                        ),
                      ),
                      Visibility(
                          visible: true,
                          child: recentTransactionList(
                              context, transferList, StringViewConstants.mobile.toLowerCase(),
                              userName: userName, isMobileTransfer: true)),
                    ],
                      ),
                    ))
              ],
            ),
            widgetLoader(context, showProgressCircle)
          ],
        ));
  }
}
