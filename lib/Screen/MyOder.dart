import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ho_jayega_user_main/Helper/api.path.dart';
import 'package:ho_jayega_user_main/Model/orderModel.dart';
import 'package:ho_jayega_user_main/Screen/orderDetail.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/color.dart';

class MyOrders extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<MyOrders> {
  int _currentStep = 0;
  int _currentStep2 = 0;
  // int index=0;
  OrderModel? order;
  late Future myFuture;
  @override
  void initState() {
    myFuture = getOrders();
    super.initState();
  }

  getindx(int index) {
    print(index);
    switch (index) {
      case 2:
        return 0;
      case 3:
        return 1;
      case 6:
        return 3;
      case 5:
        return 2;

      default:
        return 0;
    }
  }

  Widget _getStepCard(int step) {
    switch (step) {
      case 1:
        return Card(
          // color: Colors.red,
          child: Container(
            width: 300,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.remove_red_eye),
                  Container(
                    child: Image.asset('assets/images/cake12.png'),
                  ),
                  Text(
                    "Parcel Dispecth",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xffAF1919)),
                  ),
                ],
              ),
            ),
          ),
        );
      case 2:
        return Card(
          // color: Colors.red,
          child: Container(
            width: 300,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.remove_red_eye),
                  Container(
                    child: Image.asset('assets/images/cake12.png'),
                  ),
                  Text(
                    "Out for Delivery\nTrack Delivery Boy",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xffAF1919),
                        fontSize: 10),
                  ),
                  Text(
                    "Code=350\nDrop Client",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff112C48),
                        fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
        );
      case 3:
        return Card(
          // color: Colors.red,
          child: Container(
            width: 300,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15, top: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.remove_red_eye),
                  Container(
                    child: Image.asset('assets/images/cake12.png'),
                  ),
                  Text(
                    "Arrived",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xffAF1919),
                        fontSize: 15),
                  ),
                  Text(
                    "Paid=350",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff112C48),
                        fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        );
      default:
        return Container(); // Empty container for no card
    }
  }

  Widget _buildCard(String content) {
    return Card(
      // color: Colors.red,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Center(
          child: Text(content),
        ),
      ),
    );
  }

  Future<void> getOrders() async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? userId = sharedPreferences.getString('user_id');
      var headers = {
        'Cookie': 'ci_session=04c22abbc568c3ad9578f2ba9178c8fa538fe75e'
      };
      http.Response response = await http.post(
        Uri.parse(
            'https://developmentalphawizz.com/hojayega/api/get_users_orders'),
        headers: headers,
        body: {
          'user_id': userId,
        },
      );
      var json = jsonDecode(response.body);
      print(json);
      if (response.statusCode == 200) {
        setState(() {
          order = OrderModel.fromJson(json);
        });
      }
    } catch (e, stack) {
      print(stack);
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.appbarColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder(
            future: myFuture,
            builder: (context, snap) {
              return snap.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        Future.delayed(Duration(seconds: 2));
                        await getOrders();
                        setState(() {});
                      },
                      child: order?.orders.length == 0 ? Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Center(
                            child: Text("Orders Not Found", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                      ):
                       ListView.builder(
                          itemCount: order?.orders.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => OrderDetail(
                                            order_id: order!.orders[index].orderId
                                                .toString(),
                                          ))),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xffEFEFEF),
                                    border: Border.all(
                                        color: const Color(0xff112C48))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      CustomStepIndicator(
                                        currentStep: getindx(int.parse(order!
                                            .orders[index].orderStatus
                                            .toString())),
                                        totalSteps: 4,
                                      ),
                                       Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Assigner\nDelivery Boy"),
                                          Text("Picked          \n"),
                                          Text("Out For\nDelivery"),
                                          Text("Arrived\n"),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white),
                                        // color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              color: Colors.white,
                                              width: 70,
                                              height: 70,
                                              child: Image.network(
                                                order!.orders[index].orderItems
                                                    .first.productImage
                                                    .toString(),
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    const Icon(Icons.image),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Order No- ${order!.orders[index].orderId}",
                                                  style: TextStyle(
                                                      color: Color(0xffAF1919),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                  child: Text(
                                                    order!
                                                        .orders[index]
                                                        .orderItems
                                                        .first
                                                        .productName
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Text(order!
                                                    .orders[index]
                                                    .orderItems
                                                    .first
                                                    .productDescription
                                                    .toString()),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                  child: Text(
                                                      "₹ ${order!.orders[index].total.toString()}"),
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 3,
                                                          horizontal: 5),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xff112C48),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),

                                                      child: Row(
                                                        children: [
                                                          Icon(Icons
                                                              .person_outline),
                                                          Text(
                                                            order!.orders[index]
                                                                .vendorName
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10),
                                                          )
                                                        ],
                                                      ),
                                                      // child: Center(child: Text("Raj Sharma",style: TextStyle(color: Colors.white,fontSize: 10),)),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                      width: 100,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xff112C48),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      child: Center(
                                                          child: Text(
                                                        order!
                                                            .orders[index].time
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10),
                                                      ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      if (_currentStep > 0)
                                        _getStepCard(_currentStep)
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
            }),
      ),
    );
  }
}

class CustomStepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final double circleRadius = 10.0;
  final double lineWidth = 2.0;

  CustomStepIndicator({required this.currentStep, required this.totalSteps});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalSteps, (index) => buildStep(index, context)),
    );
  }

  Widget buildStep(int index, BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: circleRadius,
            backgroundColor: index == currentStep ? Colors.green : Colors.white,
            child: CircleAvatar(
              radius: circleRadius - lineWidth,
              backgroundColor:
                  index == currentStep ? Colors.green : Colors.white,
            ),
          ),
          if (index < totalSteps - 1)
            Container(
              width: 70.0,
              height: lineWidth,
              color: Colors.grey[300],
            ),
        ],
      ),
    );
  }
}
