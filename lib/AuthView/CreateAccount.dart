import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ho_jayega_user_main/AuthView/loginPage.dart';
import 'package:ho_jayega_user_main/Model/GetCountryModel.dart';
import 'package:ho_jayega_user_main/Screen/homePage.dart';
import 'package:http/http.dart' as http;
import '../Helper/api.path.dart';
import '../Helper/color.dart';
import '../Model/GetCityModel.dart';
import '../Model/GetStateMOdel.dart';
import '../Screen/bottomScreen.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreatAState();
}

class _CreatAState extends State<CreateAccount> {

  @override
  void initState() {
    super.initState();
    getCountry();
  }
  final _formKey = GlobalKey<FormState>();
  bool selected = false;
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController cPasswordEditingController = TextEditingController();
  TextEditingController addressCtr = TextEditingController();
  TextEditingController mobileCtr = TextEditingController();
  TextEditingController pincodeCtr = TextEditingController();

  bool isChecked = false;
  bool isVisible = false;
  bool isVisible2 = false;
  bool isShow = false;
  String? _validateEmail(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!isValidEmail(value)) {
      return 'Please enter a valid email address';
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

  List<CityData> cityList = [];
  List<CountryData> countryList = [];
  List<StataData> stateList = [];
  CityData? cityValue;
  CountryData? countryValue;
  StataData? stateValue;
  String? stateName;
  String? cityName;

  bool showPassword = false;
  bool showPasswordNew = false;

  getstate(String? countryId) async {
    print("state apiii isss");
    var headers = {
      'Cookie': 'ci_session=95bbd5f6f543e31f65185f824755bcb57842c775'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getStates));
    request.fields.addAll({
      'country_id': countryId.toString(),
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responseData);
      if (mounted) {
        setState(() {
          stateList = GetStateMOdel.fromJson(userData).data!;
          print("state list is $stateList");
        });
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  getCity(String? sId) async{
    var headers = {
      'Cookie': 'ci_session=95bbd5f6f543e31f65185f824755bcb57842c775'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getCitys));
    request.fields.addAll({
      'state_id': sId.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responseData);
      if (mounted) {
        setState(() {
          cityList = GetCityModel.fromJson(userData).data!;
        });
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  getCountry() async {
    var headers = {
      'Cookie': 'ci_session=cb5a399c036615bb5acc0445a8cd39210c6ca648'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getCountrys));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responseData);
      if (mounted) {
        setState(() {
          countryList = GetCountryModel.fromJson(userData).data!;
        });
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  userRegister() async{
    var headers = {
      'Cookie': 'ci_session=a36d1164a41bc2ad7eebf3ca6869f6ade1068ad4'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.register));
    request.fields.addAll({
      'name': nameEditingController.text,
      'email': emailEditingController.text,
      'password': passwordEditingController.text,
      'confirm_password': cPasswordEditingController.text,
      'mobile': mobileCtr.text,
      'address': addressCtr.text,
      'country': countryValue.toString(),
      'state': stateValue.toString(),
      'city': cityValue.toString(),
      'pincode': pincodeCtr.text
    });
    print("user register parameter ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finaResult = jsonDecode(result);
      print("responseee $finaResult");
      if (finaResult['error'] == false) {
        Fluttertoast.showToast(msg: '${finaResult['message']}');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
      } else {
        Fluttertoast.showToast(msg: "${finaResult['message']}");
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height / 1.0,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/introimage.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 50, left: 20),
                child: Text(
                  "Create Account",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24,
                    ),
                ),
              ),
              // const Padding(
              //   padding: EdgeInsets.only(top: 10, left: 20, right: 10),
              //   child: Text( "Please enter your valid mobile number to receive OTP for further registration process.",
              //       style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
              //   ),
              // ),
              const SizedBox(height: 15),
              // Center(
              //     child: Image.asset("assets/images/SIGN UP.png", scale: 1.9)),
              // const SizedBox(height: 10),
              Center(
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 4,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black)),
                    height: 640,
                    width: MediaQuery.of(context).size.width / 1.1,
                    child:
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    child: Image.asset(
                                      "assets/images/Name.png",
                                      scale: 1.4,
                                    ),
                                ),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                child: Container(
                                  width: 80,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(1.0, 1.0),
                                        blurRadius: 0.2,
                                        spreadRadius: 0.5,
                                      ),
                                    ],
                                  ),
                                  child: TextFormField(
                                    maxLength: 10,
                                    controller: nameEditingController,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        counterText: "",
                                        // suffixIcon: suffixIcons,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: "Name"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    child: Image.asset(
                                      "assets/images/email id.png",
                                      scale: 1.4,
                                    ),
                                ),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                child: Container(
                                  width: 80,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(1.0, 1.0,),
                                        blurRadius: 0.2,
                                        spreadRadius: 0.5,
                                      ),
                                    ],
                                  ),
                                  child: TextFormField(
                                    // maxLength: 10,
                                    controller: emailEditingController,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        counterText: "",
                                        // suffixIcon: suffixIcons,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: "Email ID"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  child: Image.asset(
                                    "assets/images/email id.png",
                                    scale: 1.4,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                child: Container(
                                  width: 80,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(1.0, 1.0,),
                                        blurRadius: 0.2,
                                        spreadRadius: 0.5,
                                      ),
                                    ],
                                  ),
                                  child: TextFormField(
                                    maxLength: 10,
                                    controller: mobileCtr,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        counterText: "",
                                        // suffixIcon: suffixIcons,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: "Mobile"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    child: Image.asset(
                                      "assets/images/Password.png",
                                      scale: 1.4,
                                    ),
                                ),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                child: Container(
                                  width: 80,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(
                                          1.0,
                                          1.0,
                                        ),
                                        blurRadius: 0.2,
                                        spreadRadius: 0.5,
                                      ),
                                    ],
                                  ),
                                  child: TextFormField(
                                    obscureText: isVisible ? false : true,
                                    maxLength: 10,
                                    controller: passwordEditingController,
                                    keyboardType: TextInputType.text,
                                    decoration:  InputDecoration(
                                        counterText: "",
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isVisible
                                                  ? isVisible = false
                                                  : isVisible = true;
                                            });
                                          },
                                          icon: Icon(
                                            isVisible ? Icons.remove_red_eye : Icons.visibility_off,
                                            color: Colors.green,
                                          ),
                                        ),
                                        // suffixIcon: suffixIcons,
                                        contentPadding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: "Password"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    child: Image.asset(
                                      "assets/images/Password.png",
                                      scale: 1.4,
                                    )),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                child: Container(
                                  width: 80,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(
                                          1.0,
                                          1.0,
                                        ),
                                        blurRadius: 0.2,
                                        spreadRadius: 0.5,
                                      ),
                                    ],
                                  ),
                                  child: TextFormField(
                                    obscureText: isVisible2 ? false: true,
                                    maxLength: 10,
                                    controller: cPasswordEditingController,
                                    keyboardType: TextInputType.text,
                                    decoration:  InputDecoration(
                                        counterText: "",
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                         setState(() {
                                          isVisible2
                                              ? isVisible2 = false
                                              : isVisible2 = true;
                                            });
                                           },
                                          icon: Icon(
                                           isVisible2
                                            ? Icons.remove_red_eye
                                            : Icons.visibility_off,
                                          color: Colors.green,
                                           ),
                                          ),
                                        // suffixIcon: suffixIcons,
                                         contentPadding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                         border: const OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: "Confirm Password"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  child: Image.asset(
                                    "assets/images/Address.png",
                                    scale: 1.4,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                child: Container(
                                  width: 80,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(1.0, 1.0,),
                                        blurRadius: 0.2,
                                        spreadRadius: 0.5,
                                      ),
                                    ],
                                  ),
                                  child: TextFormField(
                                    maxLength: 10,
                                    controller: addressCtr,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        counterText: "",
                                        // suffixIcon: suffixIcons,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: "Address"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    child: Image.asset(
                                      "assets/images/Region.png",
                                      scale: 1.4,
                                    ),
                                ),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                child: Container(
                                  width: 80,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(
                                          1.0,
                                          1.0,
                                        ),
                                        blurRadius: 0.2,
                                        spreadRadius: 0.5,
                                      ),
                                    ],
                                  ),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    value: countryValue,
                                    hint: const Text('Country'),
                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    // Array list of items
                                    items: countryList.map((items) {
                                      return
                                        DropdownMenuItem(
                                          value: items,
                                          child: Container(
                                              child: Text(items.name.toString())),
                                        );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (CountryData? value) {
                                      setState(() {
                                        countryValue = value!;
                                        getstate("${countryValue!.id}");
                                        // ("${stateValue!.id}");
                                        // stateName = stateValue!.name;
                                        // print("name herererb $stateName");
                                      });
                                    },
                                    underline: Container(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    child: Image.asset(
                                      "assets/images/State.png",
                                      scale: 1.4,
                                    )),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                child: Container(
                                  width: 80,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(
                                          1.0,
                                          1.0,
                                        ),
                                        blurRadius: 0.2,
                                        spreadRadius: 0.5,
                                      ),
                                    ],
                                  ),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    value: stateValue,
                                    hint: const Text('State'),
                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    // Array list of items
                                    items: stateList.map((items) {
                                      return
                                        DropdownMenuItem(
                                          value: items,
                                          child: Container(
                                              child: Text(items.name.toString())),
                                        );
                                    }).toList(),
                                    onChanged: (StataData? value) {
                                      setState(() {
                                        stateValue = value!;
                                        getCity("${stateValue!.id}");
                                        stateName = stateValue!.name;
                                        print("name herererb $stateName");
                                      });
                                    },
                                    underline: Container(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    child: Image.asset(
                                      "assets/images/City.png",
                                      scale: 1.4,
                                    )),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                child: Container(
                                  width: 80,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(
                                          1.0,
                                          1.0,
                                        ),
                                        blurRadius: 0.2,
                                        spreadRadius: 0.5,
                                      ),
                                    ],
                                  ),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    value: cityValue,
                                    hint: const Text('City'),
                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    // Array list of items
                                    items: cityList.map((items) {
                                      return DropdownMenuItem(value: items, child: Container(child: Text(items.name.toString())),
                                        );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (CityData? value) {
                                      setState(() {
                                        cityValue = value!;
                                        // getCity("${stateValue!.id}");
                                        // stateName = stateValue!.name;
                                        // print("name herererb $stateName");
                                      });
                                    },
                                    underline: Container(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  child: Image.asset(
                                    "assets/images/pin code.png",
                                    scale: 1.4,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                child: Container(
                                  width: 80,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(1.0, 1.0,),
                                        blurRadius: 0.2,
                                        spreadRadius: 0.5,
                                      ),
                                    ],
                                  ),
                                  child: TextFormField(
                                    maxLength: 10,
                                    controller: pincodeCtr,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        counterText: "",
                                        // suffixIcon: suffixIcons,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: "Pincode"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     Checkbox(
                        //         value: isChecked,
                        //         activeColor: Colors.green,
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(4)),
                        //         onChanged: (val) {
                        //           setState(() {
                        //             isChecked = val!;
                        //           });
                        //         }),
                        //     const Text(
                        //       'I agree to all',
                        //       style: TextStyle(fontSize: 8),
                        //     ),
                        //     TextButton(
                        //         onPressed: () {},
                        //         child: const Text(
                        //           'terms & condition',
                        //           style: TextStyle(
                        //               fontSize: 12,
                        //               fontWeight: FontWeight.w500),
                        //         )),
                        //     const Text('and', style: TextStyle(fontSize: 12)),
                        //     TextButton(
                        //         onPressed: () {},
                        //         child: const Text(
                        //           'privacy policy',
                        //           style: TextStyle(
                        //             fontSize: 12,
                        //             fontWeight: FontWeight.w500,
                        //           ),
                        //         ),
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(height: 10),
                        Container(
                          height: 33,
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: colors.secondary, // Background color
                              onPrimary: Colors.amber, // Text Color (Foreground color)
                            ),
                            child: const Text("Submit", style: TextStyle(color: Colors.white, fontSize: 18)),
                            onPressed: () {
                              userRegister();
                              // if(emailCtr.text.isEmpty){
                              //   Fluttertoast.showToast(msg: "Please Fill Field.");
                              // } else {
                              //   sendOtp();
                              //   //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                              // }
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyScreen()));
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
