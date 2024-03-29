import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ho_jayega_user_main/AuthView/signUpPage.dart';
import 'package:ho_jayega_user_main/Helper/api.path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Screen/bottomScreen.dart';
import 'CreateAccount.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  bool isChecked = false;
  bool isVisible = false;

  String? _validateEmail(value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Your Email/Phone Number';
    }
    return null;
  }

  bool isValidEmail(String email) {
    // Simple email validation using a regular expression
    // You can customize the regular expression based on your requirements
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  userLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=f26b98128123d8304685b8bd593560b8d95aef80'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.login));
    request.fields.addAll(
        {'email': email.text, 'password': password.text, 'device_token': ''});

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finaResult = jsonDecode(result);
      print("responseee $finaResult");
      if (finaResult['error'] == false) {
        user_id = finaResult['data']['id'];
        user_name = finaResult['data']['username'];
        user_mobile = finaResult['data']['mobile'];
        user_email = finaResult['data']['email'];
        await prefs.setString('user_id', finaResult['data']['id'].toString());
        await prefs.setString('mobile', user_mobile.toString());
        print(
            '____user data is___$user_id $user_email $user_mobile ${user_name}___');
        setState(() {});
        Fluttertoast.showToast(msg: '${finaResult['message']}');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
      } else {
        Fluttertoast.showToast(msg: "${finaResult['message']}");
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

  bool isStrongPassword(String s){
    RegExp regex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    return regex.hasMatch(s);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/images/introimage.png',
                fit: BoxFit.fill,
              )),
          const Positioned(
              top: 30,
              left: 20,
              child: Text(
                'Login',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
          const Positioned(
              top: 80,
              left: 20,
              right: 20,
              child: Text(
                'Please provide your registered email or mobile number along with your password. If not registered, sign up for a new account. ',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
          Positioned(
            top: 100,
            left: 50,
            right: 50,
            child: Image.asset(
              "assets/images/LOGIN.png",
              scale: 2,
            ),
          ),
          Positioned(
            top: 320,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Container(
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
                          padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
                          child: Row(
                            children: [
                              Card(
                                elevation: 5,
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  color: Colors.grey.shade200,
                                  child: const Icon(
                                    Icons.phone,
                                    size: 25,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Card(
                                  color: Colors.grey.shade200,
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
                                      counterText: "",
                                      hintText: "Email/Phone Number",
                                      isDense: true,
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      // labelText: 'Email/Phone Number',
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade200)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade200)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                          child: Row(
                            children: [
                              Card(
                                elevation: 5,
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  color: Colors.grey.shade200,
                                  child: const Icon(
                                    Icons.lock,
                                    size: 25,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Card(
                                  color: Colors.grey.shade200,
                                  elevation: 5,
                                  child: TextFormField(
                                    maxLength: 8,
                                    obscureText: isVisible ? false : true,
                                    controller: password,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter password';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      isDense: true,
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      //labelText: 'Password',
                                      hintText: "Password",
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isVisible
                                                ? isVisible = false
                                                : isVisible = true;
                                          });
                                        },
                                        icon: Icon(
                                          isVisible
                                              ? Icons.remove_red_eye
                                              : Icons.visibility_off,
                                          color: Colors.green,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade200),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade200)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                    value: isChecked,
                                    activeColor: Colors.green,
                                    side: const BorderSide(
                                      color: Colors.green,
                                    ),
                                    onChanged: (val) {
                                      setState(() {
                                        isChecked = val!;
                                      });
                                    }),
                                const Text('Remember me'),
                              ],
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUp(
                                                forget: true,
                                              )));
                                },
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          height: 40,
                          width: 250,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (isChecked == false) {
                                  Fluttertoast.showToast(
                                      msg: "Plaese Select Check Box");
                                } else {
                                  userLogin();
                                }

                                // Navigator.push(context, MaterialPageRoute(builder:(context)=> BottomNavBar()));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            child: const Text('Login'),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Center(
                  child: Text(
                    ' Login with ',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  //width: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)),

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/facebook.png",
                        scale: 1.6,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        'Facebook',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account ?",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                        },
                        child: const Text('Sign Up',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                        ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
