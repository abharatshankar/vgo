import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vgo_flutter_app/src/view/profile/widget_settings_list.dart';

import '../../constants/color_view_constants.dart';
import '../../constants/string_view_constants.dart';
import '../../model/settings_data.dart';
import '../../model/user.dart';
import '../../utils/utils.dart';
import '../common/common_tool_bar_transfer.dart';

class SettingsListView extends StatefulWidget {
  @override
  @override
  State<SettingsListView> createState() => _SettingsListState();
}

class _SettingsListState extends State<SettingsListView> {
  List<SettingsData> settingsDataList = [];

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  User? user;
  String appVersion = '';

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
      loggerNoStack.e('_packageInfo ' + _packageInfo.version);
    });
  }

  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    setState(() {
      generateSettingsList();
    });

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorViewConstants.colorBlueSecondaryText,
          toolbarHeight: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            toolBarTransferWidget(context, StringViewConstants.settings, false),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            widgetSettingsList(context, settingsDataList),
          ],
        ),
      ),
    );
  }

  generateSettingsList() {
    settingsDataList = [
      SettingsData(
        title: StringViewConstants.userCategory,
        icon: Icons.category_outlined,
      ),  SettingsData(
        title: 'KYC',
        icon: Icons.photo_camera_outlined,
      ),
      SettingsData(
        title: StringViewConstants.notifications,
        icon: Icons.notifications_none,
      ),
      SettingsData(
        title: StringViewConstants.termsConditions,
        icon: Icons.my_library_books_outlined,
      ),
      SettingsData(
        title: StringViewConstants.privacyPolicy,
        icon: Icons.privacy_tip_outlined,
      ),
      SettingsData(
        title: StringViewConstants.help,
        icon: Icons.help_center_outlined,
      ),
      SettingsData(
        title: StringViewConstants.aboutApplications,
        icon: Icons.info_outline,
      ),
      SettingsData(
        title: StringViewConstants.rateUs,
        icon: Icons.rate_review_outlined,
      ),
      SettingsData(
        title: StringViewConstants.app_version + ' ' + _packageInfo.version,
        icon: Icons.ad_units_sharp,
      ),
    ];
  }
}
