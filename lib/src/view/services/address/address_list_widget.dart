import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

import '../../../model/response/address_list_response.dart';

Widget widgetAddressList(BuildContext context, List<Address> list,
    {required Function(bool isDelete, Address selectedAddress) completion}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, position) {
        var addressBuffer = StringBuffer();
        final Address address = list[position];
        addressBuffer.write(address.address_type ?? '');
        addressBuffer.write(', ');
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
            completion(false, address);
          },
          child: Container(
            margin:
                const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
            padding: EdgeInsets.only(
                top: screenHeight * 0.02,
                left: screenHeight * 0.00,
                right: screenHeight * 0.00,
                bottom: screenHeight * 0.02),
            decoration: BoxDecoration(
                color: ColorViewConstants.colorWhite,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: screenWidth * 0.10,
                  //height: screenHeight * 0.09,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/kyc/location.png',
                        width: 30,
                        height: 30,
                        color: ColorViewConstants.colorBlueSecondaryText,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        addressBuffer.toString(),
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 17,
                        ),
                      ),
                      /*SizedBox(
                height: screenHeight * 0.01,
              ),*/
                      Text(
                        'Landmark: ' + address.land_mark!,
                        style: AppTextStyles.medium.copyWith(fontSize: 17),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    completion(true, address);
                  },
                  child: SizedBox(
                    width: screenWidth * 0.10,
                    height: screenHeight * 0.06, // Adjust this height as needed
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        'assets/images/kyc/delete.png',
                        width: 25,
                        height: 25,
                        color: ColorViewConstants.colorRed,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
