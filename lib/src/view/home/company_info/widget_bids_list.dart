import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

Widget widgetBidsList(
  BuildContext context,
) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: 11,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, position) {
      return Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: screenWidth * 0.30,
              child: Text(
                '160.40',
                style: AppTextStyles.medium.copyWith(
                    fontSize: 13, color: ColorViewConstants.colorBlack),
              ),
            ),
            SizedBox(
              width: screenWidth * 0.30,
              child: Text(
                '10',
                style: AppTextStyles.regular.copyWith(
                  fontSize: 13,
                  color: ColorViewConstants.colorBlack,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
