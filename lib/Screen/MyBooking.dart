import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ho_jayega_user_main/Helper/api.path.dart';
import 'package:ho_jayega_user_main/Helper/color.dart';
import 'package:ho_jayega_user_main/Model/bookingHistoryModel.dart';
import 'package:ho_jayega_user_main/Screen/bookingDetail.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({Key? key}) : super(key: key);

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  int selected = 0;
  List<String> productName = [
    "Veika P&D Service",
    "Rb Saloon",
    "Siya Saloon",
    "Vedik Toys"
  ];
  List<String> imageList = [
    "assets/images/icon3.png",
    "assets/images/icon3.png",
    "assets/images/icon3.png",
    "assets/images/icon3.png"
  ];
  BookingModel? booking;
  List<BookingData> history = [];
  Future<void> getBookings() async {
    try {
      history.clear();
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? user_id = sharedPreferences.getString('user_id');
      var headers = {
        'Cookie': 'ci_session=1166c4500493c8d13e3b858a50517268fd9b97f4'
      };
      var request =
          http.MultipartRequest('POST', Uri.parse(ApiServicves.bookingHistory));
      request.fields.addAll({'user_id': user_id.toString()});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var json = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        log(json.toString());
        booking = BookingModel.fromJson(json);
        history = booking!.data;
        print("booking : ${history.length}");
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
    myFuture = getBookings();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffE2EBFE), //colors.bgColor,
        body: Center(
          child: FutureBuilder(
              future: myFuture,
              builder: (context, snap) {
                return snap.connectionState == ConnectionState.waiting
                    ? CircularProgressIndicator()
                    : history.isEmpty
                        ? Center(
                            child: Text("No Bookings Found", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'My Booking History',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      itemCount: history.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () =>
                                              Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BookingDetail(
                                                      history: history[index]),
                                            ),
                                          ),
                                          child: Container(
                                            height: 120,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        image: DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: NetworkImage(
                                                                history[index]
                                                                    .shopImage
                                                                    .toString()))),
                                                    padding: EdgeInsets.all(8),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          history[index]
                                                              .vendorName
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.pin_drop,
                                                              color: Colors.red,
                                                              size: 16,
                                                            ),
                                                            Text(
                                                              history[index]
                                                                  .vendorAddress
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          '₹ ${history[index].bookingAmount.toString()}',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                DateFormat(
                                                                        "yMMMd")
                                                                    .format(DateTime.parse(history[
                                                                            index]
                                                                        .date
                                                                        .toString())),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                              Text(
                                                                history[index]
                                                                    .status
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  color: colors
                                                                      .primary,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return Divider(
                                          color: Colors.transparent,
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ]),
                          );
              }),
        ),
      ),
    );
  }
}
