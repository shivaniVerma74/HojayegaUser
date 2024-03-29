import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ho_jayega_user_main/Model/VendorChargeModel.dart';
import 'package:ho_jayega_user_main/Model/timeSlotCharge.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../AuthView/loginPage.dart';
import '../Helper/api.path.dart';
import '../Helper/appBar.dart';
import '../Helper/color.dart';
import '../Model/getAddress.dart';
import '../Model/getCartListModel.dart';
import '../Model/getTimeSlotModel.dart';
import 'OrderListing.dart';
import 'address/updateAddress.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int _counter = 1;

  void _incrementCounter(String qty, String vendoridd, String productId) {
    setState(() {
      _counter = int.parse(qty);
      _counter++;
    });
    addTocart(vendoridd, _counter.toString(), productId);
  }

  void _descrementerCounter(String qty, String vendoridd, String productId) {
    setState(() {
      _counter = int.parse(qty);
    });
    if (_counter > 1) {
      setState(() {
        _counter--;
      });
      addTocart(vendoridd, _counter.toString(), productId);
    }
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.appbarColor,

        body: !isLoading
            ? RefreshIndicator(
                onRefresh: () async {
                  getCrt();
                  getAddress();
                },
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 15, bottom: 15),
                          child: Image.asset("assets/images/demo1.png"),
                        ),
                        InkWell(
                          onTap: () {
                            if (getCatList.isEmpty) {
                              Fluttertoast.showToast(
                                  msg:
                                      "Product Not Available In Cart Please Add Product In Cart");
                            } else if (addressids == null) {
                              Fluttertoast.showToast(
                                  msg: "Plaese Select Address");
                            } else if (timefrom == null) {
                              Fluttertoast.showToast(
                                  msg: "Plaese Select Time Slot");
                            } else if (selectedVehicle == null) {
                              Fluttertoast.showToast(
                                  msg: "Plaese Select Vehicle Type");
                            } else if (selectOrders == null) {
                              Fluttertoast.showToast(
                                  msg: "Plaese Select Order Type");
                            } else {
                              placeorder().then((value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderListing(),
                                  )));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 1.5,
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
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 15, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Address",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                              Text("",
                                  style: TextStyle(
                                      fontSize: 1, fontWeight: FontWeight.w400))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          child: Column(
                            children: [
                              getAddressList.isNotEmpty
                                  ? Column(
                                      children: [
                                        Row(
                                          children: [
                                            Spacer(),
                                            InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            UpdateAddress(),
                                                      ));
                                                },
                                                child: Text(
                                                  "Manage Address",
                                                  style: TextStyle(
                                                      color: colors.secondary,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    )
                                  : SizedBox.shrink(),
                              getAddressList.isNotEmpty
                                  ? DropdownButtonFormField<dynamic>(
                                      value: selectaddress,
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        color: colors.primary,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectaddress = newValue;
                                          addressids = newValue.id.toString();
                                          print(
                                              "===my technic=======${selectaddress.id}===============");
                                        });
                                      },
                                      items: getAddressList
                                          .map((dynamic orderitem) {
                                        return DropdownMenuItem(
                                          value: orderitem,
                                          child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.5,
                                              child: Text(
                                                orderitem.address.toString(),
                                                style: const TextStyle(
                                                    color: colors.secondary),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              )),
                                        );
                                      }).toList(),
                                      decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(10),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          hintText: 'Select Address',
                                          hintStyle:
                                              TextStyle(color: colors.primary),
                                          filled: true,
                                          fillColor: Colors.white),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateAddress(),
                                            ));
                                      },
                                      child: Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: colors.primary),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.1,
                                        child: Card(
                                            color: colors.primary,
                                            elevation: 2,
                                            child: Row(
                                              children: const [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Tab To Add Address",
                                                  style: TextStyle(
                                                    color: colors.whiteTemp,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Spacer(),
                                                Icon(
                                                  Icons
                                                      .location_searching_sharp,
                                                  color: colors.whiteTemp,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                              ],
                                            )),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 15, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Cart Products",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                              Text("",
                                  style: TextStyle(
                                      fontSize: 1, fontWeight: FontWeight.w400))
                            ],
                          ),
                        ),
                        getCatList.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: getCatList.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: 120,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.1,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 120,
                                                width: 110,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            '${getCatList[index].productImage}'),
                                                        fit: BoxFit.fill)),
                                              ),
                                            ),
                                            // Image.network("${getCatList[index].productImage}", height: 90, width: 90),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${getCatList[index].productName}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                    color: colors.primary,
                                                  ),
                                                  height: 30,
                                                  width: 100,
                                                  child: Center(
                                                    child: Text(
                                                      "\u{20B9} ${getCatList[index].price}/-",
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              colors.whiteTemp),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 10,
                                            bottom: 9),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  _descrementerCounter(
                                                      getCatList[index]
                                                              .quantity ??
                                                          "",
                                                      getCatList[index]
                                                              .vendorId ??
                                                          "",
                                                      getCatList[index]
                                                              .productId ??
                                                          "");
                                                },
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: Colors.black,
                                                  size: 30,
                                                )),
                                            Text(
                                              "${getCatList[index].quantity}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  _incrementCounter(
                                                      getCatList[index]
                                                              .quantity ??
                                                          "",
                                                      getCatList[index]
                                                              .vendorId ??
                                                          "",
                                                      getCatList[index]
                                                              .productId ??
                                                          "");
                                                },
                                                child: const Icon(Icons.add,
                                                    color: Colors.black,
                                                    size: 30)),
                                            InkWell(
                                              onTap: () {
                                                deletePopop(
                                                    getCatList[index].cartId ??
                                                        "");
                                              },
                                              child: Container(
                                                height: 45,
                                                width: 140,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.white),
                                                child: const Center(
                                                    child: Text("Delete",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400))),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              )
                            : Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                child: const Center(
                                  child: Text(
                                      'Product Not Found Please Add Product In Cart'),
                                )),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 15, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Time Slot",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                              Text("",
                                  style: TextStyle(
                                      fontSize: 1, fontWeight: FontWeight.w400))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: DropdownButtonFormField<dynamic>(
                            value: selectTimeslot,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: colors.primary,
                            ),
                            onChanged: (dynamic newValue) {
                              setState(() {
                                selectTimeslot = newValue;
                                timefrom =
                                    "From ${newValue.fromTime.toString()} To ${newValue.toTime.toString()}";
                                print(
                                    "===my technic=======$timefrom===============");
                                postTimeSlot(
                                    newValue.fromTime, newValue.toTime);
                              });
                            },
                            items: timeSlot.map((dynamic orderitem) {
                              return DropdownMenuItem(
                                value: orderitem,
                                child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: Text(
                                      "From ${orderitem.fromTime.toString()} To ${orderitem.toTime.toString()}",
                                      style: const TextStyle(
                                          color: colors.secondary),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    )),
                              );
                            }).toList(),
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                hintText: 'Select Time Slot',
                                hintStyle: TextStyle(color: colors.primary),
                                filled: true,
                                fillColor: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 15, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Product Type",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                              Text("",
                                  style: TextStyle(
                                      fontSize: 1, fontWeight: FontWeight.w400))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: DropdownButtonFormField<String>(
                            value: selectOrders,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: colors.primary,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectOrders = newValue!;
                                print(
                                    "===my technic=======$selectOrders===============");
                              });
                            },
                            items: orderitem.map((String orderitem) {
                              return DropdownMenuItem(
                                value: orderitem,
                                child: Text(
                                  orderitem.toString(),
                                  style:
                                      const TextStyle(color: colors.secondary),
                                ),
                              );
                            }).toList(),
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                hintText: 'Select Product Type',
                                hintStyle: TextStyle(color: colors.primary),
                                filled: true,
                                fillColor: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 15, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Order Type",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                              Text("",
                                  style: TextStyle(
                                      fontSize: 1, fontWeight: FontWeight.w400))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: DropdownButtonFormField<String>(
                            value: selectproducts,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: colors.primary,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectproducts = newValue!;
                                print(
                                    "===my technic=======$selectOrders===============");
                              });
                            },
                            items: productitem.map((String orderitem) {
                              return DropdownMenuItem(
                                value: orderitem,
                                child: Text(
                                  orderitem.toString(),
                                  style:
                                      const TextStyle(color: colors.secondary),
                                ),
                              );
                            }).toList(),
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                hintText: 'Select Order Type',
                                hintStyle: TextStyle(color: colors.primary),
                                filled: true,
                                fillColor: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 15, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Vehicle Type",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                              Text("",
                                  style: TextStyle(
                                      fontSize: 1, fontWeight: FontWeight.w400))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: DropdownButtonFormField<String>(
                            value: selectedVehicle,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: colors.primary,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedVehicle = newValue!;
                                print(
                                    "===my technic=======${selectedVehicle}===============");
                                getDeliveryCharges(
                                    vType: selectedVehicle.toString());
                              });
                            },
                            items: vehicleItem.map((String orderitem) {
                              return DropdownMenuItem(
                                value: orderitem,
                                child: Text(
                                  orderitem.toString(),
                                  style: TextStyle(color: colors.secondary),
                                ),
                              );
                            }).toList(),
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                hintText: 'Select Vehicle Type',
                                hintStyle: TextStyle(color: colors.primary),
                                filled: true,
                                fillColor: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Delivery Charges  : $DeliveryCharge",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       left: 15, right: 15, top: 15, bottom: 15),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: const [
                        //       Text("Vehicle Type",
                        //           style: TextStyle(
                        //               fontSize: 17,
                        //               fontWeight: FontWeight.bold)),
                        //       Text("",
                        //           style: TextStyle(
                        //               fontSize: 1, fontWeight: FontWeight.w400))
                        //     ],
                        //   ),
                        // ),

                        // SizedBox(
                        //   height: 20,
                        // ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     InkWell(
                        //       onTap: () {
                        //         setState(() {
                        //           selectBike = 1;
                        //         });
                        //       },
                        //       child: Row(
                        //         children: [
                        //           Container(
                        //             height: 20,
                        //             width: 20,
                        //             decoration: BoxDecoration(
                        //                 border:
                        //                     Border.all(color: colors.primary)),
                        //             child: Center(
                        //                 child: selectBike == 1
                        //                     ? const Icon(
                        //                         Icons.check,
                        //                         color: colors.primary,
                        //                         size: 15,
                        //                       )
                        //                     : SizedBox.shrink()),
                        //           ),
                        //           const SizedBox(
                        //             width: 10,
                        //           ),
                        //           Container(
                        //             height: 30,
                        //             width: 30,
                        //             decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(3),
                        //                 image: const DecorationImage(
                        //                     image: AssetImage(
                        //                         "assets/images/cycling.png"),
                        //                     fit: BoxFit.fill)),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //     InkWell(
                        //       onTap: () {
                        //         setState(() {
                        //           selectBike = 2;
                        //         });
                        //       },
                        //       child: Row(
                        //         children: [
                        //           Container(
                        //             height: 20,
                        //             width: 20,
                        //             decoration: BoxDecoration(
                        //                 border:
                        //                     Border.all(color: colors.primary)),
                        //             child: Center(
                        //                 child: selectBike == 2
                        //                     ? const Icon(
                        //                         Icons.check,
                        //                         color: colors.primary,
                        //                         size: 15,
                        //                       )
                        //                     : SizedBox.shrink()),
                        //           ),
                        //           const SizedBox(
                        //             width: 10,
                        //           ),
                        //           Container(
                        //             height: 30,
                        //             width: 30,
                        //             decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(3),
                        //                 image: const DecorationImage(
                        //                     image: AssetImage(
                        //                         "assets/images/bike.png"),
                        //                     fit: BoxFit.fill)),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        // const SizedBox(
                        //   height: 10,
                        // ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     InkWell(
                        //       onTap: () {
                        //         setState(() {
                        //           selectBike = 3;
                        //         });
                        //       },
                        //       child: Row(
                        //         children: [
                        //           Container(
                        //             height: 20,
                        //             width: 20,
                        //             decoration: BoxDecoration(
                        //                 border:
                        //                     Border.all(color: colors.primary)),
                        //             child: Center(
                        //                 child: selectBike == 3
                        //                     ? const Icon(
                        //                         Icons.check,
                        //                         color: colors.primary,
                        //                         size: 15,
                        //                       )
                        //                     : const SizedBox.shrink()),
                        //           ),
                        //           const SizedBox(
                        //             width: 10,
                        //           ),
                        //           Container(
                        //             height: 30,
                        //             width: 30,
                        //             decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(3),
                        //                 image: const DecorationImage(
                        //                     image: AssetImage(
                        //                         "assets/images/AUTO - Copy.png"),
                        //                     fit: BoxFit.fill)),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //     InkWell(
                        //       onTap: () {
                        //         setState(() {
                        //           selectBike = 4;
                        //         });
                        //       },
                        //       child: Row(
                        //         children: [
                        //           Container(
                        //             height: 20,
                        //             width: 20,
                        //             decoration: BoxDecoration(
                        //                 border:
                        //                     Border.all(color: colors.primary)),
                        //             child: Center(
                        //                 child: selectBike == 4
                        //                     ? const Icon(
                        //                         Icons.check,
                        //                         color: colors.primary,
                        //                         size: 15,
                        //                       )
                        //                     : SizedBox.shrink()),
                        //           ),
                        //           const SizedBox(
                        //             width: 10,
                        //           ),
                        //           Container(
                        //             height: 30,
                        //             width: 30,
                        //             decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(3),
                        //                 image: const DecorationImage(
                        //                     image: AssetImage(
                        //                         "assets/images/TRUCK - Copy.png"),
                        //                     fit: BoxFit.fill)),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        // selectBike == 2
                        //     ? Column(
                        //         children: [
                        //           const SizedBox(
                        //             height: 20,
                        //           ),
                        //           Container(
                        //             decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(10),
                        //                 color: colors.primary),
                        //             width:
                        //                 MediaQuery.of(context).size.width / 1.1,
                        //             child: Card(
                        //               color: colors.primary,
                        //               elevation: 2,
                        //               child: DropdownButtonFormField<String>(
                        //                 value: selectBikeType,
                        //                 icon: const Icon(
                        //                   Icons.keyboard_arrow_down_sharp,
                        //                   color: colors.whiteTemp,
                        //                 ),
                        //                 onChanged: (String? newValue) {
                        //                   setState(() {
                        //                     selectBikeType = newValue!;
                        //                     print(
                        //                         "===my technic=======$selectBikeType===============");
                        //                   });
                        //                 },
                        //                 items: bikeType.map((String orderitem) {
                        //                   return DropdownMenuItem(
                        //                     value: orderitem,
                        //                     child: Text(
                        //                       orderitem.toString(),
                        //                       style: const TextStyle(
                        //                           color: colors.secondary),
                        //                     ),
                        //                   );
                        //                 }).toList(),
                        //                 decoration: const InputDecoration(
                        //                   border: InputBorder.none,
                        //                   hintText: 'Select Bike Type',
                        //                   hintStyle:
                        //                       TextStyle(color: Colors.white),
                        //                   filled: true,
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       )
                        //     : SizedBox.shrink(),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                      ],
                    );
                  },
                ),
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: colors.primary,
                  ),
                ),
              ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getVendorCharge();
    getCrt();
    getAddress();
    getTimeSlot();
  }

  bool isLoading = false;
  GetCartListModel? cartListModel;
  GetCartListModel? getCartListModel;
  List<CarLlist> getCatList = [];
  Future<void> getCrt() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? user_id = sharedPreferences.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=c04e75c159340234a52f1542713ceee8c56b6e38'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiServicves.baseUrl}get_cart_items'));
    request.fields.addAll({
      'user_id': user_id.toString(),
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("===my technic=======${request.url}===============");
    print("===my technic=======${request.fields}===============");
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);
      if (finalresult['response_code'] == '1') {
        setState(() {
          roductsIds = null;
          productsQty = null;
          productqtyy.clear();
          productidss.clear();
        });
        cartListModel = GetCartListModel.fromJson(finalresult);
        getCatList = GetCartListModel.fromJson(finalresult).cart ?? [];
        for (int i = 0; i < getCatList.length; i++) {
          productidss.add(getCatList[i].productId.toString());
          productsQty = productqtyy.join(" ,");
          roductsIds = productidss.join(" ,");
          print("===my technic=======$productsQty===============");
          print("===my technic=======$roductsIds===============");
          setState(() {});
        }

        setState(() {
          isLoading = false;
        });
      } else {
        getCatList.clear();

        setState(() {
          isLoading = false;
        });
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => BottomNavBar()),
        //         (Route<dynamic> route) => false);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> removeCrt(String cartIDD) async {
    setState(() {
      isLoading = true;
    });

    var headers = {
      'Cookie': 'ci_session=c04e75c159340234a52f1542713ceee8c56b6e38'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiServicves.baseUrl}remove_cart_items'));
    request.fields.addAll({
      'cart_id': cartIDD.toString(),
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("===my technic=======${request.url}===============");
    print("===my technic=======${request.fields}===============");
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);
      if (finalresult['response_code'] == '1') {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "${finalresult['message']}");
        Navigator.pop(context);
        getCrt();
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> addTocart(
    String vendorId,
    String quantity,
    String productId,
  ) async {
    setState(() {
      isLoading = true;
    });

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? user_id = sharedPreferences.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=d09fc39a8b8a97b07417a28e972b458e44a87757'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiServicves.baseUrl}add_to_cart'));

    request.fields.addAll({
      'user_id': user_id.toString(),
      'product_id': productId.toString(),
      'quantity': quantity.toString(),
      'vendor_id': vendorId.toString()
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("===my technic=======${request.fields}===============");
    print("===my technic=======${request.url}===============");
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);

      if (finalresult['response_code'] == "1") {
        getCrt();
        setState(() {
          isLoading = false;
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  List<AddressList> getAddressList = [];
  getAddress() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? user_id = sharedPreferences.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=8337986a2b6d2140aa0b9f8e468d4183e289f1ac'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getAddress));
    request.fields.addAll({
      'user_id': user_id.toString(),
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("===my technic=======${request.url}===============");
    print("===my technic=======${request.fields}===============");
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);
      if (finalresult['response_code'] == "1") {
        getAddressList = GetAddressModel.fromJson(finalresult).data ?? [];
        setState(() {});
      } else {
        getAddressList.clear();
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  dynamic selectaddress;

  var roductsIds;
  var productsQty;
  var addressids;
  var vendoriddd;

  // placeproduct() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String? user_id = sharedPreferences.getString('user_id');
  //   String? mobile = sharedPreferences.getString('mobile');
  //   var headers = {
  //     'Cookie': 'ci_session=c4664ff6d31ce6221e37b407dfcd60d4e14b6df3'
  //   };
  //   var request =
  //       http.MultipartRequest('POST', Uri.parse(ApiServicves.placeOrder));
  //   request.fields.addAll({
  //     'product_id': roductsIds.toString(),
  //     'qty': productsQty.toString(),
  //     'user_id': user_id.toString(),
  //     'total': cartListModel?.cartTotal.toString() ?? "",
  //     'mobile_no': mobile.toString(),
  //     'address_id': addressids.toString(),
  //     'vendor_id': vendoriddd.toString(),
  //     'time': timefrom.toString(),
  //     'vehicle_type': selectwhehicle.toString(),
  //     'order_type': selectOrders.toString(),
  //   });

  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();
  //   print("===my technic=======${request.fields}===============");
  //   print("===my technic=======${request.url}===============");

  //   if (response.statusCode == 200) {
  //     var result = await response.stream.bytesToString();
  //     var finalresult = jsonDecode(result);
  //     if (finalresult['status'] == true) {
  //       Fluttertoast.showToast(msg: "${finalresult['message']}");
  //       Navigator.pushReplacement(context,
  //           MaterialPageRoute(builder: (context) => const OrderListing()));

  //       getCrt();
  //     } else {
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }

  List<String> productqtyy = [];
  List<String> productidss = [];
  String? selectOrders;
  String? selectproducts;
  String? selectedVehicle;
  var productitem = ['Urgent', 'Cake', 'Schedule'];
  var orderitem = [
    'Food',
    'Non-Food',
    'Fragile',
    'Flexible',
  ];
  var vehicleItem = [
    'Bike',
    'Electric',
    'Car',
    'Taxi',
    'Truck',
  ];
  var selectBikeType;
  var bikeType = [
    'Electric',
    'Non-Electric',
  ];

  String? selectwhehicle;

  dynamic selectTimeslot;
  var timefrom;
  List<TimeSlotListBooking> timeSlot = [];
  Future<void> getTimeSlot() async {
    var headers = {
      'Cookie': 'ci_session=c4664ff6d31ce6221e37b407dfcd60d4e14b6df3'
    };
    var request = http.Request('POST', Uri.parse(ApiServicves.getTimeSlot));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);
      if (finalresult['status'] == 1) {
        timeSlot = GetTimeSlotModel.fromJson(finalresult).booking ?? [];
        setState(() {});
      } else {
        timeSlot.clear();
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  double DeliveryCharge = 0.0;
  TimeSlotCharge? timeSlotCharge;
  Future<void> postTimeSlot(String From, String To) async {
    try {
      var headers = {
        'Cookie': 'ci_session=3dd81342c44673bc84efdf68651659a03a3dd551'
      };
      print("Api calling");

      var url = Uri.parse(
          'https://developmentalphawizz.com/hojayega/api/get_delivery_chargess');
      http.Response request = await http.post(url,
          body: {
            'type': 'time',
            'start_time': From,
            'end_time': To,
          },
          headers: headers);
      var json = jsonDecode(request.body);
      if (request.statusCode == 200) {
        timeSlotCharge = TimeSlotCharge.fromJson(json);
        print(timeSlotCharge!.data?.price);
        setState(() {
          DeliveryCharge = double.parse(timeSlotCharge!.data!.price.toString());
          print(DeliveryCharge);
        });
      }
    } catch (e, stackTrace) {
      print(stackTrace.toString());
      throw Exception(e);
    }
  }

  VendorChargeModel? vendorChargeModel;
  clickUsers(String? id) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? user_id = sharedPreferences.getString('user_id');
    setState(() {
      isLoading = true;
    });
    var headers = {
      'Cookie': 'ci_session=2f65386943e965abd9230c50aac897e712cc922d'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.clickUser));
    request.fields.addAll({
      'user_id': user_id.toString(),
      'amount': vendorCharge!.data.first.userSendBilling.toString(),
      'vendor_id': id.toString(),
      'type': 'Per Click User'
    });
    print("click user para ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      setState(() {
        isLoading = false;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> placeorder() async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? userId = sharedPreferences.getString('user_id');
      String? mobileNo = sharedPreferences.getString('mobile');
      var product_id = [];
      var qty = [];
      print("vendor: ${cartListModel!.cart.first.vendorId.toString()}");

      getCatList.forEach((element) {
        product_id.add(element.productId.toString());
        qty.add(element.quantity.toString());
        print('Naman $product_id');
      });

      var headers = {
        'Cookie': 'ci_session=03ee76b67ba18209673407bdac6cd1c4d79c67fc'
      };
      var body = {
        'product_id': product_id.join(','),
        'qty': qty.join(','),
        'user_id': userId.toString(),
        'total': cartListModel!.cartTotal.toString(),
        'mobile_no': mobileNo.toString(),
        'address_id': addressids.toString(),
        'vendor_id': cartListModel!.cart.first.vendorId.toString(),
        'time': 'From ${selectTimeslot.fromTime} To ${selectTimeslot.toTime}',
        'vehicle_type':
            (vehicleItem.indexOf(selectedVehicle.toString()) + 1).toString(),
        'order_type': selectOrders.toString(),
        'orders_type': 'One Way',
        'payment_method': 'COD',
        'delivery_charge': DeliveryCharge.toString(),
        'sub_total':
            (DeliveryCharge + double.parse(cartListModel!.cartTotal.toString()))
                .toString(),
        'product_type':
            (productitem.indexOf(selectproducts.toString()) + 1).toString(),
      };
      log(body.toString());
      var request = await http.post(
          Uri.parse(
              'https://developmentalphawizz.com/hojayega/api/place_order'),
          body: body,
          headers: headers);

      log(request.body);

      var json = jsonDecode(request.body);
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

  VendorChargeModel? vendorCharge;
  Future<void> getVendorCharge() async {
    try {
      var headers = {
        'Cookie': 'ci_session=b38b8356d54b7f4ba9b420c6fbd32ad1158f61bf'
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://developmentalphawizz.com/hojayega/api/vendor_charges'));
      request.fields.addAll({'vendor_id': '172'});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var json = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        print(json);
        vendorCharge = VendorChargeModel.fromJson(json);
        print("here");
        print(vendorCharge!.data.first.perClickUser);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> getDeliveryCharges({required String vType}) async {
    try {
      if (selectaddress == null) {
        setState(() {
          selectedVehicle = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please select address first")));
      } else {
        var headers = {
          'Cookie': 'ci_session=d1ee7a5c526c3bed48a3c246259b0c817b70d2f5'
        };
        var request = http.MultipartRequest(
            'POST',
            Uri.parse(
                'https://developmentalphawizz.com/hojayega/api/get_delivery_charge_distacee'));
        request.fields.addAll({
          'res_lat': cartListModel!.vendor!.lang.toString(),
          'res_lang': cartListModel!.vendor!.lat.toString(),
          'latitude': selectaddress.lat.toString(),
          'longitude': selectaddress.lng.toString(),
          'vehicle_type': (vehicleItem.indexOf(vType) + 1).toString()
        });
        print(request.fields);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();
        var json = jsonDecode(await response.stream.bytesToString());
        if (response.statusCode == 200) {
          print(json);
          setState(() {
            DeliveryCharge += double.parse(json['data'].toString());
          });
        } else {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void deletePopop(String OrderI) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm Delete"),
            content: const Text("Are you sure you want to Delete?"),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: colors.primary),
                child: const Text("YES"),
                onPressed: () {
                  removeCrt(OrderI);
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

  var selectBike;
}
