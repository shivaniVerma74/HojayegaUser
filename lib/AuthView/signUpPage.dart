import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ho_jayega_user_main/AuthView/loginPage.dart';
import 'package:ho_jayega_user_main/Helper/color.dart';
import '../Helper/api.path.dart';
import 'VerifyOtpScreen.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  bool? forget;
  SignUp({super.key, this.forget});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  bool isChecked = false;
  bool isVisible = false;

  // String? _validateEmail(value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please Enter Your Email/Phone Number';
  //   }
  //   return null;
  // }
  //
  // bool isValidEmail(String email) {
  //   // Simple email validation using a regular expression
  //   // You can customize the regular expression based on your requirements
  //   final emailRegex =
  //       RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  //   return emailRegex.hasMatch(email);
  // }

  sendOtp() async {
    var request;
    var headers = {
      'Cookie': 'ci_session=05bf1731f8a5f6bc9d9143b990a080085dfb8659'
    };
    if (widget.forget == true) {
      request = http.MultipartRequest(
          'POST', Uri.parse(ApiServicves.sendOtpforgetpassword));
    } else {
      request = http.MultipartRequest('POST', Uri.parse(ApiServicves.sendOtp));
    }

    request.fields.addAll({'identity': email.text});
    print("send otp parameter ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("===my technic=======${request.url}===============");
    print("===my technic=======${request.fields}===============");
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finaResult = jsonDecode(result);
      print("resonse ${finaResult}");

      if (widget.forget == true) {
        if (finaResult['status'] == 1) {
          int otp = finaResult['otp'];
          String userId = finaResult['user_id'];
          print('____otp___${otp}___');
          Fluttertoast.showToast(msg: '${finaResult['msg']}');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => VerifyOtp(
                        OTP: otp.toString(),
                        forget: widget.forget,
                        userid: userId.toString(),
                      )));
        } else {
          Fluttertoast.showToast(msg: "${finaResult['msg']}");
        }
      } else {
        if (finaResult['error'] == false) {
          int otp = finaResult['otp'];
          String mobile = finaResult['identity'];
          print('____otp___${otp}___');
          Fluttertoast.showToast(msg: '${finaResult['message']}');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => VerifyOtp(
                        OTP: otp.toString(),
                        forget: widget.forget,
                      )));
        } else {
          Fluttertoast.showToast(msg: "${finaResult['message']}");
        }
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  bool validateMobile(String value) {
    String pattern = r'^[0-9]{10}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
  bool validateEmail(String value) {
    String pattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image.asset(
                        'assets/images/otp verification – 3.png',
                      ),
                    )),
              ],
            ),
            widget.forget == true
                ? Positioned(
                    top: 20,
                    left: 20,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: colors.backColor),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back,
                                color: colors.primary,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : SizedBox.shrink(),
            Positioned(
              top: widget.forget == true ? 65 : 30,
              left: 20,
              child: widget.forget == true
                  ? Text('Forgot Password',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))
                  : Text('Sign Up',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
            ),
            widget.forget == true
                ? SizedBox.shrink()
                : Positioned(
                    top: 120,
                    left: 20,
                    child: Text('Mobile verification',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.white))),
            Positioned(
                top: widget.forget == true ? 105 : 80,
                left: 20,
                right: 20,
                child: widget.forget == true
                    ? Text(
                        'Please enter mobile number you are registered with to receive OTP to reset password.',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))
                    : Text(
                        'Please enter your valid mobile number to receive OTP for further registration process..',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
            Positioned(
                top: MediaQuery.of(context).size.height / 6,
                left: 50,
                right: 50,
                child: Image.asset("assets/images/SIGN UP.png", scale: 2)),
            widget.forget == true
                ? SizedBox.shrink()
                : Positioned(
                    bottom: 35,
                    left: 65,
                    // right: 50,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          const Text("Already registered ?",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                          TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
                              },
                              child: const Text('Login',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.green))),
                        ],
                      ),
                    ),
                  ),
            Positioned(
              top: 330,
              bottom: 200,
              left: 20,
              right: 20,
              child: Container(
                // margin: EdgeInsets.fromLTRB(20, 400, 20, 150),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                        child: Row(
                          children: [
                            Card(
                              elevation: 5,
                              child: Container(
                                  height: 40,
                                  color: Colors.white,
                                  child: Image.asset(
                                    "assets/images/email.png",
                                    height: 20,
                                  )
                                  // Icon(Icons.phone, size: 48,
                                  //   color: Colors.green,),
                                  ),
                            ),
                            Expanded(
                              child: Card(
                                elevation: 5,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty || value == "") {
                                      return 'Mobile number or Email is required';
                                    }
                                    else if(isNumeric(value)){
                                      if (!validateMobile(value)) {
                                        return 'Invalid Mobile Number';
                                      }
                                    }else{
                                      if(!validateEmail(value)){
                                        return 'Invalid Email';
                                      }
                                    }
                                    return null;
                                  },
                                  controller: email,
                                  // keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintText: "Email/Phone Number",
                                    isDense: true,
                                    filled: true,
                                    fillColor: Colors.white,
                                    // labelText: 'Email/Phone Number',
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.white)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.white)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 45,
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              sendOtp();
                              // Navigator.push(context, MaterialPageRoute(builder:(context)=>Otp()));
                            }
                            // Navigator.push(context, MaterialPageRoute(builder:(context)=>SignUp()));
                          },
                          child: Text('Sign Up'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
