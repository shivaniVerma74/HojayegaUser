import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../Helper/appBar.dart';
import '../Helper/color.dart';

class PickDrop extends StatefulWidget {
  const PickDrop({super.key});

  @override
  State<PickDrop> createState() => _PickDropState();
}

class _PickDropState extends State<PickDrop> {
  String _selectedOption = 'Yes';
  var arrValue = ['Cake', 'fragile', 'Ready', 'Non'];
  //final List<String> radioLabels = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
  //var index=0;
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        backgroundColor: Color(0xffE2EBFE),
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //     centerTitle: true,
        //     backgroundColor: Color(0xff112C48),
        //     foregroundColor: Colors.white, //(0xff112C48),
        //     title: Text('Pick & Drop'),
        //     shape: const RoundedRectangleBorder(
        //       borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
        //     )),

        appBar:    PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: commonAppBar(context,
              text:
              "Pick & Drop"
          ),
        ),

        body: SingleChildScrollView(
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
                    getImageGallery();
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      height: 100,
                      // width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: colors.primary),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 10),
                          //   child: _image != null
                          //       ? Image.file(_image!.absolute)
                          //       : const Icon(Icons.upload_file_outlined),
                          // ),
                          Expanded
                            (
                            child: Container(
                              height: 100,

                              child: Center(
                                child: Text(
                                  "Upload",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff5A5A5A)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
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
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.map,
                                    color: colors.secondary,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Select Location On Map",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
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
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.person,
                                    color: colors.secondary,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "PickUp Name",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
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
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.phone,
                                    color: colors.secondary,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("PickUp Phone Number",
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold)),
                                ],
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
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.location_on,
                                    color: colors.secondary,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Type Address",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
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
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: colors.secondary,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  DropdownButton<String>(
                                    autofocus: false,
                                    value: _selectedItem2,
                                    hint: const Text("Select Zone(Area)",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedItem2 = newValue;
                                      });
                                    },
                                    items: items2.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
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
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.map,
                                    color: colors.secondary,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Select Location On Map",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
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
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.person,
                                    color: colors.secondary,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "PickUp Name",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
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
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.phone,
                                    color: colors.secondary,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("PickUp Phone Number",
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold)),
                                ],
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
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.location_on,
                                    color: colors.secondary,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Type Address",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
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
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: colors.secondary,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  //  Text("Select Zone(Area)",style: TextStyle(fontWeight: FontWeight.bold),),
                                  DropdownButton<String>(
                                    autofocus: false,
                                    value: _selectedItem,
                                    hint: const Text("Select Zone(Area)",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedItem = newValue;
                                      });
                                    },
                                    items: items.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 40,
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
                                  fontWeight: FontWeight.bold, fontSize: 20)),
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
                              Icon(Icons.bike_scooter, color: colors.secondary,)
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
                              Text(
                                arrValue[index],
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold))
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
                    height: 50,
                    child: TextFormField(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: const [
                      Text(
                        "Note",
                        style:
                            TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
