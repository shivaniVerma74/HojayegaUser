import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ho_jayega_user_main/Helper/api.path.dart';
import 'package:ho_jayega_user_main/Helper/color.dart';
import 'package:ho_jayega_user_main/Model/TopServicesModel.dart';
import 'package:ho_jayega_user_main/Model/servicesMainCatModel.dart';
import 'package:ho_jayega_user_main/Screen/ServiceDetails.dart';
import 'package:http/http.dart' as http;

import '../Model/VendorShopDataModel.dart';
import '../Model/getCatForServices.dart';
import '../Model/getServicesforServicesModel.dart';

class TopService extends StatefulWidget {
  const TopService({Key? key, required this.VendorId}) : super(key: key);
  final String VendorId;
  @override
  State<TopService> createState() => _Project1State();
}

class _Project1State extends State<TopService> {
  List<Services> selectedCat = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFE2EBFE),
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
          'Categories',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF112c48),
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
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xFFFFFFFF),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.search,
                                    color: colors.secondary,
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'Search Services....',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              height: 50,
                              width: MediaQuery.of(context).size.width / 1.7,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xFF2BA530),
                              ),
                              child: Center(
                                child: Text(
                                  'Search by Km.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              height: 50,
                              width: MediaQuery.of(context).size.width / 4,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text("Select Category's",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20)),
                          ],
                        ),
                      ),
                      Category?.data == null
                          ? Center(
                              child: Text("No Data Available"),
                            )
                          : Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                  ),
                                  itemCount: Category?.data.length ??
                                      0, // Adjust the number of items as needed
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        selectedCat
                                                .contains(Category!.data[index])
                                            ? selectedCat
                                                .remove(Category!.data[index])
                                            : selectedCat
                                                .add(Category!.data[index]);

                                        setState(() {});
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: double.maxFinite,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      5,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      border: Border.all(
                                                          color: colors.primary,
                                                          width: 1),
                                                      image: DecorationImage(
                                                          onError: (exception,
                                                                  stackTrace) =>
                                                              Icon(
                                                                Icons.image,
                                                                size: 45,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                          image: NetworkImage(
                                                              Category!
                                                                  .data[index]
                                                                  .image
                                                                  .toString()),
                                                          fit: BoxFit.contain)),
                                                ),
                                                Text(
                                                  Category!.data[index].cName ??
                                                      "",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          selectedCat.contains(
                                                  Category!.data[index])
                                              ? Positioned(
                                                  top: 2,
                                                  left: 2,
                                                  child: Icon(
                                                    Icons
                                                        .check_circle_outline_rounded,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : SizedBox.shrink(),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ServiceDetails(
                                  catgories: selectedCat,
                                  vendorId: widget.VendorId),
                            ));
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(double.maxFinite, 45),
                            backgroundColor: colors.primary,
                          ),
                          child: Text(
                            "Done",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
          }),
    );
  }

  ServiceMainCat? mainCat;
  Future<void> getMainCat() async {
    try {
      var headers = {
        'Cookie': 'ci_session=0fd9e20de82e285171a3702aded4866d22408cfd'
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://developmentalphawizz.com/hojayega/api/get_service_category'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var json = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        setState(() {
          mainCat = ServiceMainCat.fromJson(json);
        });
        print(mainCat!.data.length);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e, stack) {
      print(stack);
      throw Exception(e);
    }
  }

  ServiceMainCat? Category;
  Future<void> getCategory() async {
    try {
      var headers = {
        'Cookie': 'ci_session=0fd9e20de82e285171a3702aded4866d22408cfd'
      };
      var request =
          http.MultipartRequest('POST', Uri.parse(ApiServicves.getServicesCat));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var json = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        log(json.toString());
        setState(() {
          Category = ServiceMainCat.fromJson(json);
        });
      } else {
        print(response.reasonPhrase);
      }
    } catch (e, stack) {
      print(stack);
      throw Exception(e);
    }
  }

  late Future myFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFuture = getCategory();
  }

  // bool isLoading = false;
  var serviceId;
}
