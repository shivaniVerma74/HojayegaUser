import 'package:flutter/material.dart';

import '../Helper/btn.dart';
import '../Helper/color.dart';

class PaymentSuccessful extends StatefulWidget {
  const PaymentSuccessful({Key? key}) : super(key: key);

  @override
  State<PaymentSuccessful> createState() => _PaymentSuccessfulState();
}

class _PaymentSuccessfulState extends State<PaymentSuccessful> {
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
          //child: Container(
          //   margin: EdgeInsets.all(10),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(5),
          //     gradient: LinearGradient(
          //         begin: Alignment.bottomLeft,
          //         end: Alignment.topRight,
          //         colors: [colors.primary, colors.secondary, colors.secondary]),
          //   ),
          // padding: EdgeInsets.all(5),
          // child: Icon(Icons.arrow_back),
          //  ),
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
              //  SizedBox(
              //    height: 5,
              //  ),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.25,
              //   width: MediaQuery.of(context).size.width,
              //   child: Image(image: AssetImage('assets/images/Group75302.png')),
              // ),
              // SizedBox(
              //   height: 5,
              // ),
              Text(
                "Thankyou Payment Successful",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colors.primary),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Lorem ipsum dolor sit amet consectetuer elit, sed diam Lorem ipsum dolor sit amet, consectetuer elit, sed diam",
                style: TextStyle(
                  fontSize: 16,
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
                  title: 'Done',
                  onPress: () {
                    // Navigator.push(
                    //                  context,
                    //                  MaterialPageRoute(
                    //                      builder: (context) => const personal_information()),
                    //                );
                  },
                ),
              )
            ]),
      ),
    );
  }
}
