import 'package:flutter/material.dart';
import 'package:ho_jayega_user_main/Helper/color.dart';

import 'CreateAccount.dart';

class SelectSignupPage extends StatefulWidget {
  const SelectSignupPage({Key? key}) : super(key: key);

  @override
  State<SelectSignupPage> createState() => _SelectSignupPageState();
}

class _SelectSignupPageState extends State<SelectSignupPage> {
  final _formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  bool isChecked = false;
  bool isVisible = false;
  String? _validateEmail(value) {
    if (value!.isEmpty) {
      return "Please enter an Email/Phone number ";
    }
    return null;
  }

  int selectedSignup = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: colors.primary,
                          )),
                      Expanded(
                          flex: 2,
                          child: Container(
                            color: Color(0xffE2EBFE),
                          )),
                    ],
                  )
                // Image.asset(
                //   'assets/images/introimage.png',
                //   fit: BoxFit.fill,
                // )

              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Sign up',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Please enter required information to complete signup.',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedSignup = 0;
                              });
                            },
                            child: Row(
                              children: [
                                Icon(
                                    selectedSignup == 0
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_off_outlined,
                                    color: selectedSignup == 0
                                        ? Colors.green
                                        : Colors.white),
                                Text(
                                  'Personal Information',
                                  style: TextStyle(
                                      color: selectedSignup == 0
                                          ? Colors.green
                                          : Colors.white),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedSignup = 1;
                              });
                            },
                            child: Row(
                              children: [
                                Icon(
                                    selectedSignup == 1
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_off_outlined,
                                    color: selectedSignup == 1
                                        ? Colors.green
                                        : Colors.white),
                                Text(
                                  'Address',
                                  style: TextStyle(
                                      color: selectedSignup == 1
                                          ? Colors.green
                                          : Colors.white),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedSignup = 2;
                              });
                            },
                            child: Row(
                              children: [
                                Icon(
                                    selectedSignup == 2
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_off_outlined,
                                    color: selectedSignup == 2
                                        ? Colors.green
                                        : Colors.white),
                                Text(
                                  'Account Details',
                                  style: TextStyle(
                                      color: selectedSignup == 2
                                          ? Colors.green
                                          : Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        // margin: EdgeInsets.fromLTRB(20, 400, 20, 150),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 3),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.radio_button_checked,
                                    color: Colors.black),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Personal Information',
                                  style:
                                  TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Kindly complete the form below, specifying the purposee of your application',
                              style: TextStyle(fontSize: 14, color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'User Type',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.check_circle, color: Colors.green),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'User',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.2,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.check_circle, color: Colors.green),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Merchant',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            )
                          ],
                        )),
                  ],
                ),
              ),
              // const Positioned(
              //     top: 30,
              //     left: 20,
              //     child: Text(
              //       'Login',
              //       style: TextStyle(
              //           fontSize: 35,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.white),
              //     )),
              // const Positioned(
              //     top: 80,
              //     left: 20,
              //     right: 20,
              //     child: Text(
              //       ' Please enter email address or mobile number and password if you are already registered. if not the signup for new account.  ',
              //       style: TextStyle(
              //           fontSize: 14,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.white),
              //     )),
              // Positioned(
              //     top: 100,
              //     left: 50,
              //     right: 50,
              //     child: Image.asset(
              //       "assets/images/introimage.png",
              //       scale: 2,
              //     )),
              Positioned(
                top: 320,
                left: 20,
                right: 20,
                child: Column(
                  children: [],
                ),
              ),
            ],
          ),
        ));
  }
}
