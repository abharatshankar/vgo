import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_string_utils.dart';

import '../../../model/company.dart';

Widget widgetSubServicesList(BuildContext context, List<Company>? companyList) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: companyList?.length,
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
                    width: screenWidth * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          companyList![position].serviceName!,
                          style: AppTextStyles.medium.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.005,
                        ),
                        Text(
                          companyList[position].industry!,
                          style: AppTextStyles.regular.copyWith(
                            fontSize: 14,
                            color: ColorViewConstants.colorBlueSecondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.2,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            '1 month ago',
                            style: AppTextStyles.regular.copyWith(
                              fontSize: 12,
                              color: ColorViewConstants.colorGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.005,
              ),
              Text(
                companyList[position].aboutService!,
                style: AppTextStyles.regular.copyWith(
                  fontSize: 13,
                  color: ColorViewConstants.colorGray,
                ),
              ),
            ],
          ),
        );
      },
  );
}
