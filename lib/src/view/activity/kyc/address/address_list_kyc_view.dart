import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/model/response/address_list_response.dart';
import 'package:vgo_flutter_app/src/view/common/widget_loader.dart';

import '../../../../session/session_manager.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/utils.dart';
import '../../../../view_model/kyc_view_model.dart';
import 'add_address_kyc_view.dart';

class AddressListKycView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddressListViewState();
}

class AddressListViewState extends State<AddressListKycView> {
  bool showProgressCircle = false;

  String gapId = '';
  List<Address>? addressList = [];

  void callGetAddressList() {
    setState(() {
      showProgressCircle = true;
    });

    KycViewModel.instance.callGetAddressApi(gapId, completion: (response) {
      setState(() {
        showProgressCircle = false;

        if (response!.success ?? true) {
          addressList = response.addressList;
        } else {
          loggerNoStack.e('message : ' + response.message!);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    SessionManager.getGapID().then((value) {
      gapId = value!;
      loggerNoStack.e('gapId :${gapId}');
      callGetAddressList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: ColorViewConstants.colorHintBlue,
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: ColorViewConstants.colorBlueSecondaryText,
          ),
          body: Container(
            // padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: addressList?.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, position) {
                        var addressBuffer = StringBuffer();
                        final Address address = addressList![position];
                        if (address.address_type != null) {
                          addressBuffer.write(address.address_type ?? '');
                          addressBuffer.write(', ');
                        }
                        addressBuffer.write(address.house_no ?? '');
                        addressBuffer.write(', ');
                        addressBuffer.write(address.address1 ?? '');
                        addressBuffer.write(', ');
                        addressBuffer.write(address.address2 ?? '');
                        addressBuffer.write(', ');
                        addressBuffer.write(address.city ?? '');
                        addressBuffer.write(', ');
                        addressBuffer.write(address.state ?? '');
                        addressBuffer.write(', ');
                        addressBuffer.write(address.country ?? '');
                        addressBuffer.write(', ');
                        addressBuffer.write(address.postal_code ?? '');

                        return InkWell(
                          onTap: () {
                            //completion(false, address);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 5, left: 10, right: 10, bottom: 10),
                            padding: EdgeInsets.only(
                                top: screenHeight * 0.02,
                                left: screenHeight * 0.00,
                                right: screenHeight * 0.00,
                                bottom: screenHeight * 0.02),
                            decoration: BoxDecoration(
                                color: ColorViewConstants.colorWhite,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.10,
                                  //height: screenHeight * 0.09,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/images/kyc/location.png',
                                        width: 25,
                                        height: 25,
                                        color: ColorViewConstants
                                            .colorBlueSecondaryText,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.70,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        addressBuffer.toString(),
                                        style: AppTextStyles.regular
                                            .copyWith(fontSize: 13, color: ColorViewConstants.colorPrimaryText),
                                      ),
                                      /*SizedBox(
                height: screenHeight * 0.01,
              ),*/
                                      Text(
                                        'Landmark: ' + address.land_mark!,
                                        style: AppTextStyles.regular
                                            .copyWith(fontSize: 13, color: ColorViewConstants.colorPrimaryText),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    // completion(true, address);
                                  },
                                  child: SizedBox(
                                    width: screenWidth * 0.10,
                                    height: screenHeight * 0.06,
                                    // Adjust this height as needed
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Image.asset(
                                        'assets/images/kyc/delete.png',
                                        width: 20,
                                        height: 20,
                                        color: ColorViewConstants.colorRed,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                Container(
                  color: ColorViewConstants.colorWhite,
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.00,
                    left: screenHeight * 0.02,
                    right: screenHeight * 0.02,
                    bottom: screenHeight * 0.02,
                  ),
                  child: MaterialButton(
                    height: screenHeight * 0.06,
                    color: ColorViewConstants.colorBlueSecondaryDarkText,
                    minWidth: screenWidth,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AddAddressKycView())).then((val) =>
                          val ? callGetAddressList() : callGetAddressList());
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Add Address',
                      style: AppTextStyles.medium.copyWith(
                        fontSize: 15,
                        color: ColorViewConstants.colorWhite,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        widgetLoader(context, showProgressCircle)
      ],
    );
  }
}
