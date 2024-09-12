import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/view/common/common_tool_bar_transfer.dart';
import 'package:vgo_flutter_app/src/view/common/widget_loader.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewCommon extends StatefulWidget {
  const WebViewCommon({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => WebViewState();
}

class WebViewState extends State<WebViewCommon> {
  late final WebViewController controller;
  bool showProgressCircle = false;

  @override
  void initState() {
    super.initState();

    String url = '';

    if (widget.title == StringViewConstants.termsConditions) {
      url = 'https://vgopay.in/vgo/terms_and_conditions.html';
    } else if (widget.title == 'Privacy Policy') {
      url = 'https://vgopay.in/vgo/privacy_policy.html';
    } else if (widget.title == 'About Applications') {
      url = 'https://vgopay.in/vgo/about_vgo.html';
    } else if (widget.title == 'Help') {
      url = 'https://vgopay.in/vgo/help.html';
    } else {
      url = 'https://www.google.com';
    }

    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(onPageStarted: (url) {
        setState(() {
          showProgressCircle = true;
        });
      }, onPageFinished: (url) {
        setState(() {
          showProgressCircle = false;
        });
      }))
      ..loadRequest(
        Uri.parse(url),
      )..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorViewConstants.colorBlueSecondaryText,
          toolbarHeight: 0,
        ),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                toolBarTransferWidget(context, widget.title,false),
                Expanded(
                  child: WebViewWidget(
                    controller: controller,
                  ),
                )
              ],
            ),
            Visibility(
                visible: showProgressCircle,
                child: widgetLoader(context, showProgressCircle))
          ],
        ));
  }
}
