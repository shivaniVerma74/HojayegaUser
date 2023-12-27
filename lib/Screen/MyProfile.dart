import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../Helper/color.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
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

@override
void initState() {
  super.initState();

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
              SizedBox(height: 10,),
              Center(
                child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                  // CircleAvatar(
                  //   backgroundColor: Colors.white,
                  //   backgroundImage: image == null
                  //       ?  Image.file("${getProfileModel?.data?.first.proPic}")
                  //       : Image.file(image!).image, radius: 56,
                  // ),
                  GestureDetector(
                    onTap: showImageDialog,
                    child: Container(
                      height: 110,
                      width: 110,
                      padding: EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                      ),
                      child: Image.asset("assets/images/bike.png", fit: BoxFit.fill,)
                    ),
                  ),
                ]),
              ),
              const Positioned(
                left: 50,
                  bottom: 100,
                  right: 0,
                  top: 0,
                  child: Icon(Icons.edit, color: colors.primary,),
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
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
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
                        //             "assets/images/Password.png",
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
                        //                 offset: Offset(
                        //                   1.0,
                        //                   1.0,
                        //                 ),
                        //                 blurRadius: 0.2,
                        //                 spreadRadius: 0.5,
                        //               ),
                        //             ],
                        //           ),
                        //           child: TextFormField(
                        //             obscureText: isVisible ? false : true,
                        //             maxLength: 10,
                        //             controller: passwordEditingController,
                        //             keyboardType: TextInputType.text,
                        //             decoration:  InputDecoration(
                        //                 counterText: "",
                        //                 suffixIcon: IconButton(
                        //                   onPressed: () {
                        //                     setState(() {
                        //                       isVisible
                        //                           ? isVisible = false
                        //                           : isVisible = true;
                        //                     });
                        //                   },
                        //                   icon: Icon(
                        //                     isVisible ? Icons.remove_red_eye : Icons.visibility_off,
                        //                     color: Colors.green,
                        //                   ),
                        //                 ),
                        //                 // suffixIcon: suffixIcons,
                        //                 contentPadding: const EdgeInsets.symmetric(
                        //                     vertical: 5, horizontal: 5),
                        //                 border: OutlineInputBorder(
                        //                     borderSide: BorderSide.none),
                        //                 hintText: "Password"),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       left: 10, right: 10, top: 20),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Material(
                        //         elevation: 4,
                        //         borderRadius: BorderRadius.circular(10),
                        //         child: Container(
                        //             width: 40,
                        //             height: 40,
                        //             child: Image.asset(
                        //               "assets/images/Password.png",
                        //               scale: 1.4,
                        //             )),
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
                        //                 offset: Offset(
                        //                   1.0,
                        //                   1.0,
                        //                 ),
                        //                 blurRadius: 0.2,
                        //                 spreadRadius: 0.5,
                        //               ),
                        //             ],
                        //           ),
                        //           child: TextFormField(
                        //             obscureText: isVisible2 ? false: true,
                        //             maxLength: 10,
                        //             controller: cPasswordEditingController,
                        //             keyboardType: TextInputType.text,
                        //             decoration:  InputDecoration(
                        //                 counterText: "",
                        //                 suffixIcon: IconButton(
                        //                   onPressed: () {
                        //                     setState(() {
                        //                       isVisible2
                        //                           ? isVisible2 = false
                        //                           : isVisible2 = true;
                        //                     });
                        //                   },
                        //                   icon: Icon(
                        //                     isVisible2
                        //                         ? Icons.remove_red_eye
                        //                         : Icons.visibility_off,
                        //                     color: Colors.green,
                        //                   ),
                        //                 ),
                        //                 // suffixIcon: suffixIcons,
                        //                 contentPadding: const EdgeInsets.symmetric(
                        //                     vertical: 5, horizontal: 5),
                        //                 border: const OutlineInputBorder(
                        //                     borderSide: BorderSide.none),
                        //                 hintText: "Confirm Password"),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
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
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
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
                        //             borderRadius: BorderRadius.circular(5),
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
                        //           child: DropdownButton(
                        //             isExpanded: true,
                        //             value: countryValue,
                        //             hint: const Text('Country'),
                        //             // Down Arrow Icon
                        //             icon: const Icon(Icons.keyboard_arrow_down),
                        //             // Array list of items
                        //             items: countryList.map((items) {
                        //               return
                        //                 DropdownMenuItem(
                        //                   value: items,
                        //                   child: Container(
                        //                       child: Text(items.name.toString())),
                        //                 );
                        //             }).toList(),
                        //             // After selecting the desired option,it will
                        //             // change button value to selected value
                        //             onChanged: (CountryData? value) {
                        //               setState(() {
                        //                 countryValue = value!;
                        //                 getstate("${countryValue!.id}");
                        //                 // ("${stateValue!.id}");
                        //                 // stateName = stateValue!.name;
                        //                 // print("name herererb $stateName");
                        //               });
                        //             },
                        //             underline: Container(),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Material(
                        //         elevation: 4,
                        //         borderRadius: BorderRadius.circular(10),
                        //         child: Container(
                        //             width: 40,
                        //             height: 40,
                        //             child: Image.asset(
                        //               "assets/images/State.png",
                        //               scale: 1.4,
                        //             )),
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
                        //                 offset: Offset(
                        //                   1.0,
                        //                   1.0,
                        //                 ),
                        //                 blurRadius: 0.2,
                        //                 spreadRadius: 0.5,
                        //               ),
                        //             ],
                        //           ),
                        //           child: DropdownButton(
                        //             isExpanded: true,
                        //             value: stateValue,
                        //             hint: const Text('State'),
                        //             // Down Arrow Icon
                        //             icon: const Icon(Icons.keyboard_arrow_down),
                        //             // Array list of items
                        //             items: stateList.map((items) {
                        //               return
                        //                 DropdownMenuItem(
                        //                   value: items,
                        //                   child: Container(
                        //                       child: Text(items.name.toString())),
                        //                 );
                        //             }).toList(),
                        //             onChanged: (StataData? value) {
                        //               setState(() {
                        //                 stateValue = value!;
                        //                 getCity("${stateValue!.id}");
                        //                 stateName = stateValue!.name;
                        //                 print("name herererb $stateName");
                        //               });
                        //             },
                        //             underline: Container(),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Material(
                        //         elevation: 4,
                        //         borderRadius: BorderRadius.circular(10),
                        //         child: Container(
                        //             width: 40,
                        //             height: 40,
                        //             child: Image.asset(
                        //               "assets/images/City.png",
                        //               scale: 1.4,
                        //             )),
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
                        //                 offset: Offset(
                        //                   1.0,
                        //                   1.0,
                        //                 ),
                        //                 blurRadius: 0.2,
                        //                 spreadRadius: 0.5,
                        //               ),
                        //             ],
                        //           ),
                        //           child: DropdownButton(
                        //             isExpanded: true,
                        //             value: cityValue,
                        //             hint: const Text('City'),
                        //             // Down Arrow Icon
                        //             icon: const Icon(Icons.keyboard_arrow_down),
                        //             // Array list of items
                        //             items: cityList.map((items) {
                        //               return DropdownMenuItem(value: items, child: Container(child: Text(items.name.toString())),
                        //               );
                        //             }).toList(),
                        //             // After selecting the desired option,it will
                        //             // change button value to selected value
                        //             onChanged: (CityData? value) {
                        //               setState(() {
                        //                 cityValue = value!;
                        //                 // getCity("${stateValue!.id}");
                        //                 // stateName = stateValue!.name;
                        //                 // print("name herererb $stateName");
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
                              // userRegister();
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
