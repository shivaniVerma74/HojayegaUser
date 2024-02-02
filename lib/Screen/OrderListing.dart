import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ho_jayega_user_main/Screen/order%20details/orderdetailsScr.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/api.path.dart';
import '../Helper/color.dart';
import '../Model/getOIrderModel.dart';
import 'PaymentScreen.dart';

class OrderListing extends StatefulWidget {
  const OrderListing({Key? key}) : super(key: key);

  @override
  State<OrderListing> createState() => _OrderListingState();
}

class _OrderListingState extends State<OrderListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.appbarColor,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: colors.primary,
          foregroundColor: Colors.white,//(0xff112C48),
          title: const Text('My Orders'),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.0)
            ),
          )
      ),
      body:

      !isLoading?
      orderList.isNotEmpty?

          RefreshIndicator(
            onRefresh: () async{
              getorder();

            },
            child: ListView.builder(
              itemCount: 1,

              itemBuilder: (context, index) {

              return

                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: Image.asset("assets/images/demo2.png"),
                      ),
                      ListView.builder(
                          itemCount:orderList.length??0,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (c,i){
                            return


                              InkWell(
                                onTap: () {

                                  Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailsScr(orderList:orderList[i]),));

                                },
                                child:

                                Padding(
                                  padding: const EdgeInsets.only(left: 18, top: 10, right: 18),
                                  child:

                                  Container(
                                    height: 190,
                                    width: MediaQuery.of(context).size.width/1.1,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colors.whiteTemp,
                                        border: Border.all(color: colors.primary,)),
                                    child: Padding(
                                      padding:  EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [


                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Order Status : ", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                                              orderList[i].orderStatus=="0"?

                                              Text("Pending", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,color: Colors.red)):
                                              Text("Approved", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,color: Colors.green)),
                                            ],
                                          ),



                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Order No : ", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                                              Text("${orderList[i].orderId.toString()}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                                            ],
                                          ),


                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Vendor Name : ", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                                              Text("${orderList[i].vendorName.toString()}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Total Item : ", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                                              Text("${orderList[i].orderItems?.length.toString()}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                                            ],
                                          ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Total Bill : ", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                                              Text("₹ ${orderList[i].total.toString()}/-", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                                            ],
                                          ),
                                          orderList[i].orderStatus=="0"?SizedBox.shrink():
                                          orderList[i].orderStatus=="4" ?    Container(
                                            height: 30,
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.red),
                                            child: Center(child: Text("Canceled", style: TextStyle(fontSize: 14, color: colors.whiteTemp, fontWeight: FontWeight.w600),)),
                                          ):

                                          Row(

                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Paymentscreen()));
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 120,
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.secondary),
                                                  child: Center(child: Text("Pay", style: TextStyle(fontSize: 13, color: colors.whiteTemp),)),
                                                ),
                                              ),

                                              InkWell(
                                                onTap: () {
                                                  deletePopop(orderList[i].orderId.toString());
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 120,
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.red),
                                                  child: Center(child: Text("Cancel", style: TextStyle(fontSize: 14, color: colors.whiteTemp, fontWeight: FontWeight.w600),)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                          })
                    ],
                  ),
                );
            },),
          ):

      Container(height: MediaQuery.of(context).size.height,

        width: MediaQuery.of(context).size.width,
        child: Center(child:Text("Order Not Found"),),
      )
   :

          Container(height: MediaQuery.of(context).size.height,

          width: MediaQuery.of(context).size.width,
            child: Center(child: CircularProgressIndicator(color: colors.primary,),),
          )
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getorder();
  }
bool isLoading=false;
  GetOrderModel?getOrderModel;
  List<GetOrderModelList> orderList=[];
  Future<void> getorder() async {
    setState(() {
      isLoading=true;
    });
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? user_id = sharedPreferences.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=b2c326a243a38ada285e24fb63a33f6fdd207b82'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiServicves.getOrder}'));
    request.fields.addAll({
      'user_id': user_id.toString(),
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
print("===my technic=======${request.url}===============");
print("===my technic=======${request.fields}===============");
    if (response.statusCode == 200) {
   var result =await response.stream.bytesToString();
   var finalresult=jsonDecode(result);
   if(finalresult['response_code']=="1"){
     getOrderModel=GetOrderModel.fromJson(finalresult);
     orderList=GetOrderModel.fromJson(finalresult).orders??[];
     setState(() {
       isLoading=false;
     });
   }else{
     orderList.clear();
     setState(() {
       isLoading=false;
     });
   }
    }
    else {
    print(response.reasonPhrase);
    }

  }

   Future<void> ordercancledOrder(String orderId) async {
     var headers = {
       'Cookie': 'ci_session=1c5e76ecf359959e0b2331378cf2f27cc3aa16c8'
     };
     var request = http.MultipartRequest('POST', Uri.parse('${ApiServicves.cancleOrder}'));
     request.fields.addAll({
       'id': orderId.toString(),
       'status': '4'
     });

     request.headers.addAll(headers);

     http.StreamedResponse response = await request.send();

     if (response.statusCode == 200) {
   var result =await response.stream.bytesToString();
   var finalresult =jsonDecode(result);
   if(finalresult['error']==false){
     Fluttertoast.showToast(msg: "${finalresult['message']}");
     Navigator.pop(context);
     getorder();
   }
     }
     else {
     print(response.reasonPhrase);
     }


   }


  void deletePopop(String OrderI){

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirm Cancel Order"),
            content: Text("Are you sure you want to Cancel Order?"),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: colors.primary),
                child: Text("YES"),
                onPressed: () {
                  ordercancledOrder(OrderI);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: colors.primary),
                child: Text("NO"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
