import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ho_jayega_user_main/Helper/appBar.dart';
import 'package:ho_jayega_user_main/Model/orderModel.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderDetail extends StatefulWidget {
  const OrderDetail({super.key, required this.order_id});
  final String order_id;
  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  OrderModel? orderDetail;
  late Future myFuture;
  List<OrderItem> items = [];
  @override
  void initState() {
    myFuture = getOrderDetail();
    super.initState();
  }

  getVehicle(int index) {
    switch (index) {
      case 1:
        return 'Bike';
      case 2:
        return 'Electric';
      case 3:
        return 'Car';
      case 4:
        return 'Taxi';
      case 5:
        return 'Truck';

      default:
        null;
    }
  }

  Future<void> getOrderDetail() async {
    items.clear();
    try {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
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
          'order_id': widget.order_id,
        },
      );
      var json = jsonDecode(response.body);
      print(json);
      if (response.statusCode == 200) {
        setState(() {
          orderDetail = OrderModel.fromJson(json);
          items = orderDetail!.orders.first.orderItems;
        });
      }
    } catch (e, stack) {
      print(stack);
      throw Exception(e);
    }
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: commonAppBar(
            context,
            text: "Order Detail",
            isHome: false, ontap: (){
            Navigator.pop(context);
          }
          ),
        ),
        body: FutureBuilder(
            future: myFuture,
            builder: (context, snap) {
              return snap.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: items.length,
                                itemBuilder: (context, i) {
                                  return Row(
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Image.network(
                                          items[i].productImage.toString(),
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Icon(
                                            Icons.image,
                                            size: 32,
                                          ),
                                        ),
                                      ),
                                      const VerticalDivider(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            items[i].productName.toString(),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Rs. ${items[i].productPrice}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            "Qty ${items[i].qty}",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }),
                          ),
                          const Divider(color: Colors.transparent),
                          Container(
                            color: Colors.grey.shade300,
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Order ID"),
                                    Text(
                                      orderDetail!.orders.first.orderId
                                          .toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Divider(color: Colors.transparent),
                                    const Text("Payment Method"),
                                    Text(
                                      orderDetail!.orders.first.paymentMode
                                          .toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Divider(color: Colors.transparent),
                                    const Text("Veahicle type"),
                                    Text(
                                      getVehicle(int.parse(orderDetail!
                                          .orders.first.vehicleType
                                          .toString())),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Divider(color: Colors.transparent),
                                    const Text("Vendor Name"),
                                    Text(
                                      orderDetail!.orders.first.vendorName
                                          .toString()
                                          .toUpperCase(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text("Order Date"),
                                    Text(
                                      DateFormat.yMMMEd().format(DateTime.parse(
                                          orderDetail!.orders.first.date
                                              .toString())),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Divider(color: Colors.transparent),
                                    const Text("Order Type"),
                                    Text(
                                      orderDetail!.orders.first.ordersType
                                          .toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Divider(color: Colors.transparent),
                                    const Text("Time"),
                                    Text(
                                      orderDetail!.orders.first.time.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Divider(color: Colors.transparent),
                                    const Text("Payment Satatus"),
                                    Text(
                                      orderDetail!.orders.first.paymentStatus ==
                                              '0'
                                          ? "Unpaid"
                                          : "Paid",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(color: Colors.transparent),
                          const Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              "Price Detail",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Total",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "Rs ${orderDetail!.orders.first.total.toString()}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Delivery Charge",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "Rs ${orderDetail!.orders.first.deliveryCharge.toString()}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Sub Total",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "Rs ${orderDetail!.orders.first.subTotal.toString()}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
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
            }),
      ),
    );
  }
}
