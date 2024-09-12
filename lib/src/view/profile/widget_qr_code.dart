import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';

import '../../utils/app_text_style.dart';

Widget widgetUserQRCode(BuildContext context, String mobileNumber) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    width: screenWidth,
    padding: const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 10),
    color: ColorViewConstants.colorWhite,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          StringViewConstants.myQRCode,
          style: AppTextStyles.bold.copyWith(
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Center(
          child: QrImageView(
            data: mobileNumber,
            version: QrVersions.auto,
            size: screenHeight * 0.2,
          ),
        )
      ],
    ),
  );
}
