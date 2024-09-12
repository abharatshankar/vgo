import 'dart:math' as math;

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/view/common/widget_loader.dart';

import '../../../../session/session_manager.dart';
import '../../../../utils/utils.dart';
import '../../../../view_model/kyc_view_model.dart';
import 'profile_response.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<StatefulWidget> createState() => ProfileViewState();
}

class ProfileViewState extends State<ProfileView> {
  bool showProgressCircle = false;

  String gapId = '';
  String firstName = '';
  String lastName = '';
  List<Profile>? profileList = [];
  List<Inquiries>? inquiriesList = [];
  List<Accepts>? acceptsList = [];

  void callGetReferProfiles() {
    setState(() {
      showProgressCircle = true;
    });

    KycViewModel.instance.callGetMyProfileInquiries('919588005884',
        completion: (response) {
      setState(() {
        showProgressCircle = false;

        if (response!.success ?? true) {
          profileList = response.profileList;

          for (Inquiries inq in profileList![0].inquiriesList!) {
            inq.colorCode = ((math.Random().nextDouble() * 0xFFFFFF).toInt());
            inquiriesList?.add(inq);
          }

          for (Accepts accept in profileList![0].acceptList!) {
            accept.colorCode =
                ((math.Random().nextDouble() * 0xFFFFFF).toInt());
            acceptsList?.add(accept);
          }
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
      callGetReferProfiles();
    });
    SessionManager.getFirstName().then((value) {
      firstName = value!;
      loggerNoStack.e('firstName :${firstName}');
    });
    SessionManager.getLastName().then((value) {
      lastName = value!;
      loggerNoStack.e('lastName :${lastName}');
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3.5;
    final double itemWidth = size.width / 2;

    return Stack(
      children: [
        Scaffold(
            backgroundColor: ColorViewConstants.colorHintBlue,
            appBar: AppBar(
              backgroundColor: ColorViewConstants.colorBlueSecondaryText,
              toolbarHeight: 0,
            ),
            body: Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 10, right: 10, top: 15),
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'New profiles',
                    style: AppTextStyles.medium.copyWith(
                        fontSize: 13,
                        color: ColorViewConstants.colorPrimaryTextMedium),
                  ),
                  Container(
                    height: 110,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: inquiriesList!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, position) {
                        final Inquiries inquiries = inquiriesList![position];

                        String fNameLName = '';
                        String name = inquiries.profile_name ?? '';
                        if (name.contains(' ')) {
                          var arrayName = name.split(' ');
                          fNameLName = StringUtils.capitalize(
                              arrayName[0].substring(0, 1));
                          fNameLName = fNameLName +
                              (arrayName.length > 1
                                  ? StringUtils.capitalize(
                                      arrayName[1].substring(0, 1))
                                  : '');
                        } else {
                          fNameLName =
                              StringUtils.capitalize(name.substring(0, 1));
                        }
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Color(inquiries.colorCode!)
                                        .withOpacity(1.0),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      fNameLName,
                                      style: AppTextStyles.semiBold.copyWith(
                                        fontSize: 16,
                                        color: ColorViewConstants.colorWhite,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(inquiries.profile_name ?? '',
                                    style: AppTextStyles.medium.copyWith(
                                        fontSize: 13,
                                        color:
                                            ColorViewConstants.colorTextMedium))
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(
                    color: ColorViewConstants.colorGrayLight,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Verified profiles',
                    style: AppTextStyles.medium.copyWith(
                        fontSize: 13,
                        color: ColorViewConstants.colorPrimaryTextMedium),
                  ),
                  Container(
                    height: 110,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: acceptsList!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, position) {
                        final Accepts accepts = acceptsList![position];

                        String fNameLName = '';
                        String name = accepts.profile_name ?? '';
                        if (name.contains(' ')) {
                          var arrayName = name.split(' ');
                          fNameLName = StringUtils.capitalize(
                              arrayName[0].substring(0, 1));
                          fNameLName = fNameLName +
                              (arrayName.length > 1
                                  ? StringUtils.capitalize(
                                      arrayName[1].substring(0, 1))
                                  : '');
                        } else {
                          fNameLName =
                              StringUtils.capitalize(name.substring(0, 1));
                        }
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Color(accepts.colorCode!)
                                            .withOpacity(1.0),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          fNameLName,
                                          style:
                                              AppTextStyles.semiBold.copyWith(
                                            fontSize: 16,
                                            color:
                                                ColorViewConstants.colorWhite,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        color: ColorViewConstants.colorBlue,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: SvgPicture.asset(
                                        "assets/images/profile/ic_award.svg",
                                        width: 10,
                                        height: 10,
                                        color: ColorViewConstants.colorGreen,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(accepts.profile_name ?? '',
                                    style: AppTextStyles.medium.copyWith(
                                        fontSize: 13,
                                        color:
                                            ColorViewConstants.colorTextMedium))
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(
                    color: ColorViewConstants.colorGrayLight,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Personal details',
                    style: AppTextStyles.medium.copyWith(
                        fontSize: 13,
                        color: ColorViewConstants.colorPrimaryTextMedium),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          direction: Axis.vertical,
                          children: [
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'First name',
                                      style: AppTextStyles.regular.copyWith(
                                          color: ColorViewConstants
                                              .colorPrimaryTextHint,
                                          fontSize: 14)),
                                  TextSpan(
                                      text: ' *',
                                      style: AppTextStyles.medium.copyWith(
                                          color: ColorViewConstants.colorRed,
                                          fontSize: 14)),
                                ])),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              firstName,
                              style: AppTextStyles.medium.copyWith(
                                  color: ColorViewConstants
                                      .colorPrimaryTextMedium),
                            )
                          ],
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          direction: Axis.vertical,
                          children: [
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Last name',
                                      style: AppTextStyles.regular.copyWith(
                                          color: ColorViewConstants
                                              .colorPrimaryTextHint,
                                          fontSize: 14)),
                                  TextSpan(
                                      text: ' *',
                                      style: AppTextStyles.medium.copyWith(
                                          color: ColorViewConstants.colorRed,
                                          fontSize: 14)),
                                ])),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              lastName,
                              style: AppTextStyles.medium.copyWith(
                                  color: ColorViewConstants
                                      .colorPrimaryTextMedium),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ))),
        widgetLoader(context, showProgressCircle)
      ],
    );
  }
}
