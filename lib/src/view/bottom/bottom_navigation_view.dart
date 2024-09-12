import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';
import 'package:vgo_flutter_app/src/view/home/bottom_home_view.dart';
import 'package:vgo_flutter_app/src/view/profile/bottom_profile_view.dart';
import 'package:vgo_flutter_app/src/view/wallet/bottom_wallet_view.dart';

import '../../utils/toast_utils.dart';
import '../activity/bottom_activity_view.dart';
import '../bot/bottom_bot_view.dart';
import '../services/bottom_services_view.dart';

class BottomNavigationView extends StatefulWidget {
  BottomNavigationView({super.key, required this.currentIndex});

  int currentIndex;

  @override
  State<BottomNavigationView> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigationView> {
  Widget? _child;

  @override
  void initState() {
    super.initState();
    _handleNavigationChange(widget.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: ColorViewConstants.colorBlueSecondaryText,
          ),
          body: _child ?? BottomHomeView(),
          bottomNavigationBar: SalomonBottomBar(
            backgroundColor: ColorViewConstants.colorWhite,
            margin:
            const EdgeInsets.only(top: 15, bottom: 15, right: 10, left: 10),
            currentIndex: widget.currentIndex,
            onTap: (i) => setState(() {
              loggerNoStack.e('navPosition' + widget.currentIndex.toString());
              // _currentIndex = widget.navPosition !=0 ? widget.navPosition : 0;
              widget.currentIndex = i;
              _handleNavigationChange(widget.currentIndex);
            }),
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                unselectedColor: ColorViewConstants.colorPrimaryOpacityText50,
                selectedColor: ColorViewConstants.colorPrimaryText,
                title: Text(
                  StringViewConstants.home,
                  style: AppTextStyles.medium.copyWith(
                      fontSize: 15, color: ColorViewConstants.colorPrimaryText),
                ),
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.account_tree_rounded),
                unselectedColor: ColorViewConstants.colorPrimaryOpacityText50,
                title: Text(
                  StringViewConstants.services,
                  style: AppTextStyles.medium.copyWith(
                      fontSize: 15, color: ColorViewConstants.colorPrimaryText),
                ),
                selectedColor: ColorViewConstants.colorPrimaryText,
              ),
/*              SalomonBottomBarItem(
                icon: const Icon(Icons.local_activity),
                unselectedColor: ColorViewConstants.colorPrimaryOpacityText50,
                selectedColor: ColorViewConstants.colorPrimaryText,
                title: Text(
                  StringViewConstants.Activity,
                  style: AppTextStyles.medium.copyWith(
                      fontSize: 15, color: ColorViewConstants.colorPrimaryText),
                ),
              ),*/SalomonBottomBarItem(
                icon:  SvgPicture.asset("assets/images/common/ic_customer_care.svg"),
                unselectedColor: ColorViewConstants.colorPrimaryOpacityText50,
                selectedColor: ColorViewConstants.colorPrimaryText,
                title: Text(
                  'Bot',
                  style: AppTextStyles.medium.copyWith(
                      fontSize: 15, color: ColorViewConstants.colorPrimaryText),
                ),
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.account_balance_wallet),
                unselectedColor: ColorViewConstants.colorPrimaryOpacityText50,
                selectedColor: ColorViewConstants.colorPrimaryText,
                title: Text(
                  StringViewConstants.wallet,
                  style: AppTextStyles.medium.copyWith(
                      fontSize: 15, color: ColorViewConstants.colorPrimaryText),
                ),
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.person),
                unselectedColor: ColorViewConstants.colorPrimaryOpacityText50,
                selectedColor: ColorViewConstants.colorPrimaryText,
                title: Text(
                  'More',
                  style: AppTextStyles.medium.copyWith(
                      fontSize: 15, color: ColorViewConstants.colorPrimaryText),
                ),
              ),
            ],
          ),
        ),
    );

  }

  void _handleNavigationChange(int index) {
    setState(() {
      widget.currentIndex = index;
      switch (index) {
        case 0:
          _child = BottomHomeView();
          break;
        case 1:
          _child = BottomServicesView();
          break;
        case 2:
          _child = BottomBotView(userType: '',);//BottomActivityView();
          break;
        case 3:
          _child = BottomWalletView();//BottomWalletView();
          break;
        case 4:
          _child = BottomProfileView();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: const Duration(milliseconds: 500),
        child: _child,
      );
    });
  }
}
