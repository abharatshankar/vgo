import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

class ToastUtils {
  static final ToastUtils instance = ToastUtils();

  showToast(String msg,
      {Color bg = Colors.red,
      double fontSize = 18,
      int duration = 1,
      BuildContext? context,
      bool isError = true}) async {
    await Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      title: 'VGo',
      titleSize: 18,
      titleColor: isError ? Colors.white : Colors.white,
      messageText: Text(
        msg,
        style:
            AppTextStyles.medium.copyWith(color: ColorViewConstants.colorWhite),
      ),
      messageColor: isError ? Colors.white : Colors.white,
      messageSize: 16,
      duration: const Duration(seconds: 3),
      backgroundColor: bg,
      icon: isError
          ? Icon(
              Icons.error,
              size: 30,
              color: ColorViewConstants.colorWhite,
            )
          : SvgPicture.asset(
        'assets/images/common/tick.svg',
              width: 24,
              height: 24,
              color: ColorViewConstants.colorWhite,
            ),
    ).show(context!);
  }
}
