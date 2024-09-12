import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/model/transfers.dart';
import 'package:vgo_flutter_app/src/network/api/api_constants.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';
import 'package:vgo_flutter_app/src/view/common/common_profile_name.dart';
import 'package:vgo_flutter_app/src/view/common/widget_loader.dart';
import 'package:vgo_flutter_app/src/view/services/transfer/widget_chat_receiver_view.dart';
import 'package:vgo_flutter_app/src/view/services/transfer/widget_chat_sender_view.dart';

import '../../../model/exchange_amount.dart';
import '../../../model/request/create_transfer_request.dart';
import '../../../model/request/transfer/transfer_recipient_request.dart';
import '../../../model/request/transfers_order_receipt_request.dart';
import '../../../model/user.dart';
import '../../../session/session_manager.dart';
import '../../../utils/app_box_decoration.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/toast_utils.dart';
import '../../../view_model/services_view_model.dart';

class TransferChatView extends StatefulWidget {
  TransferChatView({super.key, required this.isMobileTransfer,this.transfers});

  bool isMobileTransfer;

  Transfers? transfers;

  @override
  State<TransferChatView> createState() => TransferChatState();
}

class TransferChatState extends State<TransferChatView> {
  User? user;
  final amountController = TextEditingController();
  String selectedType = 'INR';
  String userName = '';
  ExchangeAmount? exchangeAmount;

  bool showProgressCircle = false;

  List<Transfers>? transferList = [];

  var items = ['INR'];

  int radioSelectedValue = -1;
  Transfers? transferred;
  String receiveAmountText = '';
  String exchangeAmountText = '';
  String transactionFeeText = '';

  @override
  void initState() {
    super.initState();

    SessionManager.getUserName().then((value) {
      userName = value!;
      if (widget.isMobileTransfer) {
        callGetMobileRecipientTransactions();
      } else {
        callGetRecipientTransactions();
      }
    });

    if (widget.transfers != null) {
      String? number = widget.isMobileTransfer
          ? widget.transfers?.receiverMobileNumber
          : widget.transfers?.accountNumber;
      String? name = widget.isMobileTransfer
          ? widget.transfers?.receiverName
          : widget.transfers?.receiverUserName;

      user = User(
        mobileNumber: number,
        firstName: name,
      );
      user?.colorCode = widget.transfers?.colorCode;
    } else {
      loggerNoStack.e('transfers is null');
    }
  }

  void callGetRecipientTransactions(){
    String recipientUsername = '';
    if(userName == widget.transfers?.receiverUserName){
      recipientUsername = widget.transfers!.transferUserName!;
    } else {
      recipientUsername = widget.transfers!.receiverUserName!;
    }

    final TransferRecipientRequest request = TransferRecipientRequest(
        recipientId: recipientUsername, username: userName);

    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callGetRecipientTransactions(request,
        completion: (response) {
          setState(() {
            showProgressCircle = false;
          });

          if (response!.success ?? true) {
        setState(() {
          transferList = response.transferList;

          if (transferList!.isEmpty) {
            transferList = widget.transfers?.childTransferList;
          } else {
            loggerNoStack
                .e('Api is working and fetching data from api response');
          }
        });
      } else {
        ToastUtils.instance
            .showToast(response.message!, context: context, isError: true);
      }
    });
  }

  void callGetMobileRecipientTransactions() {
    String recipientUsername = '';
    if(userName == widget.transfers?.receiverUserName){
      recipientUsername = widget.transfers!.transferUserName!;
    } else {
      recipientUsername = widget.transfers!.receiverUserName!;
    }

    final TransferRecipientRequest request = TransferRecipientRequest(
        recipientId: recipientUsername, username: userName);

    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callGetMobileRecipientTransactions(request,
        completion: (response) {
          setState(() {
            showProgressCircle = false;
          });

          if (response!.success ?? true) {
            setState(() {
              transferList = response.transferList;
            });
          } else {
            ToastUtils.instance
                .showToast(response.message!, context: context, isError: true);
          }
        });
  }

  void callCreateMobileTransfer() {
    String recipientUsername = '';
    if(userName == widget.transfers?.receiverUserName){
      recipientUsername = widget.transfers!.transferUserName!;
    } else {
      recipientUsername = widget.transfers!.receiverUserName!;
    }


    final CreateTransferRequest request = CreateTransferRequest(
      transferAmount: amountController.text,
      userName: userName,
      receiveUserName: recipientUsername,
      transferType: 'INR',
      transferPurpose: '',
    );

    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callCreateTransfer(request, completion: (response){
      setState(() {
        showProgressCircle = false;
      });

      if (response!.success ?? true) {
        setState(() {
          amountController.text = '';
          callGetMobileRecipientTransactions();
        });
      } else {
        ToastUtils.instance
            .showToast(response.message!, context: context, isError: true);
      }
    });
  }

  void callConfirmOutboundTransferOrderChat() {
    String status = '';
    if (radioSelectedValue == 1) {
      status = 'Matched';
    } else if (radioSelectedValue == 2) {
      status = 'Not Matched';
    } else if (radioSelectedValue == 3) {
      status = 'Fake Receipt';
    }

    final TransfersOrderReceiptRequest request = TransfersOrderReceiptRequest(
      id: transferred?.id.toString(),
      tableName: APIConstant.PAYMENT_TRANSFER_TO_BANK,
      transferOrderStatus: status,
      comments: status,
    );

    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callConfirmOutboundTransferOrderChat(request,
        completion: (response) {
      setState(() {
        showProgressCircle = false;
      });

      if (response!.success ?? true) {
        setState(() {});
      } else {
        ToastUtils.instance
            .showToast(response.message!, context: context, isError: true);
      }
    });
  }

  void callBankCreateTransfer() {
    setState(() {
      showProgressCircle = true;
    });

    final CreateTransferRequest request = CreateTransferRequest(
        userName: userName,
        accountNumber: '',
        bankName: '',
        bankerUserName: '',
        exchangeAmount: exchangeAmount!.exchangeRate ?? '0',
        recipientImagePath: '',
        receiveAmount: receiveAmountText,
        recipientId: widget.transfers!.receiverUserName,
        transactionFees: exchangeAmount!.transactionFees ?? '0',
        transferAccountType: '',
        transferAmount: amountController.text,
        transferCurrency: 'INR',
        transferPurpose: '',
        transferType: 'INR');

    ServicesViewModel.instance.callBankCreateTransfer(request,
        completion: (response) {
      setState(() {
        showProgressCircle = false;

        if (response!.success!) {
          ToastUtils.instance.showToast(response.message!,
              context: context,
              isError: false,
              bg: ColorViewConstants.colorGreen);
        } else {
          ToastUtils.instance.showToast(response.message!,
              context: context,
              isError: false,
              bg: ColorViewConstants.colorRed);
        }
      });
    });
  }

  void callGetCurrencyExchange(String from, String to, String transferAmount) {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callGetCurrencyExchange(from, to, transferAmount,
        completion: (response) {
      setState(() {
        showProgressCircle = false;
      });

      setState(() {
        if (response!.success ?? true) {
          setState(() {
            exchangeAmount = response.exchangeAmount;
            receiveAmountText = exchangeAmount?.receiveAmount ?? '0';
            exchangeAmountText = exchangeAmount?.exchangeRate ?? '0';
            transactionFeeText = exchangeAmount?.transactionFees ?? '0';
          });
        } else {
          ToastUtils.instance
              .showToast(response.message!, context: context, isError: true);
        }
      });
    });
  }

  void showTransactionCancelAlert() {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.confirm,
        text: 'Dou you want to confirm this transaction?',
        confirmBtnText: StringViewConstants.yes,
        cancelBtnText: StringViewConstants.no,
        confirmBtnColor: ColorViewConstants.colorBlueSecondaryText,
        onConfirmBtnTap: () {
          callConfirmOutboundTransferOrderChat();
        },
        onCancelBtnTap: () {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: ColorViewConstants.colorBlueSecondaryText,
        ),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                profileName(context, user,
                    isBack: true,
                    bg: ColorViewConstants.colorBlueSecondaryText,
                    userBg: ColorViewConstants.colorWhite,
                    textColor: ColorViewConstants.colorWhite,
                    nameColor: ColorViewConstants.colorWhite,
                    numberColor: ColorViewConstants.colorWhite),
                Expanded(
                    child: Container(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.007),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                              AssetImage('assets/images/services/chat_bg.png'),
                              fit: BoxFit.fill)),
                      child: ListView.builder(
                          itemCount: transferList!.length,
                          itemBuilder: (context, position) {
                        return transferList![position].transferUserName !=
                                userName
                            ? widgetChatReceiver(
                                context, transferList![position])
                            : widgetChatSender(context,
                            transferList![position],
                                radioSelectedValue,
                                widget.isMobileTransfer,
                                completion: (value, transfer) {
                                setState(() {
                                  radioSelectedValue = value;
                                  transferred = transfer;
                                  showTransactionCancelAlert();
                                });
                              });
                      }),
                    )),
                Container(
                  color: ColorViewConstants.colorWhite,
                  height: screenHeight * 0.09,
                  padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: 40,
                        width: screenWidth * 0.2,
                        child: DropdownButton(
                            iconEnabledColor:
                            ColorViewConstants.colorBlueSecondaryText,
                            iconDisabledColor:
                            ColorViewConstants.colorBlueSecondaryText,
                            value: selectedType,
                            isExpanded: true,
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  items,
                                  style: AppTextStyles.medium,
                                ),
                              );
                            }).toList(),
                            onChanged: (onChanged) {}),
                      ),
                      SizedBox(
                        width: screenWidth * 0.04,
                      ),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: amountController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: StringViewConstants.enterAmout,
                            hintStyle: AppTextStyles.regular.copyWith(
                              fontSize: 16,
                              color: ColorViewConstants.colorGray,
                            ),
                            labelStyle:
                                AppTextStyles.medium.copyWith(fontSize: 15),
                            enabledBorder: AppBoxDecoration.noInputBorder,
                            focusedBorder: AppBoxDecoration.noInputBorder,
                            border: AppBoxDecoration.noInputBorder,
                          ),
                          style: AppTextStyles.medium,
                          onChanged: (value) {
                            loggerNoStack.e('entered amount : ' + value);

                            if (!widget.isMobileTransfer) {
                              callGetCurrencyExchange('INR', 'INR', value);
                            }
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (amountController.text.isNotEmpty) {
                            if (widget.isMobileTransfer) {
                              callCreateMobileTransfer();
                            } else {
                              callBankCreateTransfer();
                            }
                          } else {
                            ToastUtils.instance.showToast(
                                StringViewConstants.enterTheAmountToSend,
                                context: context,
                                isError: false,
                                bg: ColorViewConstants.colorYellow);
                          }
                        },
                        child: SvgPicture.asset(
                          'assets/images/services/ic_send.svg',
                          height: 35,
                          width: 35,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            widgetLoader(context, showProgressCircle)
          ],
        )
    );
  }
}
