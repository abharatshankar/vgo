import 'dart:math' as math;

import 'package:basic_utils/basic_utils.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/model/request/username_request.dart';
import 'package:vgo_flutter_app/src/session/session_manager.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';
import 'package:vgo_flutter_app/src/view/common/widget_loader.dart';
import 'package:vgo_flutter_app/src/view/services/vgo_wallet_transfer/vgo_wallet_transfer_view.dart';
import 'package:vgo_flutter_app/src/view_model/services_view_model.dart';

import '../../../constants/string_view_constants.dart';
import '../../../model/bank_upi.dart';
import '../../../model/country.dart';
import '../../../model/transfers.dart';
import '../../../model/transgent_category.dart';
import '../../../utils/app_string_utils.dart';
import '../../common/common_tool_bar_back.dart';

class VgoWalletTransactionListView extends StatefulWidget {
  String transferType = 'Bank';

  @override
  State<StatefulWidget> createState() => VgoWalletTransactionListState();
}

class VgoWalletTransactionListState extends State<VgoWalletTransactionListView>
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

  void callRecentTransactions() {
    setState(() {
      showProgressCircle = true;
    });

    final UsernameRequest request = UsernameRequest(username: userName);

    ServicesViewModel.instance.callGetUserInboundTransferOrders(request,
        completion: (response) {
      setState(() {
        showProgressCircle = false;

        if (response!.success!) {
          List<Transfers> transferListDup = response.transferList!;
          transferList?.clear();
          for (Transfers transfer in transferListDup) {
            transfer.colorCode =
                ((math.Random().nextDouble() * 0xFFFFFF).toInt());
            /*if (userName == transfer.transferUserName) {
            transfersList.add(transfer);
          }*/
            transferList?.add(transfer);
          }
        } else {
          loggerNoStack.e(response.message!);
        }
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

    if (int.parse(release) >= 14) {
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
      callRecentTransactions();
    });

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
      child: Stack(
        children: [
          Scaffold(
              backgroundColor: ColorViewConstants.colorWhite,
              appBar: AppBar(
                toolbarHeight: 0,
                backgroundColor: ColorViewConstants.colorBlueSecondaryText,
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  toolBarTransferBackWidget(
                      context, StringViewConstants.transferToVgoWallet, false,
                      completion: (String title) {
                    Navigator.pop(context);
                  }),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.02,
                      left: screenHeight * 0.02,
                      right: screenHeight * 0.02,
                      bottom: screenHeight * 0.00,
                    ),
                    child: MaterialButton(
                      height: screenHeight * 0.06,
                      color: ColorViewConstants.colorGreen,
                      minWidth: screenWidth,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VgoWalletTransferView()),
                        ).then((val) => val ? callRecentTransactions() : null);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '+ New Transaction',
                        style: AppTextStyles.bold.copyWith(
                          fontSize: 16,
                          color: ColorViewConstants.colorWhite,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 17.0),
                    child: Text(
                      StringViewConstants.recentTransaction,
                      style: AppTextStyles.medium.copyWith(
                        fontSize: 18,
                        color: ColorViewConstants.colorBlack,
                      ),
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      // itemCount: transferList?.length ?? 0,
                      itemCount: transferList?.length,
                      itemBuilder: (context, position) {
                        Transfers? transfers = transferList?[position];

                        String name = '';
                        String number = '';
                        String fNameLName = '';

                        // loggerNoStack.e('recentTransactionList receiverUserName'  + transfers!.receiverUserName!);

                        name = transfers!.receiverName ?? '';
                        number = transfers.accountNumber ?? '';

                        //loggerNoStack.e('Split name $name');
                        if (name.isNotEmpty && name.contains(' ')) {
                          var arrayName = name.split(' ');
                          fNameLName = StringUtils.capitalize(
                              arrayName[0].substring(0, 1));
                          fNameLName = fNameLName +
                              (arrayName.length > 1
                                  ? StringUtils.capitalize(
                                      arrayName[1].substring(0, 1))
                                  : '');
                        } else {
                          fNameLName = name.isNotEmpty
                              ? StringUtils.capitalize(name.substring(0, 1))
                              : '';
                        }

                        return InkWell(
                          onTap: () {},
                          child: Container(
                            color: ColorViewConstants.colorWhite,
                            padding: EdgeInsets.only(
                                top: screenHeight * 0.02,
                                bottom: screenHeight * 0.01,
                                left: screenHeight * 0.02,
                                right: screenHeight * 0.02),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Color(transfers!.colorCode!)
                                        .withOpacity(1.0),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      fNameLName,
                                      style: AppTextStyles.semiBold.copyWith(
                                        fontSize: 16,
                                        color: ColorViewConstants.colorWhite,
                                      ),
                                    ),
                                  ),
                                ),
                                // SizedBox(width: screenWidth * 0.03),
                                Expanded(
                                    child: Container(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        StringUtils.capitalize(name),
                                        style: AppTextStyles.medium.copyWith(
                                            fontSize: 14,
                                            color: ColorViewConstants
                                                .colorPrimaryText),
                                      ),
                                      Visibility(
                                          visible:
                                              // (transferList?[position].receiverMobileNumber ?? '')
                                              (number).isNotEmpty,
                                          child: Wrap(
                                            children: [
                                              SizedBox(
                                                height: screenHeight * 0.001,
                                              ),
                                              Text(
                                                number,
                                                //  transferList?[position].receiverMobileNumber ?? '',
                                                style: AppTextStyles.regular
                                                    .copyWith(
                                                        fontSize: 14,
                                                        color: ColorViewConstants
                                                            .colorPrimaryText),
                                              ),
                                            ],
                                          )),
                                      SizedBox(
                                        height: screenHeight * 0.001,
                                      ),
                                      Text(
                                        '${transferList?[position].transCurrency! ?? ''} ${transferList?[position].transAmount! ?? ''} transferred successfully ',
                                        style: AppTextStyles.regular.copyWith(
                                          fontSize: 12,
                                          color: ColorViewConstants
                                              .colorPrimaryTextHint,
                                        ),
                                      ),
                                      Visibility(
                                        visible: false,
                                        child: Row(
                                          children: [
                                            Text(
                                              StringUtils.capitalize(
                                                  transferList?[position]
                                                          .receiverName ??
                                                      ''),
                                              style:
                                                  AppTextStyles.medium.copyWith(
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(width: screenWidth * 0.34),
                                            Text(
                                              AppStringUtils.subStringDate(
                                                      transferList?[position]
                                                          .createdAt
                                                          .toString()) ??
                                                  '',
                                              style: AppTextStyles.regular
                                                  .copyWith(
                                                fontSize: 10,
                                                color: ColorViewConstants
                                                    .colorGray,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                                SizedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        AppStringUtils.subStringDate(
                                                transferList?[position]
                                                    .createdAt
                                                    .toString()) ??
                                            '',
                                        style: AppTextStyles.medium.copyWith(
                                          fontSize: 12,
                                          color: ColorViewConstants
                                              .colorPrimaryTextHint,
                                        ),
                                      ),
                                      SizedBox(
                                        height: screenHeight * 0.01,
                                      ),
                                      SvgPicture.asset(
                                        'assets/images/services/right_arrow.svg',
                                        width: 23,
                                        height: 23,
                                        color: ColorViewConstants
                                            .colorPrimaryOpacityText50,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )),
                  SizedBox(
                    height: screenHeight * 0.01,
                  )
                ],
              )),
          widgetLoader(context, showProgressCircle),
        ],
      ),
    );
  }
}
