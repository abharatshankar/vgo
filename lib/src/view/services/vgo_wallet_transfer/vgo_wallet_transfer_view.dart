import 'package:cool_alert/cool_alert.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/model/request/update_transfer_request.dart';
import 'package:vgo_flutter_app/src/session/session_manager.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';
import 'package:vgo_flutter_app/src/view/services/transfer/transfer_blue_button_widget.dart';
import 'package:vgo_flutter_app/src/view/services/vgo_wallet_transfer/amount_transfer_widget.dart';
import 'package:vgo_flutter_app/src/view/services/vgo_wallet_transfer/bank_account_number_widget.dart';
import 'package:vgo_flutter_app/src/view/services/vgo_wallet_transfer/currency_bank_type_widget.dart';
import 'package:vgo_flutter_app/src/view/services/vgo_wallet_transfer/select_transfer_mode_widget.dart';
import 'package:vgo_flutter_app/src/view/services/vgo_wallet_transfer/upload_image_widget.dart';
import 'package:vgo_flutter_app/src/view_model/services_view_model.dart';

import '../../../constants/string_view_constants.dart';
import '../../../model/bank_upi.dart';
import '../../../model/country.dart';
import '../../../model/transfers.dart';
import '../../../model/transgent_category.dart';
import '../../../utils/app_string_utils.dart';
import '../../../utils/toast_utils.dart';
import '../../activity/transagent/transaction_success_view.dart';
import '../../common/common_tool_bar_back.dart';

class VgoWalletTransferView extends StatefulWidget {
  String transferType = 'Bank';

  @override
  State<StatefulWidget> createState() => VgoWalletTransferViewState();
}

class VgoWalletTransferViewState extends State<VgoWalletTransferView>
    with SingleTickerProviderStateMixin {
  late CustomTimerController _controller = CustomTimerController(
      vsync: this,
      begin: Duration(seconds: 1),
      end: Duration(seconds: 900),
      initialState: CustomTimerState.reset,
      interval: CustomTimerInterval.milliseconds);

  bool showProgressCircle = false;
  bool isTimerRequired = false;
  bool isTransferEnabled = false;
  bool isUploadDisable = false;
  List<BankUPI>? bankList;
  List<BankUPI>? upiList;
  List<Country>? currencyList;
  BankUPI? bankDetails;
  BankUPI? upiDetails;

  String selectedCurrency = 'INR';
  String selectedBank = 'ICICI BANK';
  String selectedUPI = 'PhonePe';
  String amount = '';
  String accountNumber = '';
  String holderName = '';
  String userName = '';
  String fileUploadName = '';

  final amountController = TextEditingController();
  final numberController = TextEditingController();
  final holderController = TextEditingController();
  String lockText = 'Lock';

  XFile? pickedFile0;
  CroppedFile? croppedFile0;

  Transfers? transfers;
  String selectedType = '';
  List<Transfers>? transferList = [];
  List<TransferCategory> transferCategoryList = [];
  List<Transfers>? bankTransfersList;
  List<Transfers>? upiTransfersList;
  TransferCategory selectedTransferCategory = TransferCategory(
      categoryCode: 'BANK',
      categoryName: 'Bank',
      categoryIconPath: 'https://vgopay.in/icons/bank.png');

  void callAllBanksApi(String category, String currencyType) {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callGetBanksList(category, currencyType,
        completion: (response) {
      setState(() {
        showProgressCircle = false;
      });

      if (response!.success ?? true) {
        setState(() {
          bankList = response.bankUpiList;
        });
      } else {
        loggerNoStack.e(StringViewConstants.noBank);
      }
    });
  }

  void callAllUPIsApi(String currencyType,) {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callGetUpiList(
        currencyType, completion: (response) {
      setState(() {
        showProgressCircle = false;
      });

      if (response!.success ?? true) {
        setState(() {
          upiList = response.bankUpiList;
        });
      } else {
        loggerNoStack.e(StringViewConstants.noBank);
      }
    });
  }

  void callCurrenciesApi() {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callGetCurrenciesList(completion: (response) {
      setState(() {
        showProgressCircle = false;
      });

      setState(() {
        currencyList = response?.currencyList;
      });
    });
  }

  void callGetSelectedUpiAccountDetails(String currencyType, String bank,
      String amount,) {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callGetSelectedUpiAccountDetails(
        currencyType, bank, amount, completion: (response) {
      setState(() {
        showProgressCircle = false;
        if (response!.success!) {
          upiDetails = response.bankUpi!;
          callTransferToWalletLock('Process');
        } else {
          ToastUtils.instance
              .showToast(response.message!, context: context, isError: true);
        }
      });
    });
  }

  void callGetSelectedBankAccountDetails(String currencyType, String bank,
      String amount,) {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callGetSelectedBankAccountDetails(
        currencyType, bank, amount, completion: (response) {
      setState(() {
        showProgressCircle = false;

        if (response!.success!) {
          bankDetails = response.bankUpi!;
          callTransferToWalletLock('Process');
        } else {
          ToastUtils.instance
              .showToast(response.message!, context: context, isError: true);
        }
      });
    });
  }

  void callTransferToWalletLock(final String status) {
    setState(() {
      showProgressCircle = true;
    });

    SessionManager.getUserName().then((value) {
      userName = value!;
      loggerNoStack.e('userName 2 $userName');

      final UpdateTransferRequest request = UpdateTransferRequest(
          userName: userName,
          transferAmount: amountController.text,
          accountNumber: widget.transferType == 'UPI'
              ? upiDetails!.accountNumber
              : bankDetails!.accountNumber,
          transferAccountType: widget.transferType == 'UPI' ? 'UPI' : 'Bank',
          bankName: widget.transferType == 'UPI' ? selectedUPI : selectedBank,
          bankerUserName: widget.transferType == 'UPI'
              ? upiDetails?.userName!
              : bankDetails?.userName,
          receiptImagePath: '',
          status: status,
          transferCurrency: selectedCurrency);

      ServicesViewModel.instance.callCreateTransferWallet(request,
          completion: (response) {
            setState(() {
              showProgressCircle = false;

          if (response!.success!) {
            SessionManager.setTransactionId(response.data);
            _controller.start();
            isTimerRequired = true;
            isUploadDisable = true;
            lockText = 'Cancel';
          } else {
            ToastUtils.instance
                .showToast(response.message!, context: context, isError: true);
          }
        });
      });
    });
  }

  void callUpdateTransferApi(String status) {
    setState(() {
      showProgressCircle = true;
    });

    var splitImageName = fileUploadName.split('/');
    final String imagePath = splitImageName[splitImageName.length - 1].length > 0 ? splitImageName[splitImageName.length - 1] : 'xyz';

    final UpdateTransferRequest request = UpdateTransferRequest(
        userName: userName,
        transferAmount: amountController.text,
        accountNumber: widget.transferType == 'UPI'
            ? upiDetails?.accountNumber!
            : bankDetails?.accountNumber,
        transferAccountType: widget.transferType == 'UPI' ? 'UPI' : 'Bank',
        bankName: widget.transferType == 'UPI' ? selectedUPI : selectedBank,
        bankerUserName: widget.transferType == 'UPI'
            ? upiDetails?.userName!
            : bankDetails?.userName,
        receiptImagePath: fileUploadName,
        status: status,
        transferCurrency: selectedCurrency);


    SessionManager.getTransactionId().then((value) {
      ServicesViewModel.instance.callUpdateTransfer(
          value.toString(), imagePath, status, request, completion: (response) {
        setState(() {
          showProgressCircle = false;
          _controller.finish();

          if (response!.success!) {
            isUploadDisable = false;
          } else {
            isUploadDisable = true;
          }

          if (status == 'Upload') {
            showSuccessAlert(
                response.message!,
                CoolAlertType.success,
                ColorViewConstants.colorBlueSecondaryText,
                response.transfers!,
                true);
          } else {
            showSuccessAlert(
                response.message!,
                CoolAlertType.error,
                ColorViewConstants.colorRed,
                response.transfers!,
                false);
          }
        });
      });
    });
  }

  Future<bool> checkPermissionStatus() async {
    final permission = Permission.camera;
    return await permission.status.isGranted;
  }

  Future<bool> shouldShowRequestRationale() async {
    final permission = Permission.camera;
    return await permission.shouldShowRequestRationale;
  }

  Future<void> requestPermissions() async {
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    var release = androidInfo.version.release;
    var sdkInt = androidInfo.version.sdkInt;
    loggerNoStack.e(
        'Android SD version : ' + sdkInt.toString() + ' release : ' + release);
/*
    ToastUtils.instance
        .showToast(release, context: context, isError: true);*/

    if (int.parse(release) >= 13) {
      /*ToastUtils.instance
          .showToast('inside 14 or greater', context: context, isError: true);*/

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
      /* ToastUtils.instance
          .showToast('outside 14 or greater', context: context, isError: true);*/

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
        fileUploadName = response!.data!;
        isTransferEnabled = true;
      });

      //callUpdateTransferApi();
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
          callUpdateTransferApi('Cancel');
        },
        onCancelBtnTap: () {
          setState(() {
            lockText = 'Cancel';
          });
        });
  }

  void showSuccessAlert(final String message, CoolAlertType alertType,
      Color confirmBtnColor, Transfers transfer, bool isCancelled) {

    loggerNoStack.e('isCancelled : ' + isCancelled.toString());

    CoolAlert.show(
      context: context,
      type: alertType,
      text: message,
      confirmBtnText: StringViewConstants.okay,
      confirmBtnColor: confirmBtnColor,
      onConfirmBtnTap: () {
        _controller.finish();
        if(isCancelled){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TransactionSuccessView(
                isMobileTransfer: false,
                isAdminTransfer: true,
                transfers: transfer,
                status: 'Match',
                navigationFrom: 'VGO WALLET',
              ),
            ),
          ).then((val) => val ? '' : null);
        } else {
          Navigator.pop(context, true);
        }
      },
    );
  }

  void callSettingsConfigApi() {
    ServicesViewModel.instance.callSettingsConfig(completion: (response) {
      setState(() {
        transferCategoryList = response!.transferCategoriesList!;
        selectedTransferCategory = transferCategoryList[0];
        loggerNoStack.e(
            'selectedTransferCategory ' + selectedTransferCategory.toString());
      });
    });
  }

  @override
  void initState() {
    super.initState();

    SessionManager.getUserName().then((value) {
      userName = value!;
      loggerNoStack.e('userName $userName');
    });

    callAllBanksApi('Bank', 'INR');
    callAllUPIsApi('INR');
    callCurrenciesApi();
    callSettingsConfigApi();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        loggerNoStack.e('didPop' + didPop.toString());
      },
      child: Scaffold(
        backgroundColor: ColorViewConstants.colorWhite,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: ColorViewConstants.colorBlueSecondaryText,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                toolBarTransferBackWidget(
                    context, StringViewConstants.transferToVgoWallet, false,
                    completion: (String title) {
                  if (isTimerRequired) {
                    showTransactionCancelAlert();
                  } else {
                    loggerNoStack.e('Timer not started');
                    Navigator.pop(context);
                  }
                }),
                Visibility(
                    visible: false,
                    child: widgetSelectTransferMode(
                        context,
                        StringViewConstants.selectTransferMode,
                        widget.transferType == 'UPI',
                        completion: (isUpiSelected) {
                      setState(() {
                        //isUpi = isUpiSelected;
                      });
                    })),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.02,
                    left: screenHeight * 0.02,
                    right: screenHeight * 0.02,
                    bottom: screenHeight * 0.02,
                  ),
                  decoration: BoxDecoration(
                    color: ColorViewConstants.colorWhite,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                              text: StringViewConstants.selectTransferMode,
                              style: AppTextStyles.medium.copyWith(
                                  color: ColorViewConstants.colorPrimaryText,
                                  fontSize: 16),
                            ),
                            TextSpan(
                                text: ' *',
                                style: AppTextStyles.medium.copyWith(
                                    color: ColorViewConstants.colorRed,
                                    fontSize: 16)),
                          ])),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                          itemHeight: 50,
                          iconEnabledColor:
                              ColorViewConstants.colorBlueSecondaryText,
                          iconDisabledColor:
                              ColorViewConstants.colorBlueSecondaryText,
                          value: selectedTransferCategory.categoryName,
                          isExpanded: true,
                          items: transferCategoryList
                              .map((TransferCategory category) {
                            return DropdownMenuItem(
                              value: category.categoryName,
                              child: Container(
                                color: ColorViewConstants.colorWhite,
                                padding: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Image.network(
                                      category.categoryIconPath ??
                                          AppStringUtils.noImageUrl,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.03,
                                    ),
                                    Text(
                                      category.categoryName ?? '',
                                      style: AppTextStyles.medium.copyWith(
                                          fontSize: 14,
                                          color: ColorViewConstants
                                              .colorPrimaryText),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              loggerNoStack.e(
                                  'selectedTransferCategory value ' + value!);

                              for (TransferCategory category
                                  in transferCategoryList) {
                                loggerNoStack.e(
                                    'categoryName ' + category.categoryName!);
                                if (category.categoryName == value) {
                                  selectedTransferCategory = category;
                                  selectedType = category.categoryName!;
                                  widget.transferType = category.categoryName!;
                                  callAllBanksApi(selectedType, selectedCurrency);
                                }
                              }

                              loggerNoStack.e(
                                  'selectedTransferCategory.categoryName ' +
                                      selectedTransferCategory.categoryName!);
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                widgetCurrencyBankType(
                    context,
                    widget.transferType == 'UPI',
                    AppStringUtils.defaultCurrency,
                    widget.transferType == 'UPI' ? selectedUPI : selectedBank,
                    currencyList,
                    widget.transferType == 'UPI' ? upiList : bankList,
                    widget.transferType == 'UPI', completion: (currency) {
                  setState(() {
                    loggerNoStack
                        .e(StringViewConstants.currency + currency.toString());
                    selectedCurrency = currency;
                  });
                }, completion2: (bankUpi) {
                  setState(() {
                    loggerNoStack.e('bankUpi ' + bankUpi);
                    widget.transferType == 'UPI'
                        ? selectedUPI = bankUpi
                        : selectedBank = bankUpi;
                  });
                }),
                widgetAmountTransfer(context, lockText, amountController, lockText != 'Lock',
                    completion: (value, title) {
                  setState(() {

                    FocusManager.instance.primaryFocus?.unfocus();

                    amount = value;
                    if (lockText == 'Lock') {
                      if (widget.transferType == 'UPI') {
                        callGetSelectedUpiAccountDetails(
                            'INR', selectedUPI, amount);
                      } else {
                        callGetSelectedBankAccountDetails(
                            'INR', selectedBank, amount);
                      }
                    } else {
                      lockText = title;
                      showTransactionCancelAlert();
                    }
                  });
                }),
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
                                  Text(
                                      StringViewConstants.completeTheTransaction ,
                                      style: AppTextStyles.medium.copyWith(
                                          fontSize: 12,
                                          color: ColorViewConstants
                                              .colorPrimaryTextHint)),
                                ],
                              ),
                            );
                          }),
                    )),

                widgetBankAccountNumber(
                    context,
                    true,
                    StringViewConstants.bankAccountNumber,
                    StringViewConstants.accountNumber,
                    numberController,
                    holderController,
                    widget.transferType == 'UPI' ? upiDetails : bankDetails,
                    completion: (value) {
                  accountNumber = value;
                }, isAddUPIBank: true),
                widgetBankAccountNumber(
                    context,
                    false,
                    StringViewConstants.accountHolderName,
                    StringViewConstants.accountHolderName,
                    numberController,
                    holderController,
                    widget.transferType == 'UPI' ? upiDetails : bankDetails,
                    completion: (value) {
                  holderName = value;
                }, isAddUPIBank: true),
                Visibility(
                  visible: isUploadDisable,
                  child: widgetUploadImage(context, croppedFile0,
                      completion: (String name) {
                    requestPermissions();
                  }),
                ),
                Visibility(
                  visible: isUploadDisable,
                  child: Container(
                    width: screenWidth,
                    child: Text(
                      textAlign: TextAlign.center,
                      StringViewConstants.UploadPaymentTransfer,
                      style: AppTextStyles.regular.copyWith(
                        fontSize: 14,
                        color: ColorViewConstants.colorGray,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Visibility(
                    visible: isTransferEnabled,
                    child: Align(
                      child: SizedBox(
                        width: screenWidth * 0.9,
                        child: widgetTransferBlueButton(
                            context,
                            StringViewConstants.transfer,
                            ColorViewConstants.colorBlueSecondaryText,
                            amountController.text,
                            StringViewConstants.pleaseEnterAmount, completion: (amount) {
                          if (numberController.text.isEmpty) {
                            ToastUtils.instance.showToast(
                                StringViewConstants.enterAccountNumber,
                                context: context,
                                isError: false,
                                bg: ColorViewConstants.colorYellow);
                          } else if (holderController.text.isEmpty) {
                            ToastUtils.instance.showToast(
                                StringViewConstants.pleaseAccountHolderName,
                                context: context,
                                isError: false,
                                bg: ColorViewConstants.colorYellow);
                          } else {
                            callUpdateTransferApi(StringViewConstants.upload);
                          }
                        }),
                      ),
                    )),
                SizedBox(
                  height: screenHeight * 0.01,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
