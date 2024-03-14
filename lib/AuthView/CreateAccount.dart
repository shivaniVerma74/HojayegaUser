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
import '../Model/getareaModel.dart';
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
    getstate();

   // getCountry();
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
  var countryId;
  var stateId;
  var cityId;

  bool showPassword = false;
  bool showPasswordNew = false;



  getstate(/*String? countryId*/) async {
    print("state apiii isss");
    var headers = {
      'Cookie': 'ci_session=95bbd5f6f543e31f65185f824755bcb57842c775'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getStates));
    request.fields.addAll({
      'country_id': "5"
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
    } else {
      print(response.reasonPhrase);
    }
  }

  List<AreaModelList> areaList = [];
  var areaid;
  dynamic selectarea;
  getarea(String? countryId) async {
    print("state apiii isss");
    var headers = {
      'Cookie': 'ci_session=95bbd5f6f543e31f65185f824755bcb57842c775'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getregions));
    request.fields.addAll({
      'city_id': countryId.toString(),
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("===my technic=======${request.url}===============");
    print("===my technic=======${request.fields}===============");
    if (response.statusCode == 200) {
      String responseData = await response.stream.bytesToString();
      print("===my technic=======${responseData}===============");
      var userData = json.decode(responseData);
      if (userData['response_code'] == "1") {
        setState(() {
          areaList = GetAreaModel.fromJson(userData).data ?? [];
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  getCity(String? sId) async {
    var headers = {
      'Cookie': 'ci_session=95bbd5f6f543e31f65185f824755bcb57842c775'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getCitys));
    request.fields.addAll({'state_id': sId.toString()});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responseData);
      if (mounted) {
        setState(() {
          cityList = GetCityModel.fromJson(userData).data!;
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  getCountry() async {
    var headers = {
      'Cookie': 'ci_session=cb5a399c036615bb5acc0445a8cd39210c6ca648'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getCountrys));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responseData);
      if (mounted) {
        setState(() {
          countryList = GetCountryModel.fromJson(userData).data!;
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  userRegister() async {
    var headers = {
      'Cookie': 'ci_session=a36d1164a41bc2ad7eebf3ca6869f6ade1068ad4'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.register));
    request.fields.addAll({
      'name': nameEditingController.text,
      'email': emailEditingController.text,
      'password': passwordEditingController.text,
      'confirm_password': cPasswordEditingController.text,
      'mobile': mobileCtr.text,
      'address': addressCtr.text,
      'country': countryId.toString(),
      'state': stateId.toString(),
      'city': cityId.toString(),
      // 'pincode': pincodeCtr.text,
      'area': areaid.toString(),
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
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false);
      } else {
        Fluttertoast.showToast(msg: "${finaResult['message']}");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  bool isStrongPassword(String s){
    RegExp regex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    return regex.hasMatch(s);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/otp verification – 3.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Create Account",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 27,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Please enter required information to complete signup.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 12),
                      maxLines: 2,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                    child: Image.asset("assets/images/create account.png",
                        scale: 1.9)),
                const SizedBox(height: 20),
                Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 4,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 2)),
                      height: MediaQuery.of(context).size.height / 1.7,
                      width: MediaQuery.of(context).size.width / 1.15,
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 10),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 5),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              hintText: "Name"),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please Enter Name';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 15),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                          // maxLength: 10,
                                          controller: emailEditingController,
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                              counterText: "",
                                              // suffixIcon: suffixIcons,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 5),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              hintText: "Email ID"),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please Enter Email ID';
                                            } else if (!value.contains("@") ||
                                                !value.contains(".com")) {
                                              return 'Please Enter Vailed Email ID';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 15),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                          maxLength: 10,
                                          controller: mobileCtr,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                              counterText: "",
                                              // suffixIcon: suffixIcons,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 5),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              hintText: "Mobile"),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Enter Mobile Number';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 15),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                          maxLength: 8,
                                          controller: passwordEditingController,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
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
                                                  isVisible
                                                      ? Icons.remove_red_eye
                                                      : Icons.visibility_off,
                                                  color: Colors.green,
                                                ),
                                              ),
                                              // suffixIcon: suffixIcons,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 5),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              hintText: "Password"),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Enter password';
                                            }
                                            else if(value.length<6)
                                              return "Minimum 6 And 8 Maximum Character";
                                            else if ( !isStrongPassword(value)) {
                                              return 'weak password ';
                                            }
                                            return null;
                                          },
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                          obscureText:
                                              isVisible2 ? false : true,
                                          maxLength: 8,
                                          controller:
                                              cPasswordEditingController,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
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
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 5),
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              hintText: "Confirm Password"),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Enter password';
                                            }
                                            // else if(value.length<6)
                                            //   return "Minimum 6 And 8 Maximum Character";
                                            // else if ( !isStrongPassword(value)) {
                                            //   return 'weak password ';
                                            // }
                                            // else if(value.length<6)
                                            //   return "Minimum six And Maximum Character";
                                            else if(passwordEditingController.text!=cPasswordEditingController.text){
                                              return 'Password Not Match';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 15),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                          //maxLength: 10,
                                          controller: addressCtr,
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                              counterText: "",
                                              // suffixIcon: suffixIcons,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 5),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              hintText: "Address"),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please Enter Address';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Padding(
                              //   padding: const EdgeInsets.only(
                              //       left: 10, right: 10, top: 15),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Material(
                              //         elevation: 4,
                              //         borderRadius: BorderRadius.circular(10),
                              //         child: Container(
                              //           width: 40,
                              //           height: 40,
                              //           child: Image.asset(
                              //             "assets/images/Region.png",
                              //             scale: 1.4,
                              //           ),
                              //         ),
                              //       ),
                              //       const SizedBox(width: 18),
                              //       Expanded(
                              //         child: Container(
                              //           width: 80,
                              //           height: 45,
                              //           decoration: BoxDecoration(
                              //             color: Colors.white,
                              //             borderRadius:
                              //                 BorderRadius.circular(5),
                              //             boxShadow: const [
                              //               BoxShadow(
                              //                 color: Colors.grey,
                              //                 offset: Offset(
                              //                   1.0,
                              //                   1.0,
                              //                 ),
                              //                 blurRadius: 0.2,
                              //                 spreadRadius: 0.5,
                              //               ),
                              //             ],
                              //           ),
                              //           child:
                              //           DropdownButton(
                              //             isExpanded: true,
                              //             value: countryValue,
                              //             hint: Padding(
                              //               padding: const EdgeInsets.only(left: 5),
                              //               child: const Text('Country'),
                              //             ),
                              //             // Down Arrow Icon
                              //             icon: const Icon(
                              //                 Icons.keyboard_arrow_down),
                              //             // Array list of items
                              //             items: countryList.map((items) {
                              //               return DropdownMenuItem(
                              //                 value: items,
                              //                 child: Padding(
                              //                   padding: const EdgeInsets.only(left: 5),
                              //                   child: Container(
                              //                       child: Text(
                              //                           items.name.toString())),
                              //                 ),
                              //               );
                              //             }).toList(),
                              //             onChanged: (CountryData? value) {
                              //               setState(() {
                              //                 stateValue = null;
                              //                 countryValue = value!;
                              //                 countryId = value.id.toString();
                              //                 print(
                              //                     "===my technic=======${countryId}===============");
                              //                 getstate(
                              //                     "${value.id.toString()}");
                              //               });
                              //             },
                              //             underline: Container(),
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 10),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                        child:
                                        DropdownButton(
                                          isExpanded: true,
                                          value: stateValue,
                                          hint: Padding(
                                            padding: const EdgeInsets.only(left: 5),
                                            child: const Text('State'),
                                          ),
                                          // Down Arrow Icon
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          // Array list of items
                                          items: stateList.map((items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 5),
                                                child: Container(
                                                    child: Text(
                                                        items.name.toString())),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (StataData? value) {
                                            setState(() {
                                              cityValue = null;
                                              stateValue = value!;
                                              stateId = value.id.toString();
                                              print("===my technic=======${stateId}===============");
                                              getCity("${value.id.toString()}");
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
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 10),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                          hint: Padding(
                                            padding: const EdgeInsets.only(left: 5),
                                            child: const Text('City'),
                                          ),
                                          // Down Arrow Icon
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          // Array list of items
                                          items: cityList.map((items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 5),
                                                child: Container(
                                                    child: Text(
                                                        items.name.toString())),
                                              ),
                                            );
                                          }).toList(),
                                          // After selecting the desired option,it will
                                          // change button value to selected value
                                          onChanged: (CityData? value) {
                                            setState(() {
                                              selectarea = null;
                                              cityValue = value!;
                                              cityId = value.id.toString();
                                              getarea('${value.id.toString()}');
                                              print(
                                                  "===my technic=======${cityId}===============");
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
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 10),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                          value: selectarea,
                                          hint: Padding(
                                            padding: const EdgeInsets.only(left: 5),
                                            child: const Text('Area'),
                                          ),
                                          // Down Arrow Icon
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          // Array list of items
                                          items: areaList.map((items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 5),
                                                child: Container(
                                                    child: Text(
                                                        items.name.toString())),
                                              ),
                                            );
                                          }).toList(),
                                          // After selecting the desired option,it will
                                          // change button value to selected value
                                          onChanged: (dynamic value) {
                                            setState(() {
                                              selectarea = value!;
                                              areaid = value.id.toString();
                                              print(
                                                  "===my technic=======${areaid}===============");
                                            });
                                          },
                                          underline: Container(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Padding(
                              //   padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Material(
                              //         elevation: 4,
                              //         borderRadius: BorderRadius.circular(10),
                              //         child: Container(
                              //           width: 40,
                              //           height: 40,
                              //           child: Image.asset(
                              //             "assets/images/pin code.png",
                              //             scale: 1.4,
                              //           ),
                              //         ),
                              //       ),
                              //       const SizedBox(width: 18),
                              //       Expanded(
                              //         child: Container(
                              //           width: 80,
                              //           height: 45,
                              //           decoration: BoxDecoration(
                              //             color: Colors.white,
                              //             borderRadius: BorderRadius.circular(5),
                              //             boxShadow: const [
                              //               BoxShadow(
                              //                 color: Colors.grey,
                              //                 offset: Offset(1.0, 1.0,),
                              //                 blurRadius: 0.2,
                              //                 spreadRadius: 0.5,
                              //               ),
                              //             ],
                              //           ),
                              //           child: TextFormField(
                              //             maxLength: 6,
                              //             controller: pincodeCtr,
                              //             keyboardType: TextInputType.number,
                              //             decoration: const InputDecoration(
                              //                 counterText: "",
                              //                 // suffixIcon: suffixIcons,
                              //                 contentPadding: EdgeInsets.symmetric(
                              //                     vertical: 5, horizontal: 5),
                              //                 border: OutlineInputBorder(
                              //                     borderSide: BorderSide.none),
                              //                 hintText: "Pincode"),
                              //             validator: (value){
                              //               if (value == null || value.isEmpty) {
                              //                 return 'Please Enter Pincode';
                              //               }
                              //               return null;
                              //             },
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      Row(
                                        children: [
                                          Text(
                                            'I agree to all ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 10),
                                          ),
                                          Text(
                                            'terms & condition',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue,
                                                fontSize: 10),
                                          ),
                                          Text(' and ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 10)),
                                          Text('privacy policy',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                  fontSize: 10)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (stateValue == null) {
                                      Fluttertoast.showToast(
                                          msg: "Please Select State");
                                    } else if (cityValue == null) {
                                      Fluttertoast.showToast(
                                          msg: "Please Select City");
                                    }
                                    // else if (stateValue == null) {
                                    //   Fluttertoast.showToast(
                                    //       msg: "Please Select State");
                                    // }
                                    else if (isChecked == false) {
                                      Fluttertoast.showToast(
                                          msg: "Please Select Check Box");
                                    } else {
                                      userRegister();
                                    }
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: colors.secondary),
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: Center(
                                    child: Text("Submit",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18)),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
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
      ),
    );
  }
}
