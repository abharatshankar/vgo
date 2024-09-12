import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

import '../../../../model/Kyc.dart';

Widget widgetEducationList(BuildContext context, Kyc kyc) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    margin: const EdgeInsets.only(top: 0, left: 5, right: 5, bottom: 10),
    padding: EdgeInsets.only(
        top: screenHeight * 0.02,
        left: screenHeight * 0.02,
        right: screenHeight * 0.00,
        bottom: screenHeight * 0.02),
    decoration: BoxDecoration(
      color: ColorViewConstants.colorWhite,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: screenWidth * 0.90,
          //height: screenHeight * 0.09,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    kyc.collegeUniversity ?? '',
                    style: AppTextStyles.medium.copyWith(
                      color: ColorViewConstants.colorPrimaryText,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.25),
                  Text(
                    '',
                    style: AppTextStyles.regular.copyWith(
                      fontSize: 13,
                      color: ColorViewConstants.colorGray,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.009,
              ),
              Row(
                children: [
                  Text(
                    'Duration : ' + kyc.duration!,
                    style: AppTextStyles.regular.copyWith(
                      color: ColorViewConstants.colorPrimaryText,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.40),
                  Text(
                    'Dept : ' + kyc.course!,
                    style: AppTextStyles.regular.copyWith(
                      color: ColorViewConstants.colorPrimaryText,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.009,
              ),
              Row(
                children: [Text(
                  'Year Of Passed : ',
                  style: AppTextStyles.regular.copyWith(
                    fontSize: 13,
                  ),
                ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    kyc.yearOfPass.toString(),
                    style: AppTextStyles.regular.copyWith(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.009,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/kyc/ic_location.svg',
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(width: screenWidth * 0.01),
                  Text(
                    kyc.currentLocation ?? '',
                    style: AppTextStyles.regular.copyWith(
                      color: ColorViewConstants.colorPrimaryText,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
