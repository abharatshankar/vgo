import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/model/response/store_list_response.dart';
import 'package:vgo_flutter_app/src/view/team/store/create_store_profile_view.dart';
import 'package:vgo_flutter_app/src/view_model/services_view_model.dart';

import '../../../constants/color_view_constants.dart';
import '../../../model/store.dart';
import '../../../session/session_manager.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/toast_utils.dart';
import '../../../utils/utils.dart';
import '../../common/common_tool_bar_transfer.dart';
import '../../common/widget_loader.dart';

class StoreProfileListView extends StatefulWidget {
  StoreProfileListView({super.key, required this.title, required this.code});

  String title = '';
  String code = '';

  @override
  State<StoreProfileListView> createState() => StoreProfileViewListState();
}

class StoreProfileViewListState extends State<StoreProfileListView> {
  bool showProgressCircle = false;
  String buttonTitle = '';
  String userName = '';

  Store? store;

  callStoreList() {
    setState(() {
      showProgressCircle = true;
    });
    ServicesViewModel.instance.callGetUserStores(userName, widget.title,
        completion: (response) {
      setState(() {
        showProgressCircle = false;
      });

      if (response!.success ?? true) {
        store = response.store!;
      } else {
        ToastUtils.instance
            .showToast(response.message!, context: context, isError: true);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    SessionManager.getUserName().then((value) {
      userName = value!;
      loggerNoStack.e('userName :${userName}');
      callStoreList();
    });

    setState(() {
      if (widget.code == "FREELANCER") {
        buttonTitle = 'ADD PROFILE';
      } else {
        buttonTitle = 'ADD STORE';
      }
    });
  }

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
      body: Stack(
        children: [
          widgetLoader(context, showProgressCircle),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              toolBarTransferWidget(context, widget.title, false),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Align(
                child: MaterialButton(
                  minWidth: screenWidth * 0.9,
                  height: screenHeight * 0.06,
                  color: ColorViewConstants.colorGreen,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateStoreProfileView(
                          title: widget.title,
                          code: widget.code,
                          categories: [],
                        ),
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    '+' + buttonTitle,
                    style: AppTextStyles.medium.copyWith(
                        fontSize: 16, color: ColorViewConstants.colorWhite),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

            ],
          )
        ],
      ),
    );
  }
}
