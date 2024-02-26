import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ho_jayega_user_main/Helper/api.path.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/appBar.dart';
import '../Helper/color.dart';
import '../Model/notificationModel.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  initState() {
    super.initState();
    myFuture = getNotification();
  }

  NotificationModel? NotiList;
  getNotification() async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? user_id = sharedPreferences.getString('user_id');
      var headers = {
        'Cookie': 'ci_session=1826473be67eeb9329a8e5393f7907573d116ca1'
      };
      var request =
          http.MultipartRequest('POST', Uri.parse(ApiServicves.notification));
      request.fields.addAll({'user_id': user_id.toString()});
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var json = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        print(json.toString());
        setState(() {
          NotiList = NotificationModel.fromJson(json);
        });
      } else {
        print(response.reasonPhrase);
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

  clearNotification() async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? user_id = sharedPreferences.getString('user_id');
      var headers = {
        'Cookie': 'ci_session=1826473be67eeb9329a8e5393f7907573d116ca1'
      };
      var request =
          http.MultipartRequest('POST', Uri.parse(ApiServicves.clearNoti));
      request.fields.addAll({'user_id': user_id.toString()});
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());

        setState(() {
          getNotification();
        });
      } else {
        print(response.reasonPhrase);
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

  late Future myFuture;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.appbarColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: commonAppBar(
            context,
            text: "Notification",
            isHome: false, ontap: (){
            Navigator.pop(context);
          }
          ),
        ),
        body: FutureBuilder(
          future: myFuture,
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    Future.delayed(Duration(seconds: 2));
                    setState(() {
                      getNotification();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: NotiList!.status == 'Failed'
                        ? Center(
                            child: Text(
                              "No New Notifications",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          )
                        : Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Today",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: colors.primary,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  GestureDetector(
                                    onTap: () => clearNotification(),
                                    child: Text(
                                      "Clear all",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: colors.primary,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              ),
                              const Divider(color: Colors.transparent),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: NotiList!.notifications.length,
                                itemBuilder: (context, index) => Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 1, color: colors.primary)),
                                  child: ListTile(
                                    title: Text(
                                      NotiList!.notifications[index].title
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          NotiList!.notifications[index].message
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          DateFormat('yMMMMd')
                                              .format(NotiList!
                                                  .notifications[index].date!)
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                  ),
                ),
        ),
      ),
    );
  }
}
