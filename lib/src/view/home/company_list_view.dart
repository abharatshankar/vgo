import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/model/company.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/view/home/company_info/company_info_view.dart';

Widget widgetCompanyList(BuildContext context, List<Company>? companyList) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: companyList?.length,
    itemBuilder: (context, position) {
      return InkWell(
        onTap: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CompanyInfoView(company: companyList[position],)));
        },
        child: Container(
            margin:
            const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
            padding: EdgeInsets.only(
                top: screenHeight * 0.02,
                left: screenHeight * 0.02,
                right: screenHeight * 0.02,
                bottom: screenHeight * 0.02),
            decoration: BoxDecoration(
                color: ColorViewConstants.colorWhite,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.network(
                        companyList![position].companyIconPath!,
                        width: 35,
                        height: 35,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.48,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        companyList[position].companyName!,
                        style: AppTextStyles.semiBold.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Text(
                        companyList[position].symbol!,
                        style: AppTextStyles.regular.copyWith(fontSize: 13),
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
                          Visibility(
                              visible:
                              companyList[position].growthValue?.isNotEmpty ??
                                  false,
                              child: Wrap(
                                direction: Axis.horizontal,
                                children: [
                                  Icon(
                                    showGrowthArrow(companyList[position]),
                                    color: showGrowthIcon(companyList[position]),
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    getGrowthValue(companyList[position]),
                                    style: showGrowthValue(companyList[position]),
                                  ),
                                ],
                              )),
                          Visibility(
                            visible:
                            companyList[position].growthValue?.isNotEmpty ??
                                false,
                            child: SizedBox(
                              height: screenHeight * 0.0,
                            ),
                          ),
                          Text(
                            showIioCategory(companyList[position]),
                            style: AppTextStyles.regular.copyWith(fontSize: 13),
                          )
                        ],
                      ),
                    )
                ),
              ],
            )),
      );
    },
  );
}

TextStyle showGrowthValue(Company company) {
  TextStyle textStyle = AppTextStyles.medium;

  if (company.growthValue?.isNotEmpty ?? false) {
    if (company.growthValue!.contains('-')) {
      textStyle = AppTextStyles.medium
          .copyWith(fontSize: 14, color: ColorViewConstants.colorRed);
    } else {
      textStyle = AppTextStyles.medium
          .copyWith(fontSize: 14, color: ColorViewConstants.colorGreen);
    }
  }

  return textStyle;
}

Color showGrowthIcon(Company company) {
  Color color = ColorViewConstants.colorBlueSecondaryText;

  if (company.growthValue?.isNotEmpty ?? false) {
    if (company.growthValue!.contains('-')) {
      color = ColorViewConstants.colorRed;
    } else {
      color = ColorViewConstants.colorGreen;
    }
  }
  return color;
}

IconData showGrowthArrow(Company company) {
  IconData icon = Icons.arrow_downward;

  if (company.growthValue?.isNotEmpty ?? false) {
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

  if (company.iioCategory?.toLowerCase() == StringViewConstants.seed) {
    outputCategory = ('${company.seedPrice!}%');
  } else if (company.iioCategory?.toLowerCase() == StringViewConstants.preIio) {
    outputCategory = ('${company.preListingPrice!}%');
  } else if (company.iioCategory?.toLowerCase() == StringViewConstants.iio) {
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
