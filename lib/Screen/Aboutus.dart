import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ho_jayega_user_main/Helper/api.path.dart';
import 'package:ho_jayega_user_main/Model/termsAndCondition.dart';
import 'package:http/http.dart' as http;
import '../Helper/color.dart';

class AboutUS extends StatefulWidget {
  const AboutUS({Key? key}) : super(key: key);

  @override
  State<AboutUS> createState() => _AboutUSState();
}

class _AboutUSState extends State<AboutUS> {
  TermsAndCondition? terms;
  Future<void> getPrivacyPolicy() async {
    try {
      var headers = {
        'Cookie': 'ci_session=0a68526a3ce5b251a6761ec7c01fe4892118b57b'
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://developmentalphawizz.com/hojayega/api/static_pages'));

      request.headers.addAll(headers);
      request.fields.addAll({'id': '6'});

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

  late Future myFuture;
  @override
  void initState() {
    myFuture = getPrivacyPolicy(); // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      //
      appBar: AppBar(
        backgroundColor: const Color(0xff112C48),
        title: const Text(
          "About US",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        toolbarHeight: 70,
        elevation: 6,
      ),
      body: FutureBuilder(
          future: myFuture,
          builder: (context, snap) {
            return snap.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Html(data: terms!.setting!.title.toString()),
                      Html(data: terms!.setting!.html.toString()),
                    ],
                  );
          }),
    ));
  }
}
