import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/color_view_constants.dart';
import '../../session/session_manager.dart';
import '../../utils/app_text_style.dart';
import '../../utils/utils.dart';
import '../../view_model/kyc_view_model.dart';
import '../activity/kyc/profile/profile_response.dart';
import '../common/common_tool_bar_transfer.dart';
import '../common/widget_loader.dart';

class ApplicantProfileView extends StatefulWidget {
  ApplicantProfileView({super.key});

  @override
  State<ApplicantProfileView> createState() => ApplicantProfileState();
}

class ApplicantProfileState extends State<ApplicantProfileView> {
  bool showProgressCircle = false;
  String gapId = '';
  String firstName = '';
  String lastName = '';
  String fAndLName = '';
  List<Profile>? profileList = [];
  List<Addresses>? addressList = [];
  List<Education>? educationList = [];
  List<Experience>? experienceList = [];

  bool isEducation = true;
  bool isExperience = false;
  bool isAddress = false;
  bool isPersonal = false;

  void callGetReferProfiles() {
    setState(() {
      showProgressCircle = true;
    });

    KycViewModel.instance.callSearchProfileApi(gapId,
        completion: (response) {
      setState(() {
        showProgressCircle = false;

        if (response!.success ?? true) {
          profileList = response.profileList;

          addressList = profileList![0].addressesList;
          educationList = profileList![0].educationList;
          experienceList = profileList![0].experienceList;
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
      setState(() {
        gapId = value!;
        loggerNoStack.e('gapId :${gapId}');
        callGetReferProfiles();
      });
    });

    SessionManager.getFirstName().then((value) {
      setState(() {
        firstName = value!;
        loggerNoStack.e('firstName :${firstName}');
      });
    });

    SessionManager.getLastName().then((value) {
      setState(() {
        lastName = value!;
        loggerNoStack.e('lastName :${lastName}');
      });
    });
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
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              toolBarTransferWidget(context, 'Applicant profile', false),
              Expanded(
                  child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 15),
                        decoration: BoxDecoration(
                            color: ColorViewConstants.colorBlueSecondaryText,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: ColorViewConstants.colorWhite
                                        .withOpacity(1.0),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      firstName.substring(0, 1) +
                                          '' +
                                          lastName.substring(0, 1),
                                      style: AppTextStyles.semiBold.copyWith(
                                        fontSize: 16,
                                        color: ColorViewConstants
                                            .colorBlueSecondaryText,
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
                              width: 10,
                            ),
                            Expanded(
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  direction: Axis.vertical,
                                  children: [
                                    Text(
                                      firstName + ' ' + lastName,
                                  style: AppTextStyles.semiBold.copyWith(
                                      fontSize: 13,
                                      color: ColorViewConstants.colorWhite),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Active',
                                  style: AppTextStyles.medium.copyWith(
                                      fontSize: 12,
                                      color: ColorViewConstants.colorWhite),
                                )
                              ],
                            )),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  color: ColorViewConstants.colorWhite,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                direction: Axis.vertical,
                                children: [
                                  Text(
                                    'Gap ID',
                                    style: AppTextStyles.semiBold.copyWith(
                                        fontSize: 13,
                                        color: ColorViewConstants
                                            .colorBlueSecondaryText),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Text(
                                    gapId,
                                    style: AppTextStyles.medium.copyWith(
                                        fontSize: 12,
                                        color: ColorViewConstants
                                            .colorPrimaryTextMedium),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 15, bottom: 15),
                          decoration: BoxDecoration(
                              color: ColorViewConstants.colorBlueBackground,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (isEducation) {
                                      isEducation = false;
                                    } else {
                                      isEducation = true;
                                    }
                                  });
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      direction: Axis.vertical,
                                      children: [
                                        Text(
                                          'Education details',
                                          style: AppTextStyles.semiBold
                                              .copyWith(
                                                  fontSize: 13,
                                                  color: ColorViewConstants
                                                      .colorBlueSecondaryText),
                                        ),
                                        SizedBox(
                                          height: 0,
                                        ),
                                        Text(
                                          '',
                                          style: AppTextStyles.medium.copyWith(
                                              fontSize: 12,
                                              color: ColorViewConstants
                                                  .colorSecondaryText),
                                        )
                                      ],
                                    ),
                                    SvgPicture.asset(
                                      'assets/images/common/down_arrow_round.svg',
                                      width: 20,
                                      height: 20,
                                      color: ColorViewConstants
                                          .colorBlueSecondaryText,
                                    )
                                  ],
                                ),
                              ),
                              Visibility(
                                  visible: isEducation,
                                  child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: educationList!.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, position) {
                                        return Container(
                                          margin: const EdgeInsets.only(
                                              top: 0,
                                              left: 5,
                                              right: 5,
                                              bottom: 10),
                                          padding: EdgeInsets.only(
                                              top: screenHeight * 0.02,
                                              left: screenHeight * 0.00,
                                              right: screenHeight * 0.00,
                                              bottom: screenHeight * 0.02),
                                          decoration: BoxDecoration(
                                            color:
                                                ColorViewConstants.colorBlueBackground,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              SizedBox(
                                                width: screenWidth * 0.80,
                                                //height: screenHeight * 0.09,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          educationList![
                                                                      position]
                                                                  .college_university ??
                                                              '',
                                                          style: AppTextStyles
                                                              .medium
                                                              .copyWith(
                                                            color: ColorViewConstants
                                                                .colorPrimaryText,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: screenWidth *
                                                                0.25),
                                                        Text(
                                                          '',
                                                          style: AppTextStyles
                                                              .regular
                                                              .copyWith(
                                                            fontSize: 13,
                                                            color:
                                                                ColorViewConstants
                                                                    .colorGray,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          screenHeight * 0.009,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            child: Text(
                                                          'Duration : ' +
                                                              educationList![
                                                                      position]
                                                                  .duration!,
                                                          style: AppTextStyles
                                                              .regular
                                                              .copyWith(
                                                            color: ColorViewConstants
                                                                .colorPrimaryText,
                                                            fontSize: 13,
                                                          ),
                                                        )),
                                                        Text(
                                                          'Dept : ' +
                                                              educationList![
                                                                      position]
                                                                  .course!,
                                                          style: AppTextStyles
                                                              .regular
                                                              .copyWith(
                                                            color: ColorViewConstants
                                                                .colorPrimaryText,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          screenHeight * 0.009,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Year Of Passed : ',
                                                          style: AppTextStyles
                                                              .regular
                                                              .copyWith(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: screenWidth *
                                                                0.02),
                                                        Text(
                                                          educationList![
                                                                  position]
                                                              .year_of_pass
                                                              .toString(),
                                                          style: AppTextStyles
                                                              .regular
                                                              .copyWith(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          screenHeight * 0.009,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          'assets/images/kyc/ic_location.svg',
                                                          width: 20,
                                                          height: 20,
                                                        ),
                                                        SizedBox(
                                                            width: screenWidth *
                                                                0.01),
                                                        Text(
                                                          educationList![
                                                                      position]
                                                                  .city_town ??
                                                              '',
                                                          style: AppTextStyles
                                                              .regular
                                                              .copyWith(
                                                            color: ColorViewConstants
                                                                .colorPrimaryText,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }))
                            ],
                          )),

                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 15),
                        decoration: BoxDecoration(
                            color: ColorViewConstants.colorBlueBackground,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    if (isExperience) {
                                      isExperience = false;
                                    } else {
                                      isExperience = true;
                                    }
                                  });
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      direction: Axis.vertical,
                                      children: [
                                        Text(
                                          'Experience details',
                                          style: AppTextStyles.semiBold
                                              .copyWith(
                                                  fontSize: 13,
                                                  color: ColorViewConstants
                                                      .colorBlueSecondaryText),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '',
                                          style: AppTextStyles.medium.copyWith(
                                              fontSize: 12,
                                              color: ColorViewConstants
                                                  .colorSecondaryText),
                                        )
                                      ],
                                    ),
                                    SvgPicture.asset(
                                      'assets/images/common/down_arrow_round.svg',
                                      width: 20,
                                      height: 20,
                                      color: ColorViewConstants
                                          .colorBlueSecondaryText,
                                    )
                                  ],
                                )),
                            Visibility(
                                visible: isExperience,
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: experienceList!.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, position) {
                                    return Container(
                                      margin: const EdgeInsets.only(
                                          top: 0,
                                          left: 5,
                                          right: 5,
                                          bottom: 10),
                                      padding: EdgeInsets.only(
                                          top: screenHeight * 0.02,
                                          left: screenHeight * 0.00,
                                          right: screenHeight * 0.00,
                                          bottom: screenHeight * 0.00),
                                      decoration: BoxDecoration(
                                        color: ColorViewConstants.colorBlueBackground,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.80,
                                            //height: screenHeight * 0.09,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      experienceList![position]
                                                              .org_company ??
                                                          '',
                                                      style: AppTextStyles
                                                          .medium
                                                          .copyWith(
                                                        color: ColorViewConstants
                                                            .colorPrimaryText,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width:
                                                            screenWidth * 0.25),
                                                    Text(
                                                      '',
                                                      style: AppTextStyles
                                                          .regular
                                                          .copyWith(
                                                        fontSize: 13,
                                                        color:
                                                            ColorViewConstants
                                                                .colorGray,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: screenHeight * 0.009,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: Text(
                                                      'Desig : ' +
                                                          experienceList![
                                                                  position]
                                                              .desig!,
                                                      style: AppTextStyles
                                                          .regular
                                                          .copyWith(
                                                        color: ColorViewConstants
                                                            .colorPrimaryText,
                                                        fontSize: 13,
                                                      ),
                                                    )),
                                                    Text(
                                                      'Dept : ' +
                                                          experienceList![
                                                                  position]
                                                              .dept!,
                                                      style: AppTextStyles
                                                          .regular
                                                          .copyWith(
                                                        color: ColorViewConstants
                                                            .colorPrimaryText,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: screenHeight * 0.009,
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/images/kyc/years.svg',
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                        width:
                                                            screenWidth * 0.02),
                                                    Text(
                                                      experienceList![position]
                                                              .working_years! +
                                                          '+ years ',
                                                      style: AppTextStyles
                                                          .regular
                                                          .copyWith(
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: screenHeight * 0.009,
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/images/kyc/ic_location.svg',
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                        width:
                                                            screenWidth * 0.01),
                                                    Text(
                                                      experienceList![position]
                                                              .city_town ??
                                                          '',
                                                      style: AppTextStyles
                                                          .regular
                                                          .copyWith(
                                                        color: ColorViewConstants
                                                            .colorPrimaryText,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 15),
                        decoration: BoxDecoration(
                            color: ColorViewConstants.colorBlueBackground,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    if (isAddress) {
                                      isAddress = false;
                                    } else {
                                      isAddress = true;
                                    }
                                  });
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      direction: Axis.vertical,
                                      children: [
                                        Text(
                                          'Address details',
                                          style: AppTextStyles.semiBold
                                              .copyWith(
                                                  fontSize: 13,
                                                  color: ColorViewConstants
                                                      .colorBlueSecondaryText),
                                        ),
                                        SizedBox(
                                          height: 0,
                                        ),
                                        Text(
                                          '',
                                          style: AppTextStyles.medium.copyWith(
                                              fontSize: 12,
                                              color: ColorViewConstants
                                                  .colorSecondaryText),
                                        )
                                      ],
                                    ),
                                    SvgPicture.asset(
                                      'assets/images/common/down_arrow_round.svg',
                                      width: 20,
                                      height: 20,
                                      color: ColorViewConstants
                                          .colorBlueSecondaryText,
                                    )
                                  ],
                                )),
                            Visibility(
                                visible: isAddress,
                                child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: addressList?.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, position) {
                                      var addressBuffer = StringBuffer();
                                      final Addresses address =
                                          addressList![position];

                                      addressBuffer
                                          .write(address.house_no ?? '');
                                      addressBuffer.write(', ');
                                      addressBuffer
                                          .write(address.address1 ?? '');
                                      addressBuffer.write(', ');
                                      addressBuffer
                                          .write(address.address2 ?? '');
                                      addressBuffer.write(', ');
                                      addressBuffer
                                          .write(address.city_town ?? '');
                                      addressBuffer.write(', ');
                                      addressBuffer.write(address.state ?? '');
                                      addressBuffer.write(', ');
                                      addressBuffer
                                          .write(address.country ?? '');
                                      addressBuffer.write(', ');
                                      addressBuffer
                                          .write(address.postal_code ?? '');

                                      return InkWell(
                                        onTap: () {
                                          //completion(false, address);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              top: 5,
                                              left: 10,
                                              right: 10,
                                              bottom: 10),
                                          padding: EdgeInsets.only(
                                              top: screenHeight * 0.02,
                                              bottom: screenHeight * 0.02),
                                          decoration: BoxDecoration(
                                              color:
                                                  ColorViewConstants.colorBlueBackground,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10))),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              SizedBox(
                                                width: screenWidth * 0.1,
                                                //height: screenHeight * 0.09,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/kyc/location.png',
                                                      width: 25,
                                                      height: 25,
                                                      color: ColorViewConstants
                                                          .colorBlueSecondaryText,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenWidth * 0.60,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      addressBuffer.toString(),
                                                      style: AppTextStyles
                                                          .regular
                                                          .copyWith(
                                                              fontSize: 13,
                                                              color: ColorViewConstants
                                                                  .colorPrimaryText),
                                                    ),
                                                    Text(
                                                      'Landmark: ' +
                                                          address.land_mark!,
                                                      style: AppTextStyles
                                                          .regular
                                                          .copyWith(
                                                              fontSize: 13,
                                                              color: ColorViewConstants
                                                                  .colorPrimaryText),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: InkWell(
                                                onTap: () {
                                                  // completion(true, address);
                                                },
                                                child: SizedBox(
                                                  width: screenWidth * 0.10,
                                                  height: screenHeight * 0.06,
                                                  // Adjust this height as needed
                                                  child: Align(
                                                    alignment:
                                                    Alignment.centerRight,
                                                    child: Image.asset(
                                                      'assets/images/kyc/delete.png',
                                                      width: 20,
                                                      height: 20,
                                                      color: ColorViewConstants
                                                          .colorRed,
                                                    ),
                                                  ),
                                                ),
                                              ),)

                                            ],
                                          ),
                                        ),
                                      );
                                    }))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 15),
                        decoration: BoxDecoration(
                            color: ColorViewConstants.colorBlueBackground,
                            borderRadius: BorderRadius.circular(10)),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  if (isPersonal) {
                                    isPersonal = false;
                                  } else {
                                    isPersonal = true;
                                  }
                                });
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    direction: Axis.vertical,
                                    children: [
                                      Text(
                                        'Personal details',
                                        style: AppTextStyles.semiBold.copyWith(
                                            fontSize: 13,
                                            color: ColorViewConstants
                                                .colorBlueSecondaryText),
                                      ),
                                      SizedBox(
                                        height: 0,
                                      ),
                                      Text(
                                        '',
                                        style: AppTextStyles.medium.copyWith(
                                            fontSize: 12,
                                            color: ColorViewConstants
                                                .colorSecondaryText),
                                      )
                                    ],
                                  ),
                                  SvgPicture.asset(
                                    'assets/images/common/down_arrow_round.svg',
                                    width: 20,
                                    height: 20,
                                    color: ColorViewConstants.colorBlueSecondaryText,
                                  )
                                ],
                              ),
                            ),
                            Visibility(
                                visible: isPersonal,
                                child:  Container(
                              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
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
                            ))

                          ],
                        )
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 15),
                        decoration: BoxDecoration(
                            color: ColorViewConstants.colorBlueBackground,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              direction: Axis.vertical,
                              children: [
                                Text(
                                  'Attachments',
                                  style: AppTextStyles.semiBold.copyWith(
                                      fontSize: 13,
                                      color: ColorViewConstants
                                          .colorBlueSecondaryText),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '',
                                  style: AppTextStyles.medium.copyWith(
                                      fontSize: 12,
                                      color: ColorViewConstants
                                          .colorSecondaryText),
                                )
                              ],
                            ),
                            SvgPicture.asset(
                              'assets/images/common/down_arrow_round.svg',
                              width: 20,
                              height: 20,
                              color: ColorViewConstants.colorBlueSecondaryText,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ))
            ],
          ),
          widgetLoader(context, showProgressCircle)
        ],
      ),
    );
  }
}
