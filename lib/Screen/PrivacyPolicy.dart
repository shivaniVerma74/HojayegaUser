import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ho_jayega_user_main/Model/privacyPolicy.dart';
import '../Helper/color.dart';
import 'package:http/http.dart' as http;

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  PrivacyPolicy? privacyPolicy;
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
  @override
  void initState() {
    myFuture = getPrivacyPolicy(); // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // key: _key,
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
        body: FutureBuilder(
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
                          const SizedBox(
                            height: 20,
                          ),
                          Html(data: privacyPolicy!.setting!.data.toString()),
                          Html(
                              data: privacyPolicy!.setting!.discription
                                  .toString()),
                        ],
                      ),
                    );
            }),
      ),
    );
  }
}
