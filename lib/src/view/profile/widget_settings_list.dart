import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/session/session_manager.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/view/login/user_login_view.dart';
import 'package:vgo_flutter_app/src/view/profile/user_category/user_category_view.dart';
import 'package:vgo_flutter_app/src/view/profile/web_view_common.dart';

import '../../constants/string_view_constants.dart';
import '../../model/settings_data.dart';
import '../activity/kyc/profile/profile_view.dart';

Widget widgetSettingsList(BuildContext context, List<SettingsData> list) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    scrollDirection: Axis.vertical,
    itemCount: list.length,
    itemBuilder: (context, position) {
      return InkWell(
        onTap: () {
          if (position == 0) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserCategoryView()));
          } else if (position == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileView()));
            /*Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileView(
                      title: StringViewConstants.notifications,
                    )));*/
          } else if (position == 2) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebViewCommon(
                      title: StringViewConstants.notifications,
                        )));
          } else if (position == 3) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebViewCommon(
                      title: StringViewConstants.termsConditions,
                        )));
          } else if (position == 4) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebViewCommon(
                      title: StringViewConstants.privacyPolicy,
                        )));
          } else if (position == 5) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebViewCommon(
                      title: StringViewConstants.help,
                        )));
          } else if (position == 6) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebViewCommon(
                      title: StringViewConstants.aboutApplications,
                        )));
          } else if (position == 7) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebViewCommon(
                          title: StringViewConstants.rateUs,
                        )));
          } else if (position == 8) {
            // showAlertDialog(context, 'VGo Alert', 'Do you want to logout?');
            CoolAlert.show(
              context: context,
              type: CoolAlertType.confirm,
              text: StringViewConstants.wantToLogout,
              confirmBtnText: StringViewConstants.yes,
              cancelBtnText: StringViewConstants.no,
              confirmBtnColor: ColorViewConstants.colorBlueSecondaryText,
              onConfirmBtnTap: () {
                SessionManager.clearSession();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserLoginView()));
              },
            );
          }
        },
        child: Container(
            padding:
            const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.08,
                    ),
                    Icon(
                      list[position].icon,
                      size: 25,
                      color: Colors.blueGrey,
                    ),
                    SizedBox(
                      width: screenWidth * 0.03,
                    ),
                    Text(
                      list[position].title,
                      style: AppTextStyles.medium.copyWith(
                          fontSize: 14, color: ColorViewConstants.colorPrimaryText),
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Divider(
                  height: 1,
                  color: ColorViewConstants.colorGrayOpacity,
                )
              ],
            )),
      );
    },
  );
}
