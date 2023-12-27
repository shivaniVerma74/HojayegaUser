import 'package:flutter/material.dart';

import '../Helper/color.dart';
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
          title: const Text('My Cart'),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.0)
            ),
          )
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
              child: Image.asset("assets/images/demo2.png"),
            ),
            ListView.builder(
              itemCount: 5,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (c,i){
                return Padding(
                padding: const EdgeInsets.only(left: 18, top: 10, right: 10),
                child: Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width/1.1,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colors.whiteTemp,
                      border: Border.all(color: colors.primary,)),
                  child: Row(
                    children: [
                      Image.asset("assets/images/Image 35.png", height: 120, width: 100),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Cake", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
                            SizedBox(height: 7,),
                            Text("Order No -ABC/001"),
                            SizedBox(height: 7),
                            Text("Item: 1"),
                            SizedBox(height: 7,),
                            Text("Bill:  ₹ 2100"),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Paymentscreen()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                height: 30,
                                width: 60,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.secondary),
                                child: Center(child: Text("Pay", style: TextStyle(fontSize: 13, color: colors.whiteTemp),)),
                              ),
                            ),
                          ),
                          SizedBox(height: 60,),
                          Container(
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.red),
                            child: Center(child: Text("Cancel", style: TextStyle(fontSize: 14, color: colors.whiteTemp, fontWeight: FontWeight.w600),)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
