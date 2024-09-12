import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/model/response/settings_response.dart';
import 'package:vgo_flutter_app/src/view/activity/transagent/transagent_grid_widget.dart';
import 'package:vgo_flutter_app/src/view/common/common_tool_bar_transfer.dart';

import '../../../model/settings_data.dart';

class TransAgentView extends StatefulWidget {
  TransAgentView({super.key, required this.settingsResponse});

  SettingsResponse? settingsResponse;

  @override
  State<TransAgentView> createState() => TransAgentViewState();
}

class TransAgentViewState extends State<TransAgentView> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorViewConstants.colorLightWhite,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: ColorViewConstants.colorBlueSecondaryText,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 0.0,
          left: 0.5,
          right: 0.5,
          bottom: 0.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            toolBarTransferWidget(context, "TransAgent", false),
            transAgentWidget(context, widget.settingsResponse!.transAgentList!)
          ],
        ),
      ),
    );
  }
}
