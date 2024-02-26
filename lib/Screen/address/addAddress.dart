import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ho_jayega_user_main/Helper/color.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Helper/api.path.dart';
import '../../Helper/appBar.dart';
import '../../Model/GetCityModel.dart';
import '../../Model/GetCountryModel.dart';
import '../../Model/GetStateMOdel.dart';
import '../../Model/getAddress.dart';
import 'package:http/http.dart' as http;

import '../../Model/getareaModel.dart';

class Addaddress extends StatefulWidget {
  bool? isEdit;
  AddressList? addressList;
  Addaddress({Key? key, this.isEdit, this.addressList}) : super(key: key);

  @override
  State<Addaddress> createState() => _AddaddressState();
}

class _AddaddressState extends State<Addaddress> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomSheet: Padding(
            padding: const EdgeInsets.all(7),
            child: InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  if (widget.isEdit == true) {
                    if (stateId == null) {
                      Fluttertoast.showToast(msg: "Please Select State");
                    } else if (cityId == null) {
                      Fluttertoast.showToast(msg: "Please Select City");
                    } else if (areaid == null) {
                      Fluttertoast.showToast(msg: "Please Select Area");
                    } else {
                      updateAddress();
                    }
                  } else {
                    if (stateId == null) {
                      Fluttertoast.showToast(msg: "Please Select State");
                    } else if (cityId == null) {
                      Fluttertoast.showToast(msg: "Please Select City");
                    } else if (areaid == null) {
                      Fluttertoast.showToast(msg: "Please Select Area");
                    } else {
                      AddAddress();
                    }
                  }
                }
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: colors.primary),
                child: Center(
                  child: widget.isEdit == true
                      ? Text(
                          'Update Address',
                          style: TextStyle(
                              color: colors.whiteTemp,
                              fontWeight: FontWeight.bold),
                        )
                      : Text(
                          'Add Address',
                          style: TextStyle(
                              color: colors.whiteTemp,
                              fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ),
          ),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: commonAppBar(
              context,
              text: "Add Address",
              isHome: false,
              ontap: (){
                Navigator.pop(context);
              }
            ),
          ),
          body: !isLoading
              ? SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),

                      TextFormField(
                        readOnly: true,
                        onTap: () {
                          showPlacePicker();
                        },
                        controller: addresscontroller,
                        decoration: InputDecoration(
                          counterText: "",
                          prefixIcon: const Icon(
                            Icons.location_searching,
                          ),
                          hintText: 'Select Address',
                          hintStyle: TextStyle(fontSize: 15),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 5),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: colors.primary, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: colors.primary, width: 2)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: colors.primary, width: 2)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: colors.primary),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Select Address';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),

                      // Container(
                      //
                      //   height: 50,
                      //   width: MediaQuery.of(context).size.width,
                      //getstate
                      //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                      //
                      //     border: Border.all(color: colors.primary,width: 2)
                      //
                      //
                      //   ),
                      //
                      //   child:  Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: DropdownButton(
                      //       isExpanded: true,
                      //       value: selectCountry,
                      //       hint: const Text('Country'),
                      //       icon: const Icon(Icons.keyboard_arrow_down),
                      //       items: countryList.map((items) {
                      //         return
                      //           DropdownMenuItem(
                      //             value: items,
                      //             child: Container(
                      //                 child: Text(items.name.toString())),
                      //           );
                      //       }).toList(),
                      //       onChanged: (dynamic value) {
                      //         setState(() {
                      //           selectState=null;
                      //           selectCountry = value;
                      //           countryId=value.id.toString();
                      //           print("===my technic=======${countryId}===============");
                      //           getstate("${value.id.toString()}");
                      //         });
                      //       },
                      //        underline: Container(),
                      //     ),
                      //   ),
                      // ),

                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: colors.primary, width: 2)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                            isExpanded: true,
                            value: selectState,
                            hint: const Text('State'),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: stateList.map((items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Container(
                                    child: Text(items.name.toString())),
                              );
                            }).toList(),
                            onChanged: (dynamic value) {
                              setState(() {
                                selectCity = null;
                                selectState = value;
                                stateId = value.id.toString();
                                print(
                                    "===my technic=======${stateId}===============");
                                getCity("${value.id.toString()}");
                              });
                            },
                            underline: Container(),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: colors.primary, width: 2)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                            isExpanded: true,
                            value: selectCity,
                            hint: const Text('City'),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: cityList.map((items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Container(
                                    child: Text(items.name.toString())),
                              );
                            }).toList(),
                            onChanged: (dynamic value) {
                              setState(() {
                                selectarea = null;
                                selectCity = value;
                                cityId = value.id.toString();
                                getarea("${value.id.toString()}");

                                print(
                                    "===my technic=======${cityId}===============");
                              });
                            },
                            underline: Container(),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: colors.primary, width: 2)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                            isExpanded: true,
                            value: selectarea,
                            hint: const Text('Area'),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: areaList.map((items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Container(
                                    child: Text(items.name.toString())),
                              );
                            }).toList(),
                            onChanged: (dynamic value) {
                              setState(() {
                                selectarea = value;
                                areaid = value.id.toString();
                                print(
                                    "===my technic=======${areaid}===============");
                              });
                            },
                            underline: Container(),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        controller: pincodecontroller,
                        decoration: InputDecoration(
                          counterText: "",
                          prefixIcon: const Icon(
                            Icons.location_searching,
                          ),
                          hintText: 'Pin Code',
                          hintStyle: TextStyle(fontSize: 15),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 5),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: colors.primary, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: colors.primary, width: 2)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: colors.primary, width: 2)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: colors.primary),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Pin Code';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        maxLength: 5,
                        keyboardType: TextInputType.number,
                        controller: houseNumbercontroller,
                        decoration: InputDecoration(
                          counterText: "",
                          prefixIcon: const Icon(
                            Icons.house_sharp,
                          ),
                          hintText: 'Flat Number',
                          hintStyle: TextStyle(fontSize: 15),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 5),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: colors.primary, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: colors.primary, width: 2)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: colors.primary, width: 2)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: colors.primary),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Flat Number';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),
                      SizedBox(
                        height: 100,
                      )
                    ]),
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: colors.primary,
                    ),
                  ),
                )),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isEdit == true) {
      addresscontroller.text = widget.addressList?.address ?? "";
      pincodecontroller.text = widget.addressList?.pincode ?? "";
      houseNumbercontroller.text = widget.addressList?.building ?? "";
      lat = widget.addressList?.lat ?? "";
      lang = widget.addressList?.lng ?? "";
    }
    getstate();
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController addresscontroller = TextEditingController();
  TextEditingController houseNumbercontroller = TextEditingController();
  TextEditingController pincodecontroller = TextEditingController();
  TextEditingController countryController = TextEditingController();

  void showPlacePicker() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PlacePicker("AIzaSyCKLIBoAca5ptn9A_1UCHNNrtzI81w2KRk")));

    // Check if the user picked a place
    if (result != null) {
      setState(() {
        addresscontroller.text = '${result.formattedAddress}';
        print(addresscontroller.text);
      });
      setState(() {
        lat = "${result.latLng!.latitude}";
        print(lat);

        lang = "${result.latLng!.longitude}";
        print(lang);

        pincodecontroller.text = result.postalCode.toString();
      });
    }
  }

  String _getAreaFromAddress(String formattedAddress) {
    List<String> addressComponents = formattedAddress.split(', ');

    String area = addressComponents.firstWhere(
      (element) => element.endsWith('Area'),
      orElse: () => 'N/A',
    );

    return area;
  }

  var lat;
  var lang;

  bool isLoading = false;
  List<AddressList> getAddressList = [];
  AddAddress() async {
    setState(() {
      isLoading = true;
    });

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? user_id = sharedPreferences.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=8337986a2b6d2140aa0b9f8e468d4183e289f1ac'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${ApiServicves.addAddress}'));
    request.fields.addAll({
      'address': addresscontroller.text.toString(),
      'building': houseNumbercontroller.text.toString(),
      'city': cityId.toString(),
      'state': stateId.toString(),
      'is_default': '1',
      'type': '1',
      'lat': lat.toString(),
      'lng': lang.toString(),
      'user_id': user_id.toString(),
      'pincode': pincodecontroller.text.toString(),
      'region': areaid.toString(),
      'country': countryId.toString(),
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("===my technic=======${request.fields}===============");
    print("===my technic=======${request.url}===============");
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      if (finalResult['response_code'] == "1") {
        Fluttertoast.showToast(msg: finalResult['msg'].toString());

        Navigator.pop(context);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  updateAddress() async {
    setState(() {
      isLoading = true;
    });

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? user_id = sharedPreferences.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=8337986a2b6d2140aa0b9f8e468d4183e289f1ac'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiServicves.updateAddress}'));
    request.fields.addAll({
      'address': addresscontroller.text.toString(),
      'building': houseNumbercontroller.text.toString(),
      'city': cityId.toString(),
      'state': stateId.toString(),
      'is_default': '1',
      'type': '1',
      'lat': lat.toString(),
      'lng': lang.toString(),
      'user_id': user_id.toString(),
      'pincode': pincodecontroller.text.toString(),
      'region': areaid.toString(),
      'country': countryId.toString(),
      'id': widget.addressList?.id.toString() ?? "",
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("===my technic=======${request.fields}===============");
    print("===my technic=======${request.url}===============");
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      if (finalResult['response_code'] == "1") {
        Fluttertoast.showToast(msg: finalResult['msg'].toString());

        Navigator.pop(context);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  getstate() async {
    print("state apiii isss");
    var headers = {
      'Cookie': 'ci_session=95bbd5f6f543e31f65185f824755bcb57842c775'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getStates));
    request.fields.addAll({
      'country_id': countryId.toString(),
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseData =
          await response.stream.transform(utf8.decoder).join();
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
    print("Area apiii isss");
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

  List<CityData> cityList = [];
  List<CountryData> countryList = [];
  List<StataData> stateList = [];
  CityData? cityValue;
  CountryData? countryValue;
  StataData? stateValue;
  String? stateName;
  String? cityName;
  dynamic selectState;
  dynamic selectCountry;
  dynamic selectCity;
  var countryId;
  var stateId;
  var cityId;
}
