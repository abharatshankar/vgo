import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';

import '../../../model/company.dart';
import '../../../utils/utils.dart';
import '../company_list_view.dart';

Widget widgetCompanyInfo(BuildContext context, Company? company) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    margin: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
    padding: EdgeInsets.only(
        top: screenHeight * 0.02,
        left: screenHeight * 0.02,
        right: screenHeight * 0.01,
        bottom: screenHeight * 0.00),
    decoration: BoxDecoration(
        color: ColorViewConstants.colorWhite,
      //  borderRadius: const BorderRadius.all(Radius.circular(10))
    ),
    child: Row(
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
                company!.companyIconPath! ?? '',
                width: 35,
                height: 35,
              ),
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
                company.companyName! ?? '',
                style: AppTextStyles.medium.copyWith(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.001,
              ),
              Text(
                company.symbol! ?? '',
                style: AppTextStyles.medium.copyWith(
                    fontSize: 13, color: ColorViewConstants.colorGray),
              ),
            ],
          ),
        ),

    SizedBox(
        width: screenWidth * 0.22,
        child: Align(
          alignment: Alignment.bottomRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                showIioCategory(company),
                style: AppTextStyles.regular.copyWith(fontSize: 14,color: ColorViewConstants.colorGreen),
              ),
              Visibility(
                  visible:true,
                  child: Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Icon(
                        Icons.currency_rupee_outlined,
                        color: ColorViewConstants.colorBlack,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        "${company.stockPrice!}",
                        style: TextStyle(fontSize: 22.0,color: ColorViewConstants.colorBlack),
                      ),
                    ],
                  )),
              Visibility(
                visible:true,
                child: SizedBox(
                  height: screenHeight * 0,
                ),
              ),

            ],
          ),
        )
    ),
      ],
    ),
  );
}

IconData showGrowthArrow(Company company) {
  IconData icon = Icons.arrow_downward;

  if (company.growthValue?.isNotEmpty ?? false) {
    loggerNoStack.e('growthValue${company.growthValue}');
    if (company.growthValue!.contains('-')) {
      icon = Icons.arrow_downward;
    } else {
      icon = Icons.arrow_upward;
    }
  }
  return icon;
}

String showIioCategory(Company company) {
  String? outputCategory = '';

  if (company.iioCategory?.toLowerCase() == 'seed') {
    outputCategory = ('${company.seedPrice!}%');
  } else if (company.iioCategory?.toLowerCase() == 'pre iio') {
    outputCategory = ('${company.preListingPrice!}%');
  } else if (company.iioCategory?.toLowerCase() == 'iio') {
    outputCategory = ('${company.stockPrice!}%');
  }

  return outputCategory;
}

String getGrowthValue(Company company) {
  String value = '';
  if (company.growthValue?.isNotEmpty ?? false) {
    value = '${company.growthValue}%';
  }
  return value;
}