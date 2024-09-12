import 'package:basic_utils/basic_utils.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/model/request/transfers_order_receipt_request.dart';
import 'package:vgo_flutter_app/src/session/session_manager.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/view/common/common_tool_bar_back.dart';
import 'package:vgo_flutter_app/src/view/services/vgo_wallet_transfer/upload_image_widget.dart';
import 'package:vgo_flutter_app/src/view_model/activity_view_model.dart';

import '../../model/coin.dart';
import '../../model/timer_menu.dart';
import '../../utils/toast_utils.dart';
import '../../utils/utils.dart';
import '../../view_model/services_view_model.dart';

class InboundOutboundTransferConfirmView extends StatefulWidget {
  InboundOutboundTransferConfirmView({super.key, this.coin,});

  Coin? coin;

  List<TimerMenu> timerBankList = [];
  List<TimerMenu> timerWalletMenuList = [];

  @override
  State<StatefulWidget> createState() => TransferConfirmState();
}

class TransferConfirmState extends State<InboundOutboundTransferConfirmView>
    with SingleTickerProviderStateMixin {
  bool isTimerRequired = true;
  bool showProgressCircle = false;
  XFile? pickedFile0;
  CroppedFile? croppedFile0;
  String userName = '';
  int transactionId = 0;
  String fileUploadName = '';

  @override
  void initState() {
    super.initState();

    SessionManager.getUserName().then((value){
      userName = value!;
    });

    SessionManager.getTransactionId().then((value){
      transactionId = value!;
    });

    callGetTransferTimer();
  }

  late CustomTimerController _controller = CustomTimerController(
      vsync: this,
      begin: Duration(seconds: 1),
      end: Duration(seconds: 900),
      initialState: CustomTimerState.reset,
      interval: CustomTimerInterval.milliseconds);

  Future<void> requestPermissions() async {

    var androidInfo = await DeviceInfoPlugin().androidInfo;
    var release = androidInfo.version.release;
    var sdkInt = androidInfo.version.sdkInt;
    loggerNoStack.e('Android SD version : ' +   sdkInt.toString() + ' release : ' + release);

    if(int.parse(release) >= 14){

      Map<Permission, PermissionStatus> status = await [
        Permission.camera,
        Permission.location,
      ].request();

      if (status[Permission.camera]!.isDenied ||
          status[Permission.location]!.isDenied) {
        loggerNoStack.e(StringViewConstants.permissionDenied);
      } else {
        loggerNoStack.e(StringViewConstants.cameraGranted);

        uploadImage();
      }
    } else {

      Map<Permission, PermissionStatus> status = await [
        Permission.camera,
        Permission.storage,
        Permission.location,
      ].request();

      if (status[Permission.camera]!.isDenied ||
          status[Permission.storage]!.isDenied ||
          status[Permission.location]!.isDenied) {
        loggerNoStack.e(StringViewConstants.permissionDenied);
      } else {
        loggerNoStack.e(StringViewConstants.cameraGranted);

        uploadImage();
      }
    }
  }

  Future<void> uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        pickedFile0 = pickedFile;
        cropImage();
      });
    } else {
      loggerNoStack.e('pickedFile is null');
    }
  }

  Future<void> cropImage() async {
    if (pickedFile0 != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile0!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: StringViewConstants.cropper,
              toolbarColor: ColorViewConstants.colorBlueSecondaryText,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: StringViewConstants.cropper,
          )
        ],
      );
      if (croppedFile != null) {
        setState(() {
          croppedFile0 = croppedFile;
          recipientImageUpload();
        });
      }
    }
  }

  void recipientImageUpload() {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.recipientImageUpload(croppedFile0!,
        completion: (response) {
      loggerNoStack.e(response.toString());

      setState(() {
        showProgressCircle = false;
      });

      fileUploadName = response!.data!;
      //callUpdateTransferApi();
      callTransferOrderReceipt();
    });
  }

  void showTransactionCancelAlert() {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.confirm,
      text: StringViewConstants.cancelThisTransaction,
      confirmBtnText: StringViewConstants.yes,
      cancelBtnText: StringViewConstants.no,
      confirmBtnColor: ColorViewConstants.colorBlueSecondaryText,
      onConfirmBtnTap: () {
        _controller.finish();
        Navigator.pop(context);
        //callUpdateTransferApi('Cancel');
      },
    );
  }

  void showSuccessAlert(final String message) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      text: message,
      confirmBtnText: StringViewConstants.okay,
      confirmBtnColor: ColorViewConstants.colorBlueSecondaryText,
      onConfirmBtnTap: () {
        _controller.finish();
        Navigator.pop(context, true);

      },
    );
  }

  void callTransferOrderReceipt() {
    setState(() {
      showProgressCircle = true;
    });

    final TransfersOrderReceiptRequest request = TransfersOrderReceiptRequest(
      tableName: widget.coin!.subTransType!,
      bankerUserName: userName,
      id: widget.coin!.id.toString(),
      receiptImagePath: fileUploadName,
    );

    var splitImageName = fileUploadName.split('/');
    final String imagePath = splitImageName[splitImageName.length - 1].length > 0 ? splitImageName[splitImageName.length - 1] : 'xyz';

    ActivityViewModel.instance.callTransferOrderReceipt(request, widget.coin!.id.toString(), widget.coin!.subTransType!, userName, imagePath,
        completion: (response) {
      setState(() {
        showProgressCircle = false;
      });
    });
  }

  void callTransferOrderStatus() {
    loggerNoStack.e("callTransferOrderStatus");
    setState(() {
      showProgressCircle = true;
    });

    final TransfersOrderReceiptRequest request = TransfersOrderReceiptRequest(
      tableName: widget.coin!.subTransType!,
      id: widget.coin!.id.toString(),
      transferOrderStatus: 'Upload',
    );

    ActivityViewModel.instance.callTransferOrderStatus(request,
        completion: (response) {
      setState(() {
        showProgressCircle = false;
        showSuccessAlert(response!.message ?? '');
      });
    });
  }

  void callGetTransferTimer() {
    setState(() {
      showProgressCircle = true;
    });

    ActivityViewModel.instance.callGetTransferTimer(completion: (response) {
      setState(() {
        showProgressCircle = false;
        widget.timerBankList = response!.bankList!;
        widget.timerWalletMenuList = response!.timerWalletList!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    String? amount = widget.coin?.transAmount != null
        ? widget.coin?.transAmount!
        : widget.coin?.transferAmount!;

    String currencyType = widget.coin!.transCurrency! ?? '';
    String totalAmount = amount! + ' ' + currencyType;
    _controller.start();

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorViewConstants.colorWhite,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: ColorViewConstants.colorBlueSecondaryText,
        ),
        bottomNavigationBar: BottomAppBar(
          color: ColorViewConstants.colorWhite,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              MaterialButton(
                height: screenHeight * 0.06,
                color: ColorViewConstants.colorRed,
                minWidth: screenWidth * 0.45,
                onPressed: () {
                  showTransactionCancelAlert();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'Cancel',
                  style: AppTextStyles.semiBold.copyWith(
                      fontSize: 16, color: ColorViewConstants.colorWhite),
                  textAlign: TextAlign.center,
                ),
              ),
              MaterialButton(
                height: screenHeight * 0.06,
                color: ColorViewConstants.colorBlueSecondaryText,
                minWidth: screenWidth * 0.45,
                onPressed: () {
                  if(croppedFile0 != null){
                    callTransferOrderStatus();
                  } else {
                    ToastUtils.instance.showToast("Please upload transfer recipient!",
                        context: context, isError: false, bg: ColorViewConstants.colorYellow);
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'Transfer',
                  style: AppTextStyles.semiBold.copyWith(
                      fontSize: 16, color: ColorViewConstants.colorWhite),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            toolBarTransferBackWidget(
                context, StringViewConstants.transferConfirm, false,
                completion: (value) {
              showTransactionCancelAlert();
            }),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: screenWidth,
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 10),
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 15, bottom: 15),
                      decoration:
                          BoxDecoration(color: ColorViewConstants.colorWhite),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(widget.coin?.accountNumber ?? '',
                                  style: AppTextStyles.medium.copyWith(
                                    fontSize: 15,
                                    color: ColorViewConstants.colorPrimaryText,
                                  )),
                              Text(totalAmount,
                                  style: AppTextStyles.medium.copyWith(
                                    fontSize: 15,
                                    color: ColorViewConstants.colorPrimaryText,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * 0.007,
                          ),
                          Text(
                              StringUtils.capitalize(
                                  widget.coin?.receiverName ?? ''),
                              style: AppTextStyles.medium.copyWith(
                                fontSize: 14,
                                color: ColorViewConstants.colorPrimaryTextHint,
                              )),
                          SizedBox(
                            height: screenHeight * 0.007,
                          ),
                          Text(widget.coin?.bankName ?? '',
                              style: AppTextStyles.medium.copyWith(
                                fontSize: 14,
                                color: ColorViewConstants.colorPrimaryTextHint,
                              )),
                        ],
                      ),
                    ),
                    Visibility(
                        visible: isTimerRequired,
                        child: Align(
                          child: CustomTimer(
                              controller: _controller,
                              builder: (state, remaining) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 20, bottom: 20),
                                  child: Column(
                                    children: [
                                      Text(
                                          "${remaining.minutes}:${remaining.seconds}",
                                          style: AppTextStyles.medium.copyWith(
                                              fontSize: 30,
                                              color: ColorViewConstants
                                                  .colorPrimaryText)),
                                      SizedBox(
                                        height: screenHeight * 0.007,
                                      ),
                                      Text(
                                          "Please complete the transaction within 15 minutes",
                                          style: AppTextStyles.regular.copyWith(
                                              fontSize: 12,
                                              color: ColorViewConstants
                                                  .colorPrimaryTextHint)),
                                      SizedBox(
                                        height: screenHeight * 0.007,
                                      ),
                                      widgetUploadImage(context, croppedFile0,
                                          completion: (String name) {
                                        requestPermissions();
                                      }),
                                    ],
                                  ),
                                );
                              }),
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
