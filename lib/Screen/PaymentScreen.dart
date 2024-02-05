import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ho_jayega_user_main/Model/getOIrderModel.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/color.dart';
import 'PaymnetDone.dart';

class Paymentscreen extends StatefulWidget {
  const Paymentscreen({Key? key, required this.order}) : super(key: key);
  final GetOrderModelList order;
  @override
  State<Paymentscreen> createState() => _PaymentscreenState();
}

class _PaymentscreenState extends State<Paymentscreen> {
  final TextEditingController TransactionId = TextEditingController();

  Future<void> payment({
    required String amount,
    required String order_id,
    required String transaction_id,
    required String payment_status,
    required String payment_method,
  }) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? userId = sharedPreferences.getString('user_id');
      var headers = {
        'Cookie': 'ci_session=04c22abbc568c3ad9578f2ba9178c8fa538fe75e'
      };
      var body = {
        'user_id': userId,
        'amount': amount,
        'order_id': order_id,
        'transaction_id': transaction_id,
        'payment_status': payment_status,
        'payment_method': payment_method,
      };
      log(body.toString());
      var request = await http.post(
        Uri.parse('https://developmentalphawizz.com/hojayega/api/payment_done'),
        body: body,
        headers: headers,
      );
      var json = jsonDecode(request.body);
      if (request.statusCode == 200) {
        print(json);
      } else {
        log(json);
        print(request.reasonPhrase);
      }
    } catch (e, stackTrace) {
      print(stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.appbarColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: colors.primary,
          foregroundColor: Colors.white, //(0xff112C48),
          title: const Text('Payment'),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 15, bottom: 15),
              child: Image.asset("assets/images/pay.png"),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 18, top: 20, right: 10, bottom: 10),
              child: Column(
                children: [
                  Text(
                    "Order Id - ${widget.order.orderId}",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: colors.primary,
                        fontSize: 18),
                  ),
                  Container(
                    height: 140,
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: colors.whiteTemp,
                      border: Border.all(
                        color: colors.primary,
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset("assets/images/Image 35.png",
                            height: 120, width: 100),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.order.orderItems!.first.productName
                                    .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("Product Description"),
                              SizedBox(height: 15),
                              Text("₹  ${widget.order.total}"),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Text(
                                    DateFormat.yMMMd().format(DateTime.parse(
                                        widget.order.date.toString())),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    widget.order.isAccepted == '1'
                                        ? "Accepted"
                                        : "Pending",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: widget.order.isAccepted == '1'
                                          ? colors.secondary
                                          : Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CircleAvatar(
              radius: 100,
              child: Image.asset(
                "assets/images/qr code.png",
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 50, right: 50, top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  Text(
                    "Rs. ${widget.order.total}",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: colors.primary),
                  ),
                  Spacer(),
                  Text("COD",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: colors.primary))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 50, right: 50, top: 20, bottom: 20),
              child: TextField(
                controller: TransactionId,
                decoration: InputDecoration(
                    labelText: "Transaction Id",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: colors.backColor))),
              ),
            ),
            InkWell(
              onTap: () {
                if (TransactionId.text.isNotEmpty) {
                  payment(
                    amount: widget.order.total.toString(),
                    order_id: widget.order.orderId.toString(),
                    transaction_id: TransactionId.text.toString(),
                    payment_status: widget.order.paymentStatus.toString(),
                    payment_method: isChecked ? "COD" : "Online",
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentDone(
                                order: widget.order,
                              )));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please enter transaction id")));
                }
              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1.4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: colors.secondary),
                child: const Center(
                    child: Text(
                  "Pay Now",
                  style: TextStyle(
                      fontSize: 17,
                      color: colors.whiteTemp,
                      fontWeight: FontWeight.w400),
                )),
              ),
            ),
            const Divider(color: Colors.transparent),
          ],
        ),
      ),
    );
  }

  bool isChecked = false;
}
