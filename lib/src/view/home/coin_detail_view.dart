import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/string_view_constants.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/model/company.dart';
import 'package:vgo_flutter_app/src/view/home/widget/coin/widget_about_coin_list.dart';
import 'package:vgo_flutter_app/src/view/home/widget/coin/widget_coin_investor_list.dart';
import 'package:vgo_flutter_app/src/view/home/widget/coin/widget_coin_treasury_list.dart';
import 'package:vgo_flutter_app/src/view/home/widget/widget_coin_details.dart';
import 'package:vgo_flutter_app/src/view_model/home_view_model.dart';

import '../../model/coin.dart';
import '../../utils/utils.dart';
import '../common/common_tool_bar_white.dart';

class CoinDetailView extends StatefulWidget {
  CoinDetailView({super.key});

  List<String> aboutList = [];
  List<Coin> allCoinsList = [];
  List<Company> allTreasuryList = [];
  bool showProgressCircle = false;

  @override
  State<StatefulWidget> createState() => CoinDetailState();
}

class CoinDetailState extends State<CoinDetailView>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int _selectedIndex = 0;
  bool showProgressCircle = false;



  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: ${_controller.index}");
    });

    callAboutCoinList();

    callAllCoinTreasuryList();

   callGetTreasuryAllInvestmentsList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void callAboutCoinList() {
    setState(() {
      showProgressCircle = true;
    });

    HomeViewModel.instance.apiAboutCoinList(completion: (response) {
      setState(() {
        showProgressCircle = false;
      });

      widget.aboutList.addAll(response?.aboutCoinList as Iterable<String>);
      widget.aboutList.addAll(response?.aboutPointsList as Iterable<String>);
    });
  }

  void callAllCoinTreasuryList() {
    setState(() {
      showProgressCircle = true;
    });

    HomeViewModel.instance.apiAllCoinTreasuryList(completion: (response) {
      setState(() {
        showProgressCircle = false;
      });
      setState(() {
        showProgressCircle = false;
      });

      if (response!.success ?? true) {
        widget.allCoinsList = response.allCoinsList!;
      } else {
        loggerNoStack.e('response :${response.message}');
      }
    });
  }

  void callGetTreasuryAllInvestmentsList() {
    setState(() {
      widget.showProgressCircle = true;
    });

    HomeViewModel.instance.callGetTreasuryAllInvestmentsList(
        completion: (response) {
      setState(() {
        widget.showProgressCircle = false;
      });
      widget.allTreasuryList = response!.allTreasuryList!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: ColorViewConstants.colorBlueSecondaryText,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          toolBarTransferWhiteWidget(context, StringViewConstants.aboutCoin),

          widgetCoinDetails(context, null),

          SizedBox(
            height: screenHeight * 0.01,
          ),

          DefaultTabController(
            initialIndex: _selectedIndex,
            animationDuration: const Duration(milliseconds: 500),
            length: 3,
            child: TabBar(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              labelColor: ColorViewConstants.colorBlueSecondaryText,
              unselectedLabelColor: ColorViewConstants.colorHintGray,
              labelStyle: AppTextStyles.medium.copyWith(fontSize: 16),
              indicatorColor: ColorViewConstants.colorBlueSecondaryText,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(
                  text: StringViewConstants.treasury,
                ),
                Tab(
                  text: StringViewConstants.investor,
                ),
              Tab(
              text: 'About',
            ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
                controller: _controller,
                children: [
              widgetCoinTreasury(
                  context, widget.allCoinsList, widget.aboutList),
                  widgetCoinInvestorList(context, widget.allTreasuryList),
                  widgetAboutCoinList(context, widget.aboutList),
            ]),
          )
        ],
      ),
    );
  }
}
