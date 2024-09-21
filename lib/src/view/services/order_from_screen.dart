import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';
import 'package:vgo_flutter_app/src/view/services/order_form.dart';
import 'package:vgo_flutter_app/src/view/services/user_history_response.dart';

import '../../model/response/settings_response.dart';
import '../../session/session_manager.dart';
import '../../utils/app_text_style.dart';
import '../../utils/utils.dart';
import '../../view_model/services_view_model.dart';
import '../common/widget_loader.dart';

class OrderFromScreen extends StatefulWidget{
  OrderFromScreen({
    super.key,
    required this.userId,
    required this.category,
    required this.searchItems,
  });

  String userId = '';
  String category = '';
  List<SearchItem> searchItems = [];
  @override
  OrderFormNew createState() => OrderFormNew();
}

class OrderFormNew extends State<OrderFromScreen>{


  TextEditingController controller = TextEditingController();

  bool showProgressCircle = false;
  late UserHistoryResponse historyResponse;

  String? userName = "";
  String searchValue = "";
  List<Datum> allInfo = [];
  List<Datum> searchAllInfo = [];
  String emptyVal = "";

  @override
  void initState() {
    super.initState();
    historyResponse = UserHistoryResponse(success: false,message: "",data: []);
    SessionManager.getUserName().then((value) {
      userName = value;
      loggerNoStack.e('userName :${userName!}');
      callUserHistory();
    });
    for(SearchItem item in widget.searchItems){
      List<String> itemsList = [];
      for(SubCategory subcat in item.subCategories){
        if(subcat.items.length > 1){
          itemsList = subcat.items;
        }else{
          itemsList = subcat.items[0].split(',');
        }
        for(String obj in itemsList){
          Datum datum = Datum(itemCategory: item.category,itemSubCategory: subcat.name,searchItem: obj);
          allInfo.add(datum);
        }
      }
    }
    print('allInfo is : ${allInfo.length}');
  }


  void callUserHistory() {
    setState(() {
      showProgressCircle = true;
    });

    ServicesViewModel.instance.UserHistoryResponseList(userName!,completion: (response) {
      setState(() {
        showProgressCircle = false;
      });

      setState(() {
        historyResponse = response!;
        loggerNoStack
            .e('servicesMenuList : ' + historyResponse.data!.length.toString());
      });
    });
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorViewConstants.colorWhite,
      appBar: AppBar(
        backgroundColor: ColorViewConstants.colorBlueSecondaryText,
        toolbarHeight: 50,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(widget.category),
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 18),
      ),
      body: showProgressCircle == true ?
      Center(
        child: LoadingAnimationWidget.discreteCircle(
            color: ColorViewConstants.colorBlueSecondaryText, size: 40),
      )
        : Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(
                  left: 10.0, right: 10, top: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: ColorViewConstants.colorWhite,
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                  leading: Icon(Icons.search_sharp,
                      color: ColorViewConstants.colorGray),
                  title: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontFamily: 'Jost',
                        fontSize: 14,
                        color: ColorViewConstants.colorGray,
                        letterSpacing: -0.2,
                        fontWeight: FontWeight.w100,
                        height: 0.85,
                      ),
                    ),
                    style: AppTextStyles.regular.copyWith(color: ColorViewConstants.colorBlack,fontSize: 17),
                    onChanged:(value){
                      if(value.isEmpty){
                        searchAllInfo = [];
                      }
                     setState(() {
                       searchValue = value;
                       emptyVal = "";
                     });
                    },
                  ),
                  trailing: controller.text.isNotEmpty
                      ? IconButton(
                    icon: Icon(Icons.arrow_circle_right_sharp,
                        color: ColorViewConstants.colorGray),
                    onPressed: () {
                      searchAllInfo = [];
                      for(Datum item in allInfo){
                        if(item.searchItem!.trim().contains(searchValue.trim())){
                          print('serach one is : ${item.searchItem}');
                          searchAllInfo.add(item);
                        }
                      }
                      setState(() {

                      });
                      emptyVal = "No Data";
                    },
                  )
                      : null),
            ),
            SizedBox(height: 15,),
            Expanded(
              child:ListView(
                children: [
                  searchValue.isEmpty ?
                  historyResponse.data!.isEmpty ? Container() :
                  Container(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: historyResponse.data!.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context,index){
                        Datum datum = historyResponse.data![index];
                        return InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderForm(
                                    itemName: datum.searchItem ?? "",
                                    cat: datum.itemCategory!,
                                    subcat: datum.itemSubCategory!,
                                    type: widget.category,
                                  )),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 8),
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 5.0,
                                    offset: Offset(0.0, 3.0)
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: ColorViewConstants.colorLightWhite,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text('Category  : ',
                                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black38),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    Expanded(
                                      child: Text('${datum.itemCategory}',
                                        style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),

                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Text('Item : ',
                                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black38),),
                                    Expanded(
                                      child: Text('${datum.searchItem}',
                                        style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ) :
                  searchAllInfo.isEmpty ? Center(
                    child: Text(emptyVal),
                  ) :
                  Container(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: searchAllInfo.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context,index){
                        Datum data = searchAllInfo[index];
                        return InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderForm(
                                    itemName: data.searchItem ?? "",
                                    cat: data.itemCategory!,
                                    subcat: data.itemSubCategory!,
                                    type: widget.category,
                                  )),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 8),
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 5.0,
                                    offset: Offset(0.0, 3.0)
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: ColorViewConstants.colorLightWhite,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text('Category  : ',
                                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    Expanded(
                                      child: Text('${data.itemCategory}',
                                        style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black38),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Text('Item : ',
                                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),

                                    Expanded(
                                      child: Text('${data.searchItem}',
                                        style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black38),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            ),
            widgetLoader(context, showProgressCircle),
          ],
        ),
      ),
    );
  }


}
