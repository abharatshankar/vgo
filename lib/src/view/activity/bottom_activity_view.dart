import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/view/activity/activity_banner_widget.dart';
import 'package:vgo_flutter_app/src/view/common/common_tool_bar.dart';

import '../../utils/toast_utils.dart';

class BottomActivityView extends StatefulWidget {
  const BottomActivityView({super.key});

  @override
  State<BottomActivityView> createState() => BottomActivityState();
}

class BottomActivityState extends State<BottomActivityView> {
  int closeAppClick = 0;

  Future<bool> _onWillPop() async {
    closeAppClick++;
    if (closeAppClick == 2) {
      exit(0);
    } else {
      ToastUtils.instance.showToast("Please press back again to close the app.",
          context: context, isError: false, bg: ColorViewConstants.colorYellow);
    }

    Future.delayed(const Duration(seconds: 5), () {
      closeAppClick = 0;
    });

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorViewConstants.colorBlueSecondaryText,
            toolbarHeight: 0,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              toolBarWidget(context, StringViewConstants.activity,
                  completion: (value) {}),
              widgetCarousel(context)
            ],
          ),
        ));
  }
}
