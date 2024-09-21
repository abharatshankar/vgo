import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:vgo_flutter_app/src/session/session_manager.dart';

import '../../constants/color_view_constants.dart';
import '../../utils/CustDropDown.dart';
import '../../utils/toast_utils.dart';


class OrderForm extends StatefulWidget {
  const OrderForm({super.key, required this.itemName,required this.cat,required this.subcat,required this.type});
  final String itemName;
  final String cat;
  final String subcat;
  final String type;
  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {

  TextEditingController nameController = TextEditingController();
  TextEditingController orderDetailsController = TextEditingController();

  int orderVal = 0;
  bool showProgressCircle = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    orderDetailsController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(widget.type.toLowerCase() == "order" ? "Order Form" : widget.type.toLowerCase() == "job" ? "Job Form" : widget.type.toLowerCase() == "job" ? " Appointment Form" : "${widget.cat}"),),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: showProgressCircle == true ?
        Center(
          child: LoadingAnimationWidget.discreteCircle(
              color: ColorViewConstants.colorBlueSecondaryText, size: 40),
        ) :
       ListView(
         children: [
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 8),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(widget.type.toLowerCase() == "order" ? "Item Name" : widget.type.toLowerCase() == "job" ? "Job Title" : "Appointment Title",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                     SizedBox(height: 12,),
                     Text(widget.itemName,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18),)
                   ],),
               ),
               widget.type.toLowerCase() == "appointment" ||  widget.type.toLowerCase() == "job" ?
               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 10),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(widget.type.toLowerCase() == "job" ? "Gap Id" : "Name of The Candidate",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                     SizedBox(height: 12,),
                     TextField(
                       controller: nameController,
                       decoration: InputDecoration(
                         hintText: widget.type.toLowerCase() == "job" ? "Enter Gap Id" : "Enter Name of The Candidate",
                         hintStyle: TextStyle(
                           color: Colors.black38,
                         ),
                         border: OutlineInputBorder(),
                        // prefixIcon: Icon(Icons.person),
                       ),
                       onChanged: (value) {
                         print('User input: $value');
                       },
                     ),
                   ],
                 ),
               ) : Container(),
               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 10),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(widget.type.toLowerCase() == "order" ? "Order Details" : widget.type.toLowerCase() == "job" ? "Skills" : "Purpose",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                     SizedBox(height: 12,),
                     TextField(
                       controller: orderDetailsController,
                       decoration: InputDecoration(
                         hintText: widget.type.toLowerCase() == "order" ? "Enter order details" : widget.type.toLowerCase() == "job" ? "Enter Skills" : "Enter Purpose",
                         hintStyle: TextStyle(
                           color: Colors.black38,
                         ),
                         border: OutlineInputBorder(),
                       //  prefixIcon: Icon(Icons.person),
                       ),
                       onChanged: (value) {
                         print('User input: $value');
                       },
                     ),
                   ],
                 ),
               ),
               SizedBox(height: 12,),
               Text(widget.type.toLowerCase() == "order" ? "Order" :
               widget.type.toLowerCase() == "job" ? "Job" : "Appointment",
                 style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
               SizedBox(height: 12,),
               Container(
                 height: 40,
                 decoration: BoxDecoration(
                     color: Colors.white, borderRadius: BorderRadius.circular(12)),
                 child: CustDropDown(
                   items:  [
                     CustDropdownMenuItem(
                       value: 0,
                       child: Container(
                           decoration: BoxDecoration(
                               color: Colors.white, borderRadius: BorderRadius.circular(12)),
                           width: double.infinity,
                           height: 29,
                           child: Text("Now")),
                     ),
                     CustDropdownMenuItem(
                       value: 1,
                       child: SizedBox(
                           width: double.infinity,
                           height: 29,
                           child: Text("Later")),
                     )
                   ],
                   hintText: "Select type",
                   borderRadius: 5,
                   onChanged: (val) {
                     print(val);
                     orderVal = val;
                   },
                 ),
               ),
               SizedBox(height: 50,),
               GestureDetector(
                   onTap: ()async{
                     createOrder(orderType: "",category: "",itemName: "",subCategory: "").then((value){
                       //to handle callback
                     });
                   },
                   child: Center(
                     child: Container(width: MediaQuery.of(context).size.width * 0.7,height: 40,child: Center(child: Text('Submit')),
                       decoration: BoxDecoration(
                           boxShadow: [
                             BoxShadow(
                                 color: Colors.black.withOpacity(0.3),
                                 blurRadius: 5.0,
                                 offset: Offset(0.0, 3.0)
                             ),
                           ],
                           borderRadius: BorderRadius.circular(14),color: Colors.white),
                     ),
                   ))

             ],),
         ],
       ),
      )),);
  }

  Future<void> createOrder({required String orderType,required String category,required String subCategory,required String itemName}) async {
    // Define the API endpoint
    // Create Dio instance
    Map<String, dynamic> data = {};
    setState(() {
      showProgressCircle = true;
    });
    Dio dio = Dio();

    // Define the API URL
    String url = 'https://vgopay.in/profile/public/api/stores/products/orders/create-order';
    String? userName = "" ;
    userName = await SessionManager.getUserName();;

    if(widget.type.toLowerCase() == "order"){
      // Define the request body
     data = {
        "username": userName,
        "order_type": "D",
        "category": widget.cat,
        "sub_category": widget.subcat,
        "item_name": widget.itemName,
        "order_items": orderDetailsController.text.toString(),
        "order_priority": orderVal == 0 ? "Now" : "Later"
      };
    }
    if(widget.type.toLowerCase() == "appointment"){
      // Define the request body
      data = {
        "username": userName,
        "order_type": "D",
        "category": widget.cat,
        "sub_category": widget.subcat,
        "item_name": widget.itemName,
        "name": nameController.text.toString(),
        "order_items": orderDetailsController.text.toString(),
        "order_priority": orderVal == 0 ? "Now" : "Later"
      };
    }
    if(widget.type.toLowerCase() == "job"){
      // Define the request body
      data = {
        "username": userName,
        "order_type": "D",
        "category": widget.cat,
        "sub_category": widget.subcat,
        "gap_id": nameController.text.toString(),
        "item_name": widget.itemName,
        "order_items": orderDetailsController.text.toString(),
        "order_priority": orderVal == 0 ? "Now" : "Later"
      };
    }


    try {
      // Send the POST request
      print('url is : $url');
      print('body is : $data');

      Response response = await dio.post(url, data: data);
      print('Order created: ${response.data}');
      // Check if the request was successful
      if (response.data['success'] == true) {
        setState(() {
          showProgressCircle = false;
        });
        Navigator.of(context).pop();
        ToastUtils.instance
            .showToast(response.data['message'], context: context, isError: false,bg : Colors.green);
      } else {
        print('Failed to create order: ${response.statusCode}');
        setState(() {
          showProgressCircle = false;
        });
        ToastUtils.instance
            .showToast(response.data['message'], context: context, isError: true);
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        showProgressCircle = false;
      });
      ToastUtils.instance
          .showToast(e.toString(), context: context, isError: true);
    }
  }

}