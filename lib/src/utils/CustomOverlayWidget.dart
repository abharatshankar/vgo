
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/response/settings_response.dart';
import '../view/services/order/orders_list_by_users_view.dart';

class Customoverlaywidget{
  late OverlayEntry _overlayEntry;
  // Method to create overlay with three buttons
// Sample data for ListView.builder
  OverlayEntry _createOverlayEntry(BuildContext context,List<SearchItem>? searchItems,String? selectedType,String? title) {
    print('list is : ${searchItems!.length}');
    return OverlayEntry(
      builder: (context) => Positioned(
        top: 100,  // Adjust this to control the position of the overlay
        left: 20,

        right: 20,
        child: Material(
          elevation: 4.0,
          child: Container(
            height: 250,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
            ),
            child:  ListView.builder(
              itemCount: searchItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(
                    searchItems[index].iconPath!,
                    width: 25,
                    height: 25,
                  ),
                  title: Text(searchItems[index].category.toString(),style: TextStyle(color: Colors.black,fontSize: 15,),),
                  onTap: () {
                    String cat = "";
                    if(selectedType == "store"){
                      cat = selectedType!;
                    }else{
                      cat = searchItems[index].category;
                    }
                    _overlayEntry.remove();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrdersListByUsersView(
                              category: cat,subCategories: searchItems[index].subCategories,
                              subCategory: searchItems[index].subCategories[0].name,selectedType: searchItems[index].category.toString(),
                            )));
                  },
                );
              },
            ),
          ),
        ),
      ),

    );
  }

  // Method to show the overlay
  void showOverlay(BuildContext context, List<SearchItem>? searchItems,String? title,{String? selectedType}) {
    _overlayEntry = _createOverlayEntry(context,searchItems,selectedType,title);
    Overlay.of(context)?.insert(_overlayEntry);
  }

  // Method to hide the overlay
  void hideOverlay() {
    try{
      _overlayEntry.remove();
    }catch(e){}
  }



}