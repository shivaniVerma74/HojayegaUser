import 'package:flutter/material.dart';
import 'package:ho_jayega_user_main/Helper/appBar.dart';

import '../Helper/color.dart';
import 'Cart.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: colors.primary,
          foregroundColor: Colors.white,//(0xff112C48),
          title: Text('Details'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.0)
            ),
          )
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: Image.asset("assets/images/Image 35.png", height: 200),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Cake",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Text(
                      "Unit:",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "1Kg",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "900",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "4.8 ********",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 90,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Cart()));
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width / 1.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colors.secondary),
              child: const Center(
                  child: Text(
                "Send For Billing",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: colors.appbarColor),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
