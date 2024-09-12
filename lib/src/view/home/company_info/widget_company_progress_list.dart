import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_string_utils.dart';

import '../../../model/company.dart';

Widget widgetCompanyProgressList(BuildContext context, List<Company>? progressList) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: progressList?.length,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, position) {
      return Container(
        margin: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
        padding: EdgeInsets.only(
          top: screenHeight * 0.01,
          left: screenHeight * 0.02,
          right: screenHeight * 0.01,
          bottom: screenHeight * 0.01,
        ),
        decoration: BoxDecoration(
            color: ColorViewConstants.colorWhite,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: screenWidth * 0.10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      Image.network(
                        AppStringUtils.noImageUrl,
                        width: 40,
                        height: 40,
                      )
                    ],
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.75,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          progressList![position].department!,
                          style: AppTextStyles.medium.copyWith(
                            fontSize: 16, color: ColorViewConstants.colorPrimaryText
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.005,
                        ),
                        Text(
                          progressList[position].updatedAt!,
                          style: AppTextStyles.regular.copyWith(
                            fontSize: 14,
                            color: ColorViewConstants.colorBlueSecondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.005,
              ),
              Text(
                progressList[position].commentProgress!,
                style: AppTextStyles.regular.copyWith(
                  fontSize: 14,
                  color: ColorViewConstants.colorPrimaryOpacityText50,
                ),
              ),
            ],
          ),
        );
      },
  );
}
