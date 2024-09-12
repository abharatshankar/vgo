import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';

Widget widgetLoader(BuildContext context, bool showProgressCircle) {

  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Visibility(
    visible: showProgressCircle,
    child: Container(
        color: Colors.transparent,
        width: screenWidth,
        height: screenHeight * 0.8,
        child: Center(
          child: LoadingAnimationWidget.discreteCircle(
              color: ColorViewConstants.colorBlueSecondaryText, size: 40),
        )),
  );
}