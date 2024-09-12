import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

import '../../model/user.dart';

Widget widgetUserInfo(BuildContext context, User? user) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
    color: ColorViewConstants.colorLightWhite,
    child: Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          "assets/images/profile/user_avatar.svg",
          width: 50,
          height: 50,
          color: ColorViewConstants.colorBlueSecondaryText,
        ),
        Padding(
            padding: EdgeInsets.only(left: 15, right: 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${StringUtils.capitalize(user?.firstName ?? '')} ${StringUtils.capitalize(user?.lastName ?? '')}',
                  style: AppTextStyles.semiBold.copyWith(
                      fontSize: 14, color: ColorViewConstants.colorPrimaryText),
                ),
                SizedBox(
                  height: screenHeight * 0.002,
                ),
                Text(
                  '+91 ${user?.mobileNumber ?? ''}',
                  style: AppTextStyles.regular.copyWith(
                      fontSize: 14, color: ColorViewConstants.colorPrimaryText),
                ),
                SizedBox(
                  height: screenHeight * 0.002,
                ),
                Text(
                  user?.emailId ?? '',
                  style: AppTextStyles.regular.copyWith(
                    color: ColorViewConstants.colorPrimaryTextHint,
                    fontSize: 13,
                  ),
                )
              ],
            )),
        Spacer(),
        Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
          decoration: BoxDecoration(
              color: ColorViewConstants.colorBlueSecondaryText,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/profile/edit_icon.svg",
                width: 18,
                height: 18,
                color: ColorViewConstants.colorWhite,
              ),
              SizedBox(
                width: screenWidth * 0.01,
              ),
              Text(
                StringViewConstants.edit,
                style: AppTextStyles.medium.copyWith(
                    fontSize: 13, color: ColorViewConstants.colorWhite),
              )
            ],
          ),
        )
      ],
    ),
  );
}
