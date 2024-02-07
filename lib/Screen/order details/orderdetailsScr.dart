import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Helper/appBar.dart';
import '../../Helper/color.dart';
import '../../Model/getOIrderModel.dart';

class OrderDetailsScr extends StatefulWidget {
  GetOrderModelList? orderList;
  OrderDetailsScr({Key? key, this.orderList}) : super(key: key);

  @override
  State<OrderDetailsScr> createState() => _OrderDetailsScrState();
}

class _OrderDetailsScrState extends State<OrderDetailsScr> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: commonAppBar(context, isHome: false, text: "Product Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(children: [
            Row(
              children: [
                Text(
                  "Product",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            ListView.builder(
              itemCount: widget.orderList?.orderItems?.length ?? 0,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: colors.whiteTemp,
                              border: Border.all(
                                color: colors.primary,
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${widget.orderList?.orderItems?[index].productImage}"),
                                  fit: BoxFit.fill)),
                          height: 80,
                          width: 80,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "${widget.orderList?.orderItems?[index].productName}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 20)),
                            Text(
                                "Product Quantity : ${widget.orderList?.orderItems?[index].qty}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 16)),
                            Row(
                              children: [
                                Text(
                                    "Product Price : ₹${widget.orderList?.orderItems?[index].sellingPrice}/",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16)),
                                Text(
                                    "₹${widget.orderList?.orderItems?[index].productPrice}",
                                    style: TextStyle(
                                        fontSize: 13,
                                        decoration: TextDecoration.lineThrough,
                                        color: colors.red)),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Address",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 1.3,
                            child: Text("${widget.orderList?.address}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16))),
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width / 1.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colors.whiteTemp,
                  border: Border.all(
                    color: colors.primary,
                  )),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Order No : ",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                        Text("${widget.orderList?.orderId.toString()}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Order Date : ",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                        Text(
                            "${widget.orderList?.date?.day.toString()}-${widget.orderList?.date?.month.toString()}-${widget.orderList?.date?.year.toString()}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Order Status : ",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                        widget.orderList?.orderStatus == "0"
                            ? Text("Pending",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.red))
                            : Text("Approved",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.green)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Item : ",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                        Text(
                            "${widget.orderList?.orderItems?.length.toString()}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Payment Mode : ",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                        Text(
                            "${widget.orderList?.paymentMode.toString() ?? ""}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Bill : ",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                        Text("₹ ${widget.orderList?.total.toString()}/-",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    ));
  }
}
