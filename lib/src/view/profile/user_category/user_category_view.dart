import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';
import 'package:vgo_flutter_app/src/view/common/common_tool_bar_transfer.dart';
import 'package:vgo_flutter_app/src/view/profile/user_category/user_category_drop_down.dart';
import 'package:vgo_flutter_app/src/view/profile/user_category/user_sub_category_drop_down.dart';
import 'package:vgo_flutter_app/src/view/profile/user_category/user_types.dart';
import 'package:vgo_flutter_app/src/view/services/transfer/transfer_blue_button_widget.dart';
import 'package:vgo_flutter_app/src/view_model/profile_view_model.dart';

import '../../../model/user_type_menu.dart';

class UserCategoryView extends StatefulWidget {
  UserCategoryView({super.key});


  @override
  State<UserCategoryView> createState() => UserCategoryState();
}

class UserCategoryState extends State<UserCategoryView> {
  bool showProgressCircle = false;
  List<UserTypeMenu> userTypeMenuList = [];
  List<String> userTypesList = [];
  List<String> userSubTypeMenuList = [];

  String userTypeValue = StringViewConstants.customer;

  String userSubTypeValue = StringViewConstants.loyalty;

  void callGetUserTypesMenu() {
    setState(() {
      showProgressCircle = true;
    });

    ProfileViewModel.instance.callGetUserTypes(completion: (response) {
      setState(() {
        showProgressCircle = false;
      });

      setState(() {
        userTypeMenuList = response!.userTypeMenuList!;

        for (UserTypeMenu menu in response.userTypeMenuList!) {
          userTypesList.add(menu.userType!);
        }
        userSubTypeMenuList.addAll(response.userTypeMenuList![0].userSubTypeList!);
        loggerNoStack.e('message${userTypesList.length}');
      });
    });
  }

  @override
  void initState() {
    super.initState();
    callGetUserTypesMenu();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorViewConstants.colorWhite,
      appBar: AppBar(
        backgroundColor: ColorViewConstants.colorBlueSecondaryText,
        toolbarHeight: 0,
      ),
      body: Container(
        color: ColorViewConstants.colorWhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            toolBarTransferWidget(context, StringViewConstants.userCategory,false),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [

                  Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: widgetUserType(context,  StringViewConstants.userType),
                  ),

                  Align(
                    child: widgetUserCategoryDropDown(
                      context,
                      userTypeValue,
                      userTypesList,
                      completion: (userType) {
                        setState(() {
                          userTypeValue = userType;
                          for(UserTypeMenu menu in userTypeMenuList){
                            if(menu.userType == userType){
                              userSubTypeMenuList = menu.userSubTypeList!;
                              userSubTypeValue = userSubTypeMenuList[0];
                            }
                          }
                        });
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: widgetUserType(context, StringViewConstants.userSubType),
                  ),

                   Align(
                    child: widgetUserSubCategoryDropDown(
                      context,
                      userSubTypeValue,
                      userSubTypeMenuList,
                      completion: (userSubType) {
                        setState(() {
                          userSubTypeValue = userSubType;
                        });
                      },
                    ),
                  ),

                  SizedBox(
                    height: screenHeight * 0.05,
                  ),

                  widgetTransferBlueButton(context, StringViewConstants.update,  ColorViewConstants.colorBlueSecondaryText,'',"Please Enter Amount",
                      completion: (amount) {}),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
