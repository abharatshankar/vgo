import 'package:flutter/cupertino.dart';
import 'package:vgo_flutter_app/src/utils/app_text_style.dart';

Widget widgetAboutCoinList(BuildContext context, List<String>? aboutList) {

  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: aboutList?.length,
      itemBuilder: (context, position) {
        return Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 0),
            child: Text(
                '* ${aboutList?[position]}', style: AppTextStyles.regular,));
      });
}
