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
    getProfile();
    getCountry();
    nameEditingController.text = getProfileModel?.data?.username ?? "";
    emailEditingController.text = getProfileModel?.data?.email ?? "";
    mobileCtr.text = getProfileModel?.data?.email ?? "";
    pincodeCtr.text = getProfileModel?.data?.countrycode ?? "";
    addressCtr.text = getProfileModel?.data?.address ?? "";
  }

  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id = preferences.getString('user_id');
    print("user id in profileee $user_id");
  }

  GetProfileModel? getProfileModel;
  getProfile() async {
    var headers = {
      'Cookie': 'ci_session=b5446517c990dbe1fff8ddd07a4397adf7b075bf'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getProfiles));
    request.fields.addAll({
      'user_id': user_id.toString(),
    });
   print("user id in profile screen ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = GetProfileModel.fromJson(json.decode(finalResponse));
      print("profile responseee $finalResult");
      setState(() {
        getProfileModel = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }


  updateProfile() async{
    var headers = {
      'Cookie': 'ci_session=670c0b78d5abea8b4bece9129571b30a1f697c0d'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.updateUser));
    request.fields.addAll({
      'name': nameEditingController.text,
      'email': emailEditingController.text,
      'mobile': mobileCtr.text,
      'address': addressCtr.text,
      'country': countryValue.toString(),
      'state': stateValue.toString(),
      'city': cityValue.toString(),
      'pincode': pincodeCtr.text,
      'user_id': user_id.toString(),
    });
    print("update profilee parameter ${request.fields}");
    request.files.add(await http.MultipartFile.fromPath('image', image!.path.toString()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Fluttertoast.showToast(msg: "Profile Update Successfully");
      Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
    }
    else {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.appbarColor,
      appBar: AppBar(
        backgroundColor: colors.primary,
        elevation: 0,
        title: const Text(
          "My Profile",
          style: TextStyle(fontWeight: FontWeight.w600, color: colors.whiteTemp)),
          centerTitle: true,
         ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Stack(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: showImageDialog,
                      child: getProfileModel?.data?.profilePic == "" || getProfileModel?.data?.profilePic == null ?  Container(
                          height: 120,
                          width: 120,
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white
                          ),
                          child: Image.asset("assets/images/bike.png", fit: BoxFit.fill,)
                      ):
                      Container(
                          height: 110,
                          width: 110,
                          padding: EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white
                          ),
                          child: Image.network("${getProfileModel?.data?.profilePic}", fit: BoxFit.fill,)
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
                                    decoration:  InputDecoration(
                                        counterText: "",
                                        // suffixIcon: suffixIcons,
                                        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                        border: OutlineInputBorder(borderSide: BorderSide.none),
                                        hintText: "${getProfileModel?.data?.username}"
                                    ),
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
                                    decoration:  InputDecoration(
                                        counterText: "",
                                        // suffixIcon: suffixIcons,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: "${getProfileModel?.data?.email}"),
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
                                    decoration:  InputDecoration(
                                        counterText: "",
                                        // suffixIcon: suffixIcons,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: "${getProfileModel?.data?.mobile}"),
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
                                    decoration:  InputDecoration(
                                        counterText: "",
                                        // suffixIcon: suffixIcons,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: "${getProfileModel?.data?.address}"),
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
                                    hint:  Text('${getProfileModel?.data?.country}'),
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
                                    onChanged: (CountryData? value) {
                                      setState(() {
                                        countryValue = value!;
                                        getstate("${countryValue!.id}");
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
                                    hint: Text('${getProfileModel?.data?.state}'),
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
                                        offset: Offset(1.0, 1.0),
                                        blurRadius: 0.2,
                                        spreadRadius: 0.5,
                                      ),
                                    ],
                                  ),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    value: cityValue,
                                    hint:  Text('${getProfileModel?.data?.city}'),
                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    // Array list of items
                                    items: cityList.map((items) {
                                      return DropdownMenuItem(value: items, child: Container(child: Text(items.name.toString())),
                                      );
                                    }).toList(),
                                    onChanged: (CityData? value) {
                                      setState(() {
                                        cityValue = value!;
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
                                    decoration:  InputDecoration(
                                        counterText: "",
                                        // suffixIcon: suffixIcons,
                                        contentPadding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: "${getProfileModel?.data?.countrycode}"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: colors.secondary, // Background color
                              onPrimary: Colors.amber, // Text Color (Foreground color)
                            ),
                            child: const Text("Update Profile", style: TextStyle(color: Colors.white, fontSize: 18)),
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
        ),
    );
  }

  File? image;

  Future getFromGallery() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    cropImage(pickedFile!.path);
  }

  Future getFromCamera() async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 80);
    cropImage(pickedFile!.path);
  }

  Future cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: filePath,
        compressQuality: 60,
        maxHeight: 1080,
        maxWidth: 1080,
        cropStyle: CropStyle.circle);
    setState(() {
      if (croppedImage != null) {
        image = File(croppedImage.path);
      }
    });
  }

  showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Choose an Option"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      getFromCamera();
                      Navigator.pop(context);
                    },
                    child:  Row(
                      children: [
                        Icon(
                          Icons.camera,
                          color: Colors.red,
                        ),
                        SizedBox(width: 8),
                        Text("Camera")
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      getFromGallery();
                      Navigator.pop(context);
                    },
                    child:  Row(
                      children: const [
                        Icon(
                          Icons.image,
                          color: Colors.red,
                        ),
                        SizedBox(width: 8),
                        Text("Gallery")
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

}
