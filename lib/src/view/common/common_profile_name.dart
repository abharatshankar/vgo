import 'dart:math' as math;

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';

import '../../model/user.dart';

Widget profileName(BuildContext context, User? user,
    {bool isBack = false,
    Color bg = Colors.white,
    Color userBg = Colors.white,
    Color textColor = Colors.white,
    Color nameColor = Colors.black54,
    Color numberColor = Colors.white}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  final String fName =
      user?.firstName != null ? StringUtils.capitalize(user!.firstName!) : '';
  final String lName =
      user?.lastName != null ? StringUtils.capitalize(user!.lastName!) : '';
  final String number = user?.mobileNumber != null ? user!.mobileNumber! : '';

/*  loggerNoStack.e('fName $fName');
  loggerNoStack.e('lName $lName');*/

  String fNameLName = '';

  if (fName.contains(' ')) {
    var name = fName.split(' ');
    final String fNameLetter =
        name[0].isNotEmpty ? name[0].substring(0, 1) : '';
    final String lNameLetter =
        name[1].isNotEmpty ? name[1].substring(0, 1) : '';
    fNameLName = StringUtils.capitalize(fNameLetter) +  StringUtils.capitalize(lNameLetter);
  } else {
    final String fNameLetter =
        user != null && fName.isNotEmpty ? fName.substring(0, 1) : '';
    final String lNameLetter =
        user != null && lName.isNotEmpty ? lName.substring(0, 1) : '';
    fNameLName = StringUtils.capitalize(fNameLetter) +  StringUtils.capitalize(lNameLetter);
  }

  return Container(
    padding: EdgeInsets.only(
        top: screenHeight * 0.02,
        left: screenHeight * 0.0,
        right: screenHeight * 0.02,
        bottom: screenHeight * 0.02),
    decoration: BoxDecoration(
      color: bg,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Visibility(
          visible: isBack,
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 15),
                child: SvgPicture.asset(
                  'assets/images/services/left_arrow.svg',
                  width: 20,
                  height: 20,
                  color: ColorViewConstants.colorWhite,
                ),
              )),
        ),
        SizedBox(
          width: screenWidth * 0.15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color:
                    Color(user?.colorCode ??
                            (math.Random().nextDouble() * 0xFFFFFF).toInt())
                        .withOpacity(1.0),
                    borderRadius: BorderRadius.circular(25)),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      textAlign: TextAlign.center,
                      fNameLName,
                      style: AppTextStyles.semiBold.copyWith(
                        fontSize: 14,
                        color: textColor,
                      ),
                    )),
              )
            ],
          ),
        ),
        SizedBox(width: screenWidth * 0.01),
        SizedBox(
          width: screenWidth * 0.45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                fName + ' ' + lName,
                style: AppTextStyles.semiBold.copyWith(
                  fontSize: 14,
                  color: nameColor,
                ),
              ),
              Text(
                number,
                style: AppTextStyles.regular.copyWith(fontSize: 13,
                  color: numberColor,),
              ),
            ],
          ),
        ),

      ],
    ),
  );
}
