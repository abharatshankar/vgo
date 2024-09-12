import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

import '../../constants/string_view_constants.dart';
import '../activity/transagent/upi/add_bank_upi.dart';

Widget toolBarTransferWidget(BuildContext context, String title, bool image, {bool isBack = true}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    color: ColorViewConstants.colorBlueSecondaryText,
    padding: EdgeInsets.only(
        top: screenHeight * 0.02,
        left: screenHeight * 0.02,
        right: screenHeight * 0.03,
        bottom: screenHeight * 0.02),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible: isBack,
            child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            'assets/images/services/left_arrow.svg',
            width: 20,
            height: 20,
            color: ColorViewConstants.colorWhite,
          ),
        ))
        ,
        //  SizedBox(width: screenWidth * 0.01,),
        Text(
          title,
          style: AppTextStyles.medium
              .copyWith(fontSize: 16, color: ColorViewConstants.colorWhite),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddBankUpiView(title: '',)),
            );
          },
          child: Visibility(
              visible: image,
              child: Wrap(
                direction: Axis.horizontal,
                children: [
                  Text(
                    StringViewConstants.add,
                    style: AppTextStyles.medium.copyWith(
                        fontSize: 18, color: ColorViewConstants.colorWhite),
                  ),
                  SizedBox(
                    width: screenWidth * 0.01,
                  ),
                  SvgPicture.asset(
                    'assets/images/home/right_icon.svg',
                    width: 25,
                    height: 25,
                    color: ColorViewConstants.colorWhite,
                  ),
                ],
              )),
        ),
      ],
    ),
  );
}
