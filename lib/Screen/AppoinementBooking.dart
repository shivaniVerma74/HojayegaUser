import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ho_jayega_user_main/Helper/api.path.dart';
import 'package:ho_jayega_user_main/Screen/ServicePayment.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import '../Helper/color.dart';
import 'ConfirmService.dart';

class AppointmentBooking extends StatefulWidget {
  @override
  final String amount;
  final String vendor_id;

  const AppointmentBooking(
      {super.key, required this.amount, required this.vendor_id});
  _MyTimePickerState createState() => _MyTimePickerState();
}

class _MyTimePickerState extends State<AppointmentBooking> {
  TimeOfDay? _selectedTime;
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  DateTime? _selectedDay;
  int? _selectedYear;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedYear = _focusedDay.year;
    _calendarFormat = CalendarFormat.month;
    _selectedDay = _focusedDay;
    getBookingCalender();
  }

  List<DropdownMenuItem<int>> _getYearDropdownItems() {
    List<DropdownMenuItem<int>> items = [];
    for (int year = 2010; year <= 2040; year++) {
      items.add(DropdownMenuItem(
        value: year,
        child: Text(year.toString()),
      ));
    }
    return items;
  }

  void _onYearChanged(int? newYear) {
    if (newYear != null) {
      setState(() {
        _selectedYear = newYear;
        _focusedDay = DateTime(newYear, _focusedDay.month, _focusedDay.day);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
      });
  }

  bool _isWeekend(DateTime day) {
    print(booking.contains(DateFormat('yyyy-MM-dd').format(day)));
    return booking.contains(DateFormat('yyyy-MM-dd').format(day));
  }

  List<String> booking = [];
  Future<void> getBookingCalender() async {
    try {
      var headers = {
        'Cookie': 'ci_session=116d327988b3013ef7dc4a036296ab9415419cb0'
      };
      var request =
          http.MultipartRequest('POST', Uri.parse(ApiServicves.getCalender));
      request.fields.addAll({'vendor_id': widget.vendor_id});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var json = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        print(json);
        setState(() {
          booking = json['booking'].cast<String>();
          print("Length: ${booking.length}");
        });
      } else {
        print(response.reasonPhrase);
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.appbarColor,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: colors.primary,
          foregroundColor: Colors.white,
          title: const Text('Appointment Booking'),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 2, right: 2, top: 10),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Time : ",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Card(
                          child: Container(
                            width: 210,
                            height: 40,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _selectedTime != null
                                        ? _selectedTime!.format(context)
                                        : '',
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        _selectTime(context);
                                      },
                                      child: Icon(Icons.access_time))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 21),
                      child: Row(
                        children: const [
                          Text(
                            "Calender :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Card(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 1.6,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                border: Border.all(color: colors.primary)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DateTime.now().year.toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TableCalendar(
                                    firstDay: DateTime.now(),
                                    lastDay: DateTime.utc(2040, 12, 31),
                                    focusedDay: _focusedDay,
                                    calendarFormat: CalendarFormat.month,
                                    headerStyle: HeaderStyle(
                                        formatButtonVisible: false,
                                        titleCentered: true),
                                    selectedDayPredicate: (day) {
                                      return isSameDay(_selectedDay, day);
                                    },
                                    calendarStyle: CalendarStyle(
                                        disabledDecoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey.shade200)),
                                    enabledDayPredicate: (day) =>
                                        !_isWeekend(day),
                                    onDaySelected: (selectedDay, focusedDay) {
                                      if (!isSameDay(
                                          _selectedDay, selectedDay)) {
                                        setState(() {
                                          _selectedDay = selectedDay;
                                          _focusedDay = focusedDay;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 5),
                      child: Card(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              border: Border.all(color: colors.primary)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Row(
                              children: const [
                                Center(
                                  child: Text(
                                    "Note ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11),
                                  ),
                                ),
                                Text(
                                  "I want to get it don't before 6:00. have to go to party",
                                  style: TextStyle(fontSize: 11),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServicePayment(
                                      amount: widget.amount,
                                      selectedDate: _selectedDay!,
                                      vendor_id: widget.vendor_id,
                                    )));
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Card(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: colors.secondary,
                            ),
                            child: const Center(
                              child: Text(
                                "Payment",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
