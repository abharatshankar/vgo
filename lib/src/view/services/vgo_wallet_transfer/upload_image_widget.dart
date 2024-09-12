import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';

Widget widgetUploadImage(BuildContext context, CroppedFile? croppedFile0,
    {required Function(String name) completion}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return InkWell(
      onTap: () {
        String name = '';
        completion(name);
      },
      child: Container(
        padding: EdgeInsets.only(
          top: screenHeight * 0.02,
          left: screenHeight * 0.10,
          right: screenHeight * 0.10,
          bottom: screenHeight * 0.02,
        ),
        decoration: BoxDecoration(
          color: ColorViewConstants.colorWhite,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: screenWidth * 0.6,
              height: screenHeight * 0.4,
              decoration: BoxDecoration(
                color: ColorViewConstants.colorGrayOpacity,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                  child: Stack(
                alignment: Alignment.center,
                children: [
                  Visibility(
                      visible: croppedFile0 != null ? true : false,
                      child: Image.file(
                    File(croppedFile0 != null ? croppedFile0!.path.toString() : ''),
                    fit: BoxFit.contain,
                  ))
                  ,
                  SvgPicture.asset(
                    'assets/images/services/ic_upload_image.svg',
                    width: 40,
                    height: 40,
                    color: Colors.black,
                  ),
                ],
              )),
            ),
          ],
        ),
      ));
}
