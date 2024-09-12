import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/view/services/add_new_recipient/add_new_recipient_view.dart';

Widget widgetAddRecipientButton(BuildContext context, String title) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    padding: EdgeInsets.only(
      top: screenHeight * 0.02,
      left: screenHeight * 0.02,
      right: screenHeight * 0.02,
      bottom: screenHeight * 0.00,
    ),

    child: MaterialButton(
        height: screenHeight * 0.06,
        color: ColorViewConstants.colorGreen,
        minWidth: screenWidth,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewRecipientView()),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: AppTextStyles.bold.copyWith(
            fontSize: 16,
            color: ColorViewConstants.colorWhite,
          ),
          textAlign: TextAlign.center,
        ),
      ),
  );
}
