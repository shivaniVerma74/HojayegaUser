import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ho_jayega_user_main/Helper/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Helper/api.path.dart';
import '../../Helper/appBar.dart';
import '../../Model/getAddress.dart';
import 'package:http/http.dart' as http;

import 'addAddress.dart';

class UpdateAddress extends StatefulWidget {
  UpdateAddress({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateAddress> createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
              backgroundColor: colors.primary,
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Addaddress(),
                    ));
              },
              child: Center(
                  child: Icon(
                Icons.add,
                color: colors.whiteTemp,
              ))),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: commonAppBar(context, isHome: false, text: "Update Address"),
          ),
          body: !isLoading
              ? RefreshIndicator(
                  onRefresh: () async {
                    getAddress();
                  },
                  child: getAddressList.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(20),
                          child: ListView.builder(
                            itemCount: getAddressList.length ?? 0,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Container(
                                      height: 110,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: colors.primary)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: colors.primary,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.7,
                                                        child: Text(
                                                          "${getAddressList[index].address}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: colors
                                                                  .primary),
                                                          maxLines: 4,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "#Flat No :",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              colors.primary),
                                                    ),
                                                    Text(
                                                      "${getAddressList[index].building ?? "0"}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              colors.primary),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Container(
                                      height: 110,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: colors.primary)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            InkWell(
                                                onTap: () {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Addaddress(
                                                                isEdit: true,
                                                                addressList:
                                                                    getAddressList[
                                                                        index]),
                                                      ));
                                                },
                                                child: Icon(
                                                  Icons.edit,
                                                  color: colors.secondary,
                                                )),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  deletePopop(
                                                      getAddressList[index]
                                                          .id
                                                          .toString());
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: colors.red,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Text('Address Not Found Please Add Address'),
                          ),
                        ))
              : Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: colors.primary,
                    ),
                  ),
                )),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddress();
  }

  bool isLoading = false;
  List<AddressList> getAddressList = [];
  getAddress() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? user_id = sharedPreferences.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=8337986a2b6d2140aa0b9f8e468d4183e289f1ac'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${ApiServicves.getAddress}'));
    request.fields.addAll({
      'user_id': user_id.toString(),
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("===my technic=======${request.url}===============");
    print("===my technic=======${request.fields}===============");
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);
      if (finalresult['response_code'] == "1") {
        getAddressList = GetAddressModel.fromJson(finalresult).data ?? [];
        setState(() {
          print("===my technic=======tttt===============");
        });
        setState(() {
          isLoading = false;
        });
      } else {
        print("===my technic=======tt===============");

        getAddressList.clear();
        setState(() {
          isLoading = false;
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> removeAddress(String addressId) async {
    setState(() {
      isLoading = true;
    });
    var headers = {
      'Cookie': 'ci_session=74718c3150fe9f22bb4bd68b9e6729bce6ff48b9'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiServicves.deleteAddress}'));
    request.fields.addAll({
      'id': addressId.toString(),
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);
      if (finalresult['response_code'] == "1") {
        Fluttertoast.showToast(msg: finalresult['msg'].toString());
        Navigator.pop(context);
        getAddress();
        setState(() {
          isLoading = false;
        });
      } else {
        print("===my technic=======tt===============");

        setState(() {
          isLoading = false;
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  void deletePopop(String OrderI) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirm Delete"),
            content: Text("Are you sure you want to Delete?"),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: colors.primary),
                child: Text("YES"),
                onPressed: () {
                  removeAddress(OrderI);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: colors.primary),
                child: Text("NO"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
