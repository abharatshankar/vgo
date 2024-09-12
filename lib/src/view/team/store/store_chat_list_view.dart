import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';
import 'package:vgo_flutter_app/src/view_model/services_view_model.dart';

import '../../../constants/color_view_constants.dart';
import '../../../model/request/create_order_details_chat_request.dart';
import '../../../model/response/store_chat_list_response.dart';
import '../../../utils/app_box_decoration.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/toast_utils.dart';
import '../../common/common_tool_bar_transfer.dart';
import '../../common/widget_loader.dart';

class StoreChatListView extends StatefulWidget {
  StoreChatListView({
    super.key,
    required this.title,
    required this.category,
  });

  String title = '';
  String category = '';

  @override
  State<StoreChatListView> createState() => StoreChatListState();
}

class StoreChatListState extends State<StoreChatListView> {
  bool showProgressCircle = false;

  List<Chat> chatList = [];

  final commentsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    callGetOrderDetailsChat();
  }

  callGetOrderDetailsChat() {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.callGetOrderDetailsChat(widget.title,
        completion: (response) {
      setState(() {
        showProgressCircle = false;

        if (response!.success ?? true) {
          chatList = response.chatList!;
        } else {
          loggerNoStack.e('chat list : ' + response.message!);
        }
      });
    });
  }

  callCreateOrderDetailsChat() {
    setState(() {
      showProgressCircle = true;
    });

    final String userType =
        widget.category == StringViewConstants.CONSTANT_OWNER_STORE_ORDER
            ? 'Store'
            : 'Customer';

    final CreateOrderDetailsChatRequest request = CreateOrderDetailsChatRequest(
        comments: commentsController.text,
        order_no: widget.title,
        user_type: userType);

    ServicesViewModel.instance.callCreateOrderDetailsChat(request,
        completion: (response) {
      setState(() {
        showProgressCircle = false;

        if (response!.success ?? true) {
          commentsController.text = '';
          callGetOrderDetailsChat();
        } else {
          ToastUtils.instance
              .showToast(response.message!, context: context, isError: true);
        }
      });
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
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                toolBarTransferWidget(
                    context, 'Order Number : ' + widget.title, false),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.007),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/services/chat_bg.png'),
                          fit: BoxFit.fill),
                    ),
                    child: ListView.builder(
                        itemCount: chatList!.length,
                        itemBuilder: (context, position) {
                          return chatList![position].user_type == "Customer"
                              ? Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  width: screenWidth * 0.6,
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                      top: 10,
                                      bottom: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      color: ColorViewConstants
                                          .colorWhite),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        chatList![position].comments ?? '',
                                        style: AppTextStyles.medium
                                            .copyWith(
                                            color: ColorViewConstants
                                                .colorPrimaryText,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ))) : Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                      width: screenWidth * 0.6,
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                          color: ColorViewConstants.colorChatBackground),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            chatList[position].comments ?? '',
                                            style: AppTextStyles.medium
                                                .copyWith(
                                                    color: ColorViewConstants
                                                        .colorPrimaryText,
                                                    fontSize: 14),
                                          ),
                                        ],
                                      )));
                        }),
                  ),
                ),
                Container(
                  color: ColorViewConstants.colorWhite,
                  height: screenHeight * 0.09,
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.text,
                          controller: commentsController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: 'Enter comments here...',
                            hintStyle: AppTextStyles.regular.copyWith(
                              fontSize: 16,
                              color: ColorViewConstants.colorGray,
                            ),
                            labelStyle:
                                AppTextStyles.medium.copyWith(fontSize: 15),
                            enabledBorder: AppBoxDecoration.noInputBorder,
                            focusedBorder: AppBoxDecoration.noInputBorder,
                            border: AppBoxDecoration.noInputBorder,
                          ),
                          style: AppTextStyles.medium,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (commentsController.text.isNotEmpty) {
                            callCreateOrderDetailsChat();
                          } else {
                            ToastUtils.instance.showToast(
                                'Please enter the comments!',
                                context: context,
                                isError: false,
                                bg: ColorViewConstants.colorYellow);
                          }
                        },
                        child: SvgPicture.asset(
                          'assets/images/services/ic_send.svg',
                          height: 35,
                          width: 35,
                        ),
                      )
                    ],
                  ),
                ),
              ]),
          widgetLoader(context, showProgressCircle),
        ],
      ),
    );
  }
}
