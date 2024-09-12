import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';

import '../../utils/app_text_style.dart';

Widget widgetNoDataFound(BuildContext context,
    {bool isSvg = false,
    String image = 'assets/images/logo/vgo_logo.png',
    String message = 'No data found'}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Align(
      child: Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Visibility(
          visible: !isSvg,
          child: Image.asset(
            image,
            width: 70,
            height: 70,
          ),
        ),
        Visibility(
          visible: isSvg,
          child: SvgPicture.asset(
            image,
            width: 70,
            height: 70,
          ),
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: AppTextStyles.medium.copyWith(
              fontSize: 14, color: ColorViewConstants.colorPrimaryTextHint),
        ),
      ],
    ),
  ));
}
