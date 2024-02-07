import 'package:flutter/material.dart';
import 'package:ho_jayega_user_main/Screen/bottomScreen.dart';
import 'package:ho_jayega_user_main/Screen/homePage.dart';
import 'package:intl/intl.dart';

import '../Helper/btn.dart';
import '../Helper/color.dart';

class BookingConfirmed extends StatefulWidget {
  const BookingConfirmed({Key? key, required this.date}) : super(key: key);
  final DateTime date;
  @override
  State<BookingConfirmed> createState() => _BookingConfirmedState();
}

class _BookingConfirmedState extends State<BookingConfirmed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.appbarColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
              child: Image(
                image: AssetImage('assets/images/Group75302.png'),
              ),
            ),
            Text(
              "Congratulations!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colors.primary),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Your Booking Confirmed",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                // fontWeight: FontWeight.bold,
                color: Color(0xFF100F0F),
              ),
            ),
            const Divider(color: Colors.transparent),
            Text(
              DateFormat('yMMMMd').format(widget.date).toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF100F0F),
              ),
            ),
            const Divider(color: Colors.transparent),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.13),
              child: FilledBtn(
                title: 'Got It',
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BottomNavBar()),
                  );
                },
              ),
            )
          ]),
    );
  }
}
