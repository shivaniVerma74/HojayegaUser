import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../Helper/FlutterPhoneDirectCaller.dart';
import '../Helper/api.path.dart';
import '../Model/GetProfileModel.dart';


class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();}

  bool isLoading = false;
  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id = preferences.getString('user_id');
    print("user id in profileee $user_id");
    getProfile();
  }

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController mobileCtr = TextEditingController();

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
          emailEditingController.text = getProfileModel?.data?.email ?? "";
          mobileCtr.text = getProfileModel?.data?.mobile ?? "";
          // pincodeCtr.text=getProfileModel?.data?.??"";
          isLoading = false;
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  _callNumber(String? mobileNumber) async {
    var number = "${mobileNumber}";
    print("numberrrrr ${number}");
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    print("mobileee ${res}");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
        ),
        title: Text(
          'Help & Support',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF112c48),
      ),
      body: Column(
        children: [
          SizedBox(height: 25,),
         Padding(
           padding: const EdgeInsets.only(left: 5),
           child: Card(
             elevation: 3,
             child: Container(
               height: 70,
               width: MediaQuery.of(context).size.width/1.1,
               decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Padding(
                     padding: const EdgeInsets.only(left: 5,top: 5),
                     child: Text("Email", style: TextStyle(fontWeight: FontWeight.w600),),
                   ),
                   TextFormField(
                     readOnly: true,
                     controller: emailEditingController,
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
                         hintStyle: TextStyle(fontWeight: FontWeight.w600),
                     ),
                   ),
                 ],
               ),
             ),
           ),
         ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Card(
              elevation: 3,
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width/1.1,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5,top: 5),
                      child: Text("Mobile", style: TextStyle(fontWeight: FontWeight.w600),),
                    ),
                    TextFormField(
                      onTap: () {
                        _callNumber(mobileCtr.text);
                      },
                      readOnly: true,
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
                        hintStyle: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

