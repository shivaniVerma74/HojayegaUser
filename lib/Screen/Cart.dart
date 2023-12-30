import 'package:flutter/material.dart';

import '../Helper/color.dart';
import 'OrderListing.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  String? selectOrders;
  var orderitem = [
    'Yes',
    'No',
  ];

  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _descrementerCounter() {
    setState(() {
      _counter--;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
          ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
            child: Image.asset("assets/images/demo1.png"),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderListing()));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width/1.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colors.secondary),
                child: const Center(
                    child: Text(
                      "Send shop for billing",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: colors.appbarColor),
                    ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Select All Item", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                Text("(1 Item Select)",  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400))
              ],
            ),
          ),
          Container(
            height: 120,
            width: MediaQuery.of(context).size.width/1.1,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Row(
              children: [
                 Image.asset("assets/images/Image 35.png", height: 90, width: 90),
                 const SizedBox(width: 10,),
                 Padding(
                   padding: const EdgeInsets.only(top: 10),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: const [
                       Text("Ravalgaon Pan Pasand"),
                       Text("100+ Bought In Past"),
                       Text("Month"),
                       SizedBox(height: 10),
                       Text("200 Rs")
                     ],
                   ),
                 ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                InkWell(
                  onTap: _descrementerCounter,
                    child: const Icon(Icons.remove, color: Colors.black, size: 30,)),
                 Text("$_counter", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),),
                InkWell(
                  onTap: _incrementCounter,
                    child: const Icon(Icons.add, color: Colors.black, size: 30)),
                Container(
                    height: 45,
                    width: 140,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                    child: const Center(
                        child: Text("Delete", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400))),
                ),
              ],
            ),
          ),
          Container(
            height: 45,
            width: MediaQuery.of(context).size.width/1.1,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colors.primary),
            child: const Padding(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Text("Time: 2:00 to 4:00", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400),),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: 45,
            width: MediaQuery.of(context).size.width/1.1,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colors.primary),
            child: Padding(
              padding: EdgeInsets.only(top: 5, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Vehicle Type", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400),),
                  Image.asset("assets/images/bike.png")
                ],
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colors.primary),
            width: MediaQuery.of(context).size.width/1.1,
            child: Card(
              color: colors.primary,
              elevation: 2,
              child: DropdownButtonFormField<String>(
                value: selectOrders,
                icon: const Icon(Icons.keyboard_arrow_down_sharp, color: colors.whiteTemp,),
                onChanged: (String? newValue) {
                  setState(() {
                    selectOrders = newValue!;
                    print("jkjkdjjjkksk $selectOrders");
                  });
                },
                items: orderitem.map((String orderitem) {
                  return DropdownMenuItem(
                    value: orderitem,
                    child: Text(orderitem.toString(), style: TextStyle(color: colors.whiteTemp),),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Order Type',
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
