import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ho_jayega_user_main/Helper/api.path.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import '../Helper/appBar.dart';
import '../Helper/color.dart';
import '../Model/AreaModel.dart';
import 'package:http/http.dart' as http;

class PickDrop extends StatefulWidget {
  const PickDrop({super.key});

  @override
  State<PickDrop> createState() => _PickDropState();
}

class _PickDropState extends State<PickDrop> {
  String _selectedOption = 'Yes';
  var arrValue = ['Cake', 'fragile', 'Ready', 'Non'];
  Map<int, int> _radioSelections = {};
  Map<int, int> _radioSelections2 = {};

  String? _selectedItem;
  List<String> items = ['Indore', 'Bhopal', 'jaipur', 'Ujjain'];
  String? _selectedItem2;
  List<String> items2 = ['Bhopal', 'Ujjain', 'Indore', 'Jaipur'];

  File? _image;
  final picker = ImagePicker();
  Future getImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('no image picked');
      }
    });
  }

  File? packageImages;
  Widget packageImage() {
    return Card(
      elevation: 1,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        //margin: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height/6,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey.withOpacity(0.2),
            border: Border.all(color: colors.primary)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: packageImages != null
              ? Image.file(packageImages!, fit: BoxFit.cover)
              : Column(
            children: const [
              Center(
                  child: Icon(Icons.upload_file_outlined, size: 60)),
              Text("Upload")
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getArea();
  }
  Widget imagesView() {
    return Card(
      elevation: 1,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        //margin: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height/7,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white,
            border: Border.all(color: colors.primary)
        ),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: packageImages != null
                ? Image.file(packageImages!, fit: BoxFit.cover)
                : Column(
                children: const [
                Center(
                  child: Icon(Icons.upload_file_outlined, size: 60),
                ),
                Text("Upload")
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickImage(ImageSource source, String type) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      maxHeight: 100,
      maxWidth: 100,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      setState(() {
        if (type == 'uploadImage') {
          packageImages = File(pickedFile.path);
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

  TextEditingController addressCtr = TextEditingController();
  TextEditingController pickupnameCtr = TextEditingController();
  TextEditingController pickupphoneCtr = TextEditingController();
  TextEditingController typaaddressCtr = TextEditingController();
  TextEditingController dropLocationCtr = TextEditingController();
  TextEditingController dropnameCtr = TextEditingController();
  TextEditingController dropphoneCtr = TextEditingController();
  TextEditingController droptypeaddressCtr = TextEditingController();
  TextEditingController productDescriptionCtr = TextEditingController();
  TextEditingController noteCtr = TextEditingController();
  String? latitude, longitudes;
  late String myLoction = "";

  getLocation() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          apiKey: Platform.isAndroid
              ? "AIzaSyCKLIBoAca5ptn9A_1UCHNNrtzI81w2KRk"
              : "AIzaSyCKLIBoAca5ptn9A_1UCHNNrtzI81w2KRk",
          onPlacePicked: (result) {
            print(result.formattedAddress);
            setState(() {
              addressCtr.text = result.formattedAddress.toString();
              latitude = result.geometry!.location.lat.toString();
              longitudes = result.geometry!.location.lng.toString();
              myLoction = result.formattedAddress.toString();
            });
            Navigator.of(context).pop();
          },
          initialPosition: LatLng(22.719568, 75.857727),
          useCurrentLocation: true,
        ),
      ),
    );
  }

  getDropLocation() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          apiKey: Platform.isAndroid
              ? "AIzaSyCKLIBoAca5ptn9A_1UCHNNrtzI81w2KRk"
              : "AIzaSyCKLIBoAca5ptn9A_1UCHNNrtzI81w2KRk",
          onPlacePicked: (result) {
            print(result.formattedAddress);
            setState(() {
              dropLocationCtr.text = result.formattedAddress.toString();
              latitude = result.geometry!.location.lat.toString();
              longitudes = result.geometry!.location.lng.toString();
              myLoction = result.formattedAddress.toString();
            });
            Navigator.of(context).pop();
          },
          initialPosition: LatLng(22.719568, 75.857727),
          useCurrentLocation: true,
        ),
      ),
    );
  }
  List<CountryData> countryList = [];
  CountryData? countryValue;
  String? countryId;


  getArea() async {
    var headers = {
      'Cookie': 'ci_session=cb5a399c036615bb5acc0445a8cd39210c6ca648'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/hojayega/Vendorapi/get_regions'));
    request.fields.addAll({
      'city_id': '120',
    });
    print("get aresaa ${request.fields}");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responseData);
      if (mounted) {
        setState(() {
          countryList = GetAreaModel.fromJson(userData).data!;
        });
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  pickDrop() async{
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=45dba773e37254fb67da4bb622986088aa57f12d'
    };
    var request = http.Request('POST', Uri.parse(ApiServicves.pickDropOrder));
    request.body = json.encode({
      "address": "indore",
      "user_id": "1",
      "pickup_name": "Rohit",
      "pickup_mobile": "8770669964",
      "address_type": "8770669964",
      "region": "5",
      "drop_data": [
        {
          "drop_address": "dt",
          "drop_name": "rajes",
          "drop_phone": "748878",
          "drop_address_type": "dt",
          "drop_region": "5"
        }
      ]
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffE2EBFE), //colors.bgColor,
        body:SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Send Package",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Upload image",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                InkWell(
                    onTap: () {
                      showAlertDialog(context, "uploadImage");
                    },
                    child: imagesView()),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  //  color: Color(0xffEFEFEF),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffEFEFEF),
                      border: Border.all(
                        color: colors.primary,
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "PickUp Location",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Card(
                        child: Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: TextFormField(
                              onTap: () {
                                getLocation();
                              },
                              controller: addressCtr,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.map, color: colors.secondary),
                                  counterText: "",
                                  contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                  border: OutlineInputBorder(borderSide: BorderSide.none),
                                  hintText: "Select Location On Map",
                                hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
                              ),
                            ),
                        ),
                      ),
                      Card(
                        child: Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: TextFormField(
                                controller: pickupnameCtr,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person, color: colors.secondary),
                                    counterText: "",
                                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                                    border: OutlineInputBorder(borderSide: BorderSide.none),
                                    hintText: "PickUp Name",
                                    hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
                                ),
                              ),
                            ),
                        ),
                      ),
                      Card(
                        child: Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child:TextFormField(
                                controller: pickupphoneCtr,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.phone, color: colors.secondary),
                                    counterText: "",
                                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                                    border: OutlineInputBorder(borderSide: BorderSide.none),
                                    hintText: "PickUp Phone Number",
                                    hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
                                ),
                              ),
                            ),
                        ),
                      ),
                      Card(
                        child: Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: TextFormField(
                                controller: typaaddressCtr,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.location_on, color: colors.secondary),
                                    counterText: "",
                                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                                    border: OutlineInputBorder(borderSide: BorderSide.none),
                                    hintText: "Type Address",
                                    hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
                                ),
                              ),
                            ),
                        ),
                      ),
                      Card(
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                            DropdownButton(
                              isExpanded: true,
                              value: countryValue,
                              hint: const Text('Select Zone(Area'),
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
                                  countryId = countryValue!.id;
                                });
                              },
                              underline: Container(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                  Stack(
                    children: [
                      Container(
                        //  color: Color(0xffEFEFEF),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffEFEFEF),
                            border: Border.all(
                              color: colors.primary,
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Drop Details",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text(
                                "Drop Location",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Card(
                              child: Container(
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: TextFormField(
                                    onTap: () {
                                      getDropLocation();
                                    },
                                    controller: dropLocationCtr,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.map, color: colors.secondary),
                                        counterText: "",
                                        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                        border: OutlineInputBorder(borderSide: BorderSide.none),
                                        hintText: "Select Location On Map",
                                        hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              child: Container(
                                  width: double.infinity,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child:TextFormField(
                                      controller: pickupnameCtr,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.person, color: colors.secondary),
                                          counterText: "",
                                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                                          border: OutlineInputBorder(borderSide: BorderSide.none),
                                          hintText: "PickUp Name",
                                          hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
                                      ),
                                    ),
                                  )),
                            ),
                            Card(
                              child: Container(
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: TextFormField(
                                    controller: pickupphoneCtr,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.phone, color: colors.secondary),
                                        counterText: "",
                                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                                        border: OutlineInputBorder(borderSide: BorderSide.none),
                                        hintText: "PickUp Phone Number",
                                        hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              child: Container(
                                  width: double.infinity,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: TextFormField(
                                      controller: droptypeaddressCtr,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.location_on, color: colors.secondary),
                                          counterText: "",
                                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                                          border: OutlineInputBorder(borderSide: BorderSide.none),
                                          hintText: "Type Address",
                                          hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
                                      ),
                                    ),
                                  )),
                            ),
                            Card(
                              child: Container(
                                  width: double.infinity,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropdownButton(
                                      isExpanded: true,
                                      value: countryValue,
                                      hint: const Text('Select Zone(Area'),
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
                                          countryId = countryValue!.id;
                                        });
                                      },
                                      underline: Container(),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 270,
                        left: 0,
                        right: 0,
                        top: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {

                                },
                                child: Container(
                                  height: 60,
                                  width: 30,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(70), color: colors.primary),
                                    child: Icon(Icons.add, color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffFFFFFF)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Amount",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text("0rs.",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Flexible Time",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Radio<String>(
                      value: 'Yes',
                      groupValue: _selectedOption,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),
                    Text('Yes'),
                    Radio<String>(
                      value: 'No',
                      groupValue: _selectedOption,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),
                    Text('No'),
                    // Add more radio buttons here if needed
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    "Time :",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                for (int i = 0; i < 1; i++) // Assuming 5 items in the list
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List<Widget>.generate(4, (int index) {
                        // 4 radio buttons
                        return Expanded(
                          child: Row(
                            children: [
                              Radio<int>(
                                value: index,
                                groupValue: _radioSelections[i],
                                onChanged: (int? value) {
                                  setState(() {
                                    _radioSelections[i] = value!;
                                  });
                                },
                              ),
                              Icon(
                                Icons.bike_scooter,
                                color: colors.secondary,
                              ),
                              // Text("aa"),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    "Product :",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                for (int i = 0; i < 1; i++) // Assuming 5 items in the list
                  Container(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List<Widget>.generate(4, (int index) {
                        // 4 radio buttons
                        return Expanded(
                          child: Row(
                            children: [
                              Radio<int>(
                                value: index,
                                groupValue: _radioSelections2[i],
                                onChanged: (int? value) {
                                  setState(() {
                                    _radioSelections2[i] = value!;
                                  });
                                },
                              ),
                              Text(arrValue[index],
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold))
                              // Icon(Icons.bike_scooter,color:Colors.green)
                              // Text("aa"),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    "Product Description:",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Card(
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    child: TextFormField(
                      controller: productDescriptionCtr,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          counterText: "",
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                          hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    children: const [
                      Text(
                        "Note",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "(Optional)",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: TextFormField(
                      controller: noteCtr,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          counterText: "",
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                          hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60, top: 30),
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: colors.secondary,
                    ),
                    child: const Center(
                      child: Text(
                        "Next",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
