import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';

import '../../constants/string_view_constants.dart';
import '../../utils/app_text_style.dart';

void showAlertDialog(BuildContext context, String title, String message, {required}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: AppTextStyles.medium.copyWith(fontSize: 20),
          ),
          content: Text(
            message,
            style: AppTextStyles.medium.copyWith(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                 /* backgroundColor: WidgetStateProperty.all(
                      ColorViewConstants.colorHintGray),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                  ))*/),
              child: Text(
                'No',
                style: AppTextStyles.medium.copyWith(
                  fontSize: 16,
                  color: ColorViewConstants.colorWhite,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: ButtonStyle(
                 /* backgroundColor: WidgetStateProperty.all(
                      ColorViewConstants.colorBlueSecondaryText),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)
              ))*/),
              child: Text(
                StringViewConstants.yes,
                style: AppTextStyles.medium.copyWith(
                  fontSize: 16,
                  color: ColorViewConstants.colorWhite,
                ),
              ),
              onPressed: () {},
            )
          ],
        );
      });
}
