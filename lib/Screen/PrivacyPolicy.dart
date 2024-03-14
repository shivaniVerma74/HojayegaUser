import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ho_jayega_user_main/Model/privacyPolicy.dart';
import '../Helper/color.dart';
import 'package:http/http.dart' as http;

import '../Model/termsAndCondition.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  PrivacyPolicy? privacyPolicy;
  bool policy=false;
  bool termsCondition=false;
  Future<void> getPrivacyPolicy() async {
    try {
      var headers = {
        'Cookie': 'ci_session=0a68526a3ce5b251a6761ec7c01fe4892118b57b'
      };
      var request = http.Request(
          'POST',
          Uri.parse(
              'https://developmentalphawizz.com/hojayega/api/pages/privacy_policy'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var json = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        print(json);
        privacyPolicy = PrivacyPolicy.fromJson(json);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

  late Future myFuture;
  TermsAndCondition? terms;
  Future<void> getTermsAndConditions() async {
    try {
      var headers = {
        'Cookie': 'ci_session=0a68526a3ce5b251a6761ec7c01fe4892118b57b'
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://developmentalphawizz.com/hojayega/api/pages/static_pages'));

      request.headers.addAll(headers);
      request.fields.addAll({'id': '3'});

      http.StreamedResponse response = await request.send();
      var json = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        print(json);
        terms = TermsAndCondition.fromJson(json);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

  late Future myFutureTD;
  @override
  void initState() {
    myFuture = getPrivacyPolicy(); // TODO: implement initState
    myFutureTD = getTermsAndConditions(); //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //
        appBar: AppBar(
          backgroundColor: Color(0xff112C48),
          title: const Text(
            "Privacy Policy",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          toolbarHeight: 70,
          elevation: 6,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  if(policy==true)
                    policy=false;
                  else
                    policy=true;
                  setState(() {

                  });

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colors.primary.withOpacity(.5)

                    ),
                    child: Center(child: Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Privacy Policy",style: TextStyle(fontSize: 20,color: colors.whiteTemp),),
                          Icon(policy==false?Icons.arrow_drop_down:Icons.arrow_drop_up,size: 30,)
                        ],
                      ),
                    )),
                  ),
                ),
              ),
              if(policy==true)
              FutureBuilder(
                  future: myFuture,
                  builder: (context, snap) {
                    return snap.connectionState == ConnectionState.waiting
                        ? Center(
                            child: CircularProgressIndicator(
                            backgroundColor: colors.primary,
                          ))
                        : Container(
                            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                            decoration: const BoxDecoration(
                              // const BorderRadius.all(Radius.Radius),
                              border: Border(
                                top: BorderSide(
                                  //  BorderRadius.all(Radius.Radius),
                                  color: colors.primary,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const ListTile(
                                  title: Text(
                                    "Our Privacy Policy",
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "Last update january 2022",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  color: Colors.grey,
                                  width: MediaQuery.of(context).size.width,
                                ),
                                // const SizedBox(
                                //   height: 20,
                                // ),
                              //  Html(data: privacyPolicy!.setting!.data.toString()),
                                Html(
                                    data: privacyPolicy!.setting!.discription
                                        .toString()),
                              ],
                            ),
                          );
                  }),
              InkWell(
                onTap: (){
                  if(termsCondition==true)
                    termsCondition=false;
                  else
                    termsCondition=true;
                  setState(() {

                  });

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: colors.primary.withOpacity(.5)

                    ),
                    child: Center(child: Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Terms and Conditions",style: TextStyle(fontSize: 20,color: colors.whiteTemp),),
                          Icon(termsCondition==false?Icons.arrow_drop_down:Icons.arrow_drop_up,size: 30,)
                        ],
                      ),
                    )),
                  ),
                ),
              ),
              if(termsCondition==true)
              FutureBuilder(
                  future: myFutureTD,
                  builder: (context, snap) {
                    return snap.connectionState == ConnectionState.waiting
                        ? Center(
                      child: CircularProgressIndicator(),
                    )
                        : Column(
                      children: [
                        // Html(data: terms!.setting!.title.toString(),style: {
                        //   "body": Style(
                        //       fontSize: FontSize(20.0),
                        //      // fontFamily: "rubic",
                        //       color: Colors.black,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        //   "h2": Style(
                        //     fontSize: FontSize(16.0),
                        //     fontFamily: "rubic",
                        //     color: Colors.black,
                        //
                        //     //fontWeight: FontWeight.bold,
                        //   ),
                        //   "h1": Style(
                        //     fontSize: FontSize(16.0),
                        //     fontFamily: "rubic",
                        //     color: Colors.black,
                        //
                        //     //fontWeight: FontWeight.bold,
                        //   ),
                        // } ),
                        Html(data: terms!.setting!.html.toString()),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
