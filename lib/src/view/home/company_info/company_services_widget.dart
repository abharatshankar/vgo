import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';

Widget companyServicesWidget(BuildContext context, int selectedIndex, {required Function(int position) completion}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return SizedBox(
    height: screenHeight * 0.05,
    child: ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: getCompanyServicesMenu().length,
      itemBuilder: (context, position) {
        return InkWell(
          onTap: () {
            selectedIndex = position;
            completion(selectedIndex);
          },
          child: Container(
            margin: const EdgeInsets.only(
              left: 10,
              right: 5,
            ),
            padding: EdgeInsets.only(
              top: screenHeight * 0.01,
              left: screenHeight * 0.03,
              right: screenHeight * 0.03,
            ),
            decoration: BoxDecoration(
              color: selectedIndex == position
                  ? ColorViewConstants.colorBlueSecondaryText
                  : ColorViewConstants.colorLightGray,
              borderRadius: const BorderRadius.all(Radius.circular(25)),
            ),
            child: Text(getCompanyServicesMenu()[position],
                style: AppTextStyles.semiBold
                    .copyWith(color: ColorViewConstants.colorWhite)),
          ),
        );
      },
    ),
  );
}

List<String> getCompanyServicesMenu() {
  List<String> servicesList = [];

  servicesList.add('Sub Services');
  servicesList.add('Progress Logs');
  servicesList.add('About the company');

  return servicesList;
}
