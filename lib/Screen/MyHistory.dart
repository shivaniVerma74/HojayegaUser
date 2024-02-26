import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ho_jayega_user_main/Helper/api.path.dart';
import 'package:ho_jayega_user_main/Model/getOIrderModel.dart';
import 'package:ho_jayega_user_main/Model/orderModel.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MyHistory extends StatefulWidget {
  const MyHistory({super.key});

  @override
  State<MyHistory> createState() => _MyHistoryState();
}

class _MyHistoryState extends State<MyHistory> {
  List<Order> orderList = [];
  OrderModel? orderData;
  Future<void> getorder() async {
    orderList.clear();
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? user_id = sharedPreferences.getString('user_id');
      var headers = {
        'Cookie': 'ci_session=b2c326a243a38ada285e24fb63a33f6fdd207b82'
      };
      var request =
          http.MultipartRequest('POST', Uri.parse('${ApiServicves.getOrder}'));
      request.fields.addAll({
        'user_id': user_id.toString(),
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var result = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        orderData = OrderModel.fromJson(result);
        orderList = orderData!.orders;
        print(orderList.length);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

  late Future myFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFuture = getorder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
        ),
        title: Text(
          'My History',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF112c48),
      ),
      body: FutureBuilder(
          future: myFuture,
          builder: (context, snap) {
            return snap.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: orderList.length == 0? Center(child: Text("Orders Not Found", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)):
                     ListView.separated(
                      separatorBuilder: (context, index) =>
                          Divider(color: Colors.transparent, height: 8),
                      itemCount: orderList.length,
                      itemBuilder: (context, index) => Card(
                        color: Colors.white,
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  orderList[index]
                                      .orderItems
                                      .first
                                      .productImage
                                      .toString(),
                                ),
                                onBackgroundImageError:
                                    (exception, stackTrace) =>
                                        Icon(Icons.image),
                              ),
                              const VerticalDivider(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Order Id : ${orderList[index].orderId}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    orderList[index].paymentMode.toString(),
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    DateFormat('yMMMMd')
                                        .format(orderList[index].date!)
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Text(
                                "₹${orderList[index].total.toString()}",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
          }),
    );
  }
}
