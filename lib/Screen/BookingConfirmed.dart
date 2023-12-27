import 'package:flutter/material.dart';

import '../Helper/btn.dart';
import '../Helper/color.dart';

class BookingConfirmed extends StatefulWidget {
  const BookingConfirmed({Key? key}) : super(key: key);

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
        leading: InkWell(
          onTap: () {
            //   Navigator.pop(context, false);
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.1,
              // ),
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                child: Image(image: AssetImage('assets/images/Group75302.png')),
              ),
              Text(
                "Congratulations!",
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
                style: TextStyle(
                  fontSize: 14,
                    // fontWeight: FontWeight.bold,
                  color: Color(0xFF100F0F),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.13),
                child: FilledBtn(
                  title: 'Got It',
                  onPress: () {
                    // Navigator.push(
                    //                  context,
                    //                  MaterialPageRoute(
                    //                      builder: (context) => const personal_information()),
                    //                );
                  },
                ),
              )
            ]
        ),
      ),
    );
  }
}