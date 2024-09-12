import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/view/activity/kyc/education/education_add_view.dart';
import 'package:vgo_flutter_app/src/view/activity/kyc/education/education_list_view.dart';
import 'package:vgo_flutter_app/src/view/common/widget_loader.dart';

import '../../../../model/Kyc.dart';
import '../../../../session/session_manager.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/utils.dart';
import '../../../../view_model/kyc_view_model.dart';

class EducationView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EducationViewState();
}

class EducationViewState extends State<EducationView> {
  bool showProgressCircle = false;

  String gapId = '';
  List<Kyc>? kycList = [];

  void callGetEducationList() {
    setState(() {
      showProgressCircle = true;
    });

    KycViewModel.instance.callGetEducationApi(gapId, completion: (response) {
      setState(() {
        showProgressCircle = false;

        if (response!.success ?? true) {
          kycList = response.kycList;
        } else {
          loggerNoStack.e('message : ' + response.message!);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    SessionManager.getGapID().then((value) {
      gapId = value!;
      loggerNoStack.e('gapId :${gapId}');
      callGetEducationList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: ColorViewConstants.colorHintBlue,
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: ColorViewConstants.colorBlueSecondaryText,
          ),
          body: Container(
            // padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: kycList!.length,
                    itemBuilder: (context, position) {
                      return widgetEducationList(context, kycList![position]);
                    },
                  ),
                ),
                Container(
                  color: ColorViewConstants.colorWhite,
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.00,
                    left: screenHeight * 0.02,
                    right: screenHeight * 0.02,
                    bottom: screenHeight * 0.02,
                  ),
                  child: MaterialButton(
                    height: screenHeight * 0.06,
                    color: ColorViewConstants.colorBlueSecondaryDarkText,
                    minWidth: screenWidth,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EducationAddView())).then(
                          (val) => val
                              ? callGetEducationList()
                              : callGetEducationList());
                      ;
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Add Education',
                      style: AppTextStyles.medium.copyWith(
                        fontSize: 15,
                        color: ColorViewConstants.colorWhite,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        widgetLoader(context, showProgressCircle)
      ],
    );
  }
}
