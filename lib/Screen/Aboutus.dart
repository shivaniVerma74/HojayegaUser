import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ho_jayega_user_main/Helper/api.path.dart';
import 'package:http/http.dart' as http;
import '../Helper/color.dart';

class AboutUS extends StatefulWidget {
  const AboutUS({Key? key}) : super(key: key);

  @override
  State<AboutUS> createState() => _AboutUSState();
}

class _AboutUSState extends State<AboutUS> {


  void initState() {
    // TODO: implement initState
    super.initState();
    getTermsConditions();
    getPrivacyPolicy();
  }

  var termCondition;
  var termConditionTitle;

  getTermsConditions() async {
    var headers = {
      'Cookie': 'ci_session=5139fabebb6db295c72e0ae04ffdc37238cc5f0a'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.staticpages));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('_____termconditionss${response.statusCode}');
      final result =  await response.stream.bytesToString();
      final jsonResponse = json.decode(result);
      print('______asdsadsa____$result');
      setState(() {
        termCondition = jsonResponse['setting']['html'];
        termConditionTitle = jsonResponse['setting']['title'];
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }


  getPrivacyPolicy() async{
    var headers = {
      'Cookie': 'ci_session=712aee46797e18ab634d230ac5c41b29020bdbe7'
    };
    var request = http.Request('POST', Uri.parse(ApiServicves.privacyPolicy));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }


  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
          child:Scaffold(
            // key: _key,
              appBar: AppBar(
                backgroundColor:const Color(0xff112C48),
                title: const Text(
                  "About US",
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
                toolbarHeight: 70,
                elevation: 6,
              ),
              body: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
                          "Our Terms & Conditions",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        // subtitle: Text(
                        //   "Last update january 2022",
                        //   style: TextStyle(fontSize: 10),
                        // ),
                      ),
                      Container(
                        height: 1,
                        color: Colors.grey,
                        width: MediaQuery.of(context).size.width,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          '1. Using our Service',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Lorem Ipsum is simply dummy text of the Lorem Ipsum is simply dummy text of the and typesetting industry. Lorem Ipsum Lorem Ipsum is simply dummy text of the Lorem Ipsum is simply dummy text of the Lorem Ipsum is simply dummy and typesetting industry. Lorem Ipsum industry\'s standard dummy when an unknown printer took a galley of type and scrambled it and typesetting industry. Lorem Ipsum industry\'s standard dummy since the 1500s, when an unknown printer took a galley of type',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          '2. Using our Service',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Lorem Ipsum is simply dummy text of the Lorem Ipsum is simply dummy text of the and typesetting industry. Lorem Ipsum Lorem Ipsum is simply dummy text of the Lorem Ipsum is simply dummy text of the Lorem Ipsum is simply dummy and typesetting industry. Lorem Ipsum industry\'s standard dummy when an unknown printer took a galley of type and scrambled it and typesetting industry. Lorem Ipsum industry\'s standard dummy since the 1500s, when an unknown printer took a galley of type',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                    ],
                  )
              )
          )
      );
  }
}
