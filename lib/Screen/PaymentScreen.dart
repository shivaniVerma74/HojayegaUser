import 'package:flutter/material.dart';

import '../Helper/color.dart';
import 'PaymnetDone.dart';

class Paymentscreen extends StatefulWidget {
  const Paymentscreen({Key? key}) : super(key: key);

  @override
  State<Paymentscreen> createState() => _PaymentscreenState();
}

class _PaymentscreenState extends State<Paymentscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.appbarColor,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: colors.primary,
          foregroundColor: Colors.white,//(0xff112C48),
          title: Text('Payment'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.0)
            ),
          )
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
            child: Image.asset("assets/images/pay.png"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, top: 20, right: 10),
            child: Column(
              children: [
                const Text("Order Id - 1213112", style: TextStyle(fontWeight: FontWeight.w600, color: colors.primary, fontSize: 18),),
                Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width/1.1,
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
                          children:  [
                            Text(
                              "Cake",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Product Description"),
                            SizedBox(height: 15),
                            Text("₹  2100"),
                            SizedBox(height: 15,),
                            Row(
                              children: const [
                                Text("15 November 2023", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),),
                                SizedBox(width: 25,),
                                Text(
                                  "Accepted",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: colors.secondary,
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
          SizedBox(height: 10,),
          CircleAvatar(
            radius: 100,
            child: Image.asset("assets/images/qr code.png",),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("200RS", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: colors.primary),),
                Text("COD", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: colors.primary))
              ],
            ),
          ),
          SizedBox(height: 20,),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentDone()));
            },
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width/1.4,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.secondary),
              child: const Center(child: Text("Pay Now",
                style: TextStyle(fontSize: 17, color: colors.whiteTemp, fontWeight: FontWeight.w400),)),
            ),
          ),
        ],
      ),
    );
  }
}
