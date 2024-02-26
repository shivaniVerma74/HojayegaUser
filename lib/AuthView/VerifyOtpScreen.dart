import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';

import '../Screen/bottomScreen.dart';
import '../Screen/homePage.dart';
import 'CreateAccount.dart';
import 'forgetpassword.dart';

class VerifyOtp extends StatefulWidget {
  bool? forget;
  final OTP;

  VerifyOtp({super.key, this.OTP, this.forget, this.userid});
  String? userid;
  @override
  State<VerifyOtp> createState() => _OtpState();
}

class _OtpState extends State<VerifyOtp> {
  final _formKey = GlobalKey<FormState>();

  var pin = TextEditingController();
  var otp;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: const Color(0xFF112C48),
        border: Border.all(color: const Color(0xFF112C48)),
        borderRadius: BorderRadius.circular(6),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color(0xFF112C48)),
      borderRadius: BorderRadius.circular(6),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color(0xFF112C48),
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image.asset(
                        'assets/images/otp verification – 3.png',
                      ),
                    )),
              ],
            ),
            const Form(
              child: Positioned(
                  top: 30,
                  left: 20,
                  child: Text('OTP verification',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
            ),
            const Positioned(
                top: 80,
                left: 20,
                right: 20,
                child: Text(
                    'Please enter received VerifyOtp on your mobile number to continue.',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
            Positioned(
                top: 150,
                left: 50,
                right: 50,
                child: Image.asset("assets/images/OTP VERIFICATION.png",
                    scale: 1.4)),
            const SizedBox(
              height: 50,
            ),
            Positioned(
              top: 400,
              bottom: 130,
              left: 20,
              right: 20,
              child: Container(
                // margin: EdgeInsets.fromLTRB(20, 400, 20, 150),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "OTP: ${widget.OTP}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                      child: SizedBox(
                        width: 250,
                        child: Form(
                          key: _formKey,
                          child: Pinput(
                            controller: pin,
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: focusedPinTheme,
                            submittedPinTheme: submittedPinTheme,
                            validator: (s) {
                              setState(() {
                                otp = s.toString();
                              });
                              return otp == null
                                  ? 'Please Fill OTP Fields'
                                  : otp != '${widget.OTP}'
                                      ? 'Please Enter Correct OTP'
                                      : null;
                            },
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            onCompleted: (pin) => debugPrint('enter pin'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 45,
                      width: 250,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (widget.forget == true) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgetPassword(
                                            userId: widget.userid.toString(),
                                          )));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CreateAccount()));
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        child: const Text('Verify'),
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
