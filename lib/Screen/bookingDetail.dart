import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ho_jayega_user_main/Helper/api.path.dart';
import 'package:ho_jayega_user_main/Helper/appBar.dart';
import 'package:ho_jayega_user_main/Helper/color.dart';
import 'package:ho_jayega_user_main/Model/bookingAmountModel.dart';
import 'package:ho_jayega_user_main/Model/bookingHistoryModel.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class BookingDetail extends StatefulWidget {
  const BookingDetail({super.key, required this.history});
  final BookingData history;
  @override
  State<BookingDetail> createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  BookingAmountModel? bookingServices;
  Future<void> getAmountDetails() async {
    try {
      var headers = {
        'Cookie': 'ci_session=fa214b800ee0953d811b1f48a104f7642939a5ee'
      };
      var request =
          http.MultipartRequest('POST', Uri.parse(ApiServicves.bookingAmt));
      request.fields.addAll({'booking_id': '207'});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var json = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        log(json.toString());
        bookingServices = BookingAmountModel.fromJson(json);
        print(bookingServices!.data.length);
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
    myFuture = getAmountDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.appbarColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: commonAppBar(
            context,
            text: "Booking Detail",
            isHome: false,
          ),
        ),
        body: FutureBuilder(
            future: myFuture,
            builder: (context, snap) {
              return snap.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(widget
                                                .history.shopImage
                                                .toString()))),
                                    padding: EdgeInsets.all(8),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.history.vendorName.toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.pin_drop,
                                              color: Colors.red,
                                              size: 16,
                                            ),
                                            Text(
                                              widget.history.vendorAddress
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '₹ ${widget.history.bookingAmount.toString()}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                DateFormat("yMMMd").format(
                                                    DateTime.parse(widget
                                                        .history.date
                                                        .toString())),
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              Text(
                                                widget.history.status
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: colors.primary,
                                                  fontWeight: FontWeight.w500,
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
                          const Divider(color: Colors.transparent),
                          Text(
                            "Services Booked",
                            style: TextStyle(
                                fontSize: 16,
                                color: colors.primary,
                                fontWeight: FontWeight.w600),
                          ),
                          const Divider(color: Colors.transparent),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: colors.primary, width: 1)),
                              child: ListView.builder(
                                itemCount: bookingServices!.data.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        bookingServices!.data[index].serviceName
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "₹${bookingServices!.data[index].price.toString()} /-",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
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
