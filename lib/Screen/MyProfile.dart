import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ho_jayega_user_main/Helper/api.path.dart';
import 'package:ho_jayega_user_main/Screen/bottomScreen.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/color.dart';
import '../Model/GetCityModel.dart';
import '../Model/GetCountryModel.dart';
import '../Model/GetProfileModel.dart';
import '../Model/GetStateMOdel.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getCountry();
  }

  bool isLoading = false;
  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id = preferences.getString('user_id');
    print("user id in profileee $user_id");
    getProfile();
  }

  GetProfileModel? getProfileModel;
  getProfile() async {
    setState(() {
      isLoading = true;
    });
    var headers = {
      'Cookie': 'ci_session=b5446517c990dbe1fff8ddd07a4397adf7b075bf'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getProfiles));
    request.fields.addAll({
      'user_id': user_id.toString(),
    });
    print("user id in profile screen ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("===my technic=======${request.fields}===============");
    print("===my technic=======${request.url}===============");
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      var result = jsonDecode(finalResponse);
      if (result['error'] == false) {
        setState(() {
          getProfileModel = GetProfileModel.fromJson(result);
          nameEditingController.text = getProfileModel?.data?.username ?? "";
          emailEditingController.text = getProfileModel?.data?.email ?? "";
          mobileCtr.text = getProfileModel?.data?.mobile ?? "";
          addressCtr.text = getProfileModel?.data?.address ?? "";
          // cityValue = getProfileModel?.data?.city ?? "";
          // stateValue = getProfileModel?.data?.state ?? "";
          // countryValue = getProfileModel?.data?.country ?? "";
          isLoading = false;
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  updateProfile() async {
    var headers = {
      'Cookie': 'ci_session=670c0b78d5abea8b4bece9129571b30a1f697c0d'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.updateUser));
    request.fields.addAll({
      'name': nameEditingController.text,
      'email': emailEditingController.text,
      'mobile': mobileCtr.text,
      'address': addressCtr.text,
      'country': countryId.toString(),
      'state': stateId.toString(),
      'city': cityId.toString(),
      'user_id': user_id.toString(),
    });
    print("update profilee parameter ${request.fields}");
    request.files.add(
        await http.MultipartFile.fromPath('image', profileImage!.path.toString()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Fluttertoast.showToast(msg: "Profile Update Successfully");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BottomNavBar()));
    } else {
      print(response.reasonPhrase);
    }
  }

  bool selected = false;
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController cPasswordEditingController = TextEditingController();
  TextEditingController addressCtr = TextEditingController();
  TextEditingController mobileCtr = TextEditingController();
  TextEditingController pincodeCtr = TextEditingController();

  List<CityData> cityList = [];
  List<CountryData> countryList = [];
  List<StataData> stateList = [];
  dynamic cityValue;
  dynamic countryValue;
  dynamic stateValue;
  var countryId;
  var stateId;
  var cityId;

  bool showPassword = false;
  bool showPasswordNew = false;

  getstate(String? countryId) async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors.appbarColor,
        appBar: AppBar(
          backgroundColor: colors.primary,
          elevation: 0,
          title: const Text("My Profile",
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: colors.whiteTemp)),
          centerTitle: true,
        ),
        body: !isLoading
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Stack(
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              showAlertDialog(context, "image");
                            },
                            child:
                            // getProfileModel?.data?.profilePic == "" ||
                            //         getProfileModel?.data?.profilePic == null
                            //     ? Container(
                            //         height: 120,
                            //         width: 120,
                            //         padding: const EdgeInsets.all(8),
                            //         decoration: const BoxDecoration(
                            //             shape: BoxShape.circle,
                            //             color: Colors.white),
                            //         child: Image.asset(
                            //           "assets/images/bike.png",
                            //           fit: BoxFit.fill,
                            //         ),
                            //     )
                                  profileImage == null ? Container(
                                    height: 110,
                                    width: 110,
                                    padding: EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Image.network(
                                      "${getProfileModel?.data?.profilePic}",
                                      fit: BoxFit.fill,
                                    ),
                            ):
                            Container(
                              height: 110,
                              width: 110,
                              padding: EdgeInsets.all(8),
                              decoration:  BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                  child: Image.file(profileImage!, fit: BoxFit.fill))
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 60,
                          bottom: 0,
                          right: 0,
                          top: 93,
                          child: Icon(Icons.camera_alt, color: colors.primary),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: [
                          Column(
                            children: [
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
                                          decoration: InputDecoration(
                                              counterText: "",
                                              // suffixIcon: suffixIcons,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 5),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              hintText: ""),
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
                                          decoration: InputDecoration(
                                              counterText: "",
                                              // suffixIcon: suffixIcons,
                                              contentPadding: EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 5),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              hintText: ""),
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
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                              counterText: "",
                                              // suffixIcon: suffixIcons,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 5),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              hintText: ""),
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
                                          controller: addressCtr,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                              counterText: "",
                                              // suffixIcon: suffixIcons,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 5),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              hintText: ""),
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
                                          value: countryValue,
                                          hint: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: const Text('Country'),
                                          ),
                                          // Down Arrow Icon
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          // Array list of items
                                          items: countryList.map((items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Container(
                                                  child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child:
                                                    Text(items.name.toString()),
                                              )),
                                            );
                                          }).toList(),
                                          // After selecting the desired option,it will
                                          // change button value to selected value
                                          onChanged: (dynamic value) {
                                            setState(() {
                                              stateValue = null;
                                              countryValue = value;
                                              countryId = value.id.toString();
                                              print(
                                                  "===my technic=======${countryId}===============");
                                              getstate(
                                                  "${value.id.toString()}");
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
                                        child: DropdownButton(
                                          isExpanded: true,
                                          value: stateValue,
                                          hint: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: const Text('State'),
                                          ),
                                          // Down Arrow Icon
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          // Array list of items
                                          items: stateList.map((items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Container(
                                                  child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child:
                                                    Text(items.name.toString()),
                                              )),
                                            );
                                          }).toList(),
                                          onChanged: (dynamic value) {
                                            setState(() {
                                              cityValue = null;
                                              stateValue = value;
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
                                              offset: Offset(1.0, 1.0),
                                              blurRadius: 0.2,
                                              spreadRadius: 0.5,
                                            ),
                                          ],
                                        ),
                                        child: DropdownButton(
                                          isExpanded: true,
                                          value: cityValue,
                                          hint: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: const Text('City'),
                                          ),
                                          // Down Arrow Icon
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          // Array list of items
                                          items: cityList.map((items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Container(
                                                  child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child:
                                                    Text(items.name.toString()),
                                              )),
                                            );
                                          }).toList(),
                                          // After selecting the desired option,it will
                                          // change button value to selected value
                                          onChanged: (dynamic value) {
                                            setState(() {
                                              cityValue = value;
                                              cityId = value.id.toString();
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
                              const SizedBox(height: 40),
                              Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        colors.secondary, // Background color
                                    onPrimary: Colors
                                        .amber, // Text Color (Foreground color)
                                  ),
                                  child: const Text("Update Profile",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)),
                                  onPressed: () {
                                    updateProfile();
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
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
              ));
  }

  File? profileImage;

  Future<void> pickImage(ImageSource source, String type) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      maxHeight: 100,
      maxWidth: 100,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      setState(() {
        if (type == 'image') {
          profileImage = File(pickedFile.path);
        }
      });
    }
  }

  Future showAlertDialog(BuildContext context, String type) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Select Image'),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    pickImage(ImageSource.gallery, type);
                    Navigator.pop(context);
                    // getImage(ImageSource.camera, context, 1);
                  },
                  child: Text('Gallery'),
                ),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    pickImage(ImageSource.camera, type);
                    Navigator.pop(context);
                  },
                  child: Text('Camera'),
                ),
              ],
            ),
          ),
        ) ??
        false;
  }

  // showImageDialog() {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: const Text("Choose an Option"),
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: InkWell(
  //                   onTap: () {
  //                     getFromCamera();
  //                     Navigator.pop(context);
  //                   },
  //                   child: Row(
  //                     children: [
  //                       Icon(
  //                         Icons.camera,
  //                         color: Colors.red,
  //                       ),
  //                       SizedBox(width: 8),
  //                       Text("Camera")
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: InkWell(
  //                   onTap: () {
  //                     getFromGallery();
  //                     Navigator.pop(context);
  //                   },
  //                   child: Row(
  //                     children: const [
  //                       Icon(
  //                         Icons.image,
  //                         color: Colors.red,
  //                       ),
  //                       SizedBox(width: 8),
  //                       Text("Gallery")
  //                     ],
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //         );
  //       });
  // }
}
