import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/view/common/widget_loader.dart';
import 'package:vgo_flutter_app/src/view/team/store/create_store_profile_view.dart';
import 'package:vgo_flutter_app/src/view/team/store/store_profile_list_view.dart';

import '../../../constants/color_view_constants.dart';
import '../../../model/response/settings_response.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/utils.dart';
import '../../common/common_tool_bar_transfer.dart';

class TeamFreelancerListView extends StatefulWidget {
  TeamFreelancerListView(
      {super.key, required this.title, required this.code, required this.subMenuList});

  String title = '';
  String code = '';
  List<MoreMenu> subMenuList = [];

  @override
  State<TeamFreelancerListView> createState() => TeamFreelancerListState();
}

class TeamFreelancerListState extends State<TeamFreelancerListView>
    with SingleTickerProviderStateMixin {
  bool showProgressCircle = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3.0;
    final double itemWidth = size.width / 1.1;
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
                Container(
                  padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: GridView.count(
                    childAspectRatio: (itemWidth / itemHeight),
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: List.generate(widget.subMenuList.length, (index) {
                      return InkWell(
                        onTap: () {
                          loggerNoStack.e(
                              'Menu :' + widget.subMenuList[index].menuCode!);

                          loggerNoStack.e(
                              'categories free listview :' + widget.subMenuList[index].categories.toString());

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateStoreProfileView(
                                title: widget.subMenuList[index].menuCode ?? '',
                              code: widget.code,
                                  categories:  widget.subMenuList[index].categories),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(7.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: ColorViewConstants.colorWhite,
                          ),
                          padding: EdgeInsets.only(
                              top: screenHeight * 0.03,
                              bottom: screenHeight * 0.02,
                              left: screenHeight * 0.01,
                              right: screenHeight * 0.01),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                widget.subMenuList[index].menuIconPath ?? '',
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Text(
                                widget.subMenuList[index].menuName ?? '',
                                style: AppTextStyles.medium.copyWith(
                                  fontSize: 12,
                                  color: ColorViewConstants.colorLightBlack,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
