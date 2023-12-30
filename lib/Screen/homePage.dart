import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ho_jayega_user_main/Helper/api.path.dart';
import 'package:ho_jayega_user_main/Screen/ProductScreen.dart';
import '../Helper/CammonSlider.dart';
import '../Helper/color.dart';
import 'package:http/http.dart' as http;

import '../Model/GetShopsTypeModel.dart';
import '../Model/SliderMOdel.dart';
import '../Model/VendorServiceDataModel.dart';
import '../Model/VendorShopDataModel.dart';
import 'Services.dart';
import 'TopServices.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    getBanner();
    getShops();
    shopTypes();
  }

  SliderMOdel? sliderModel;
  List<SliderData> sliderList1 = [];
  List sliderList = [];

  getBanner() async {
    var headers = {
      'Cookie': 'ci_session=ec3da314aabd690ad47ed36f9337c27b856dd58e'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getBanners));
    request.fields.addAll({
      'banner_type': selected == 0 ?  'shop' : "services"
    });
    print("banner parametere ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print("this is a response===========> $result");
      sliderList1 = SliderMOdel.fromJson(json.decode(result)).data??[];
      print("this is slider===========> $sliderList1");
        setState(() {
          for(int i=0;i<sliderList1.length;i++){
            sliderList.add("${sliderList1[i].image}");
          }
        });

    } else {
      print(response.reasonPhrase);
    }
  }

  VendorShopDataModel? vendorshopdata;
  getShops() async {
    var headers = {
      'Cookie': 'ci_session=69e89a4ee64270f8f78288d7b1e45b775bee424f'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getVendors));
    request.fields.addAll({
      'type': selected == 0 ? "1" : "2"
    });
    print("get vendors parameteer ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      final finalResult = VendorShopDataModel.fromJson(json.decode(result));
      print("this is a vendor shop response===========> $finalResult");
      setState(() {
        vendorshopdata = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  VendorServiceDataModel? vendorServiceDataModel;
  getServices() async{
    var headers = {
      'Cookie': 'ci_session=3f18463b21e41caeaaf9983a1832b58ee4d9332d'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getVendors));
    request.fields.addAll({
      'type': '2'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      final finalResult = VendorServiceDataModel.fromJson(json.decode(result));
      print("this is a vendor service shop $finalResult");
      setState(() {
        vendorServiceDataModel = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  GetShopsTypeModel? shopList;
  shopTypes() async {
    var headers = {
      'Cookie': 'ci_session=845120212c455d650786e2b8765167b30278470f'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.shopsType));
    request.fields.addAll({
      'type': selected == 0 ? "shop" : "services",
    });
    print("shop type parameteres ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = GetShopsTypeModel.fromJson(json.decode(finalResponse));
      print("shop type responsee $finalResult");
      setState(() {
        shopList = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> _refresh() {
    return callApi();
  }

  Future<Null> callApi() async {
    getBanner();
    getShops();
    shopTypes();
  }

  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return
      RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            selected == 0 ?
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                              ),
                            ],
                        ),
                        child: const TextField(
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.green,
                            ),
                            hintStyle: TextStyle(
                              fontSize: 14,
                            ),
                            hintText: "Product Store etc",
                            border: InputBorder.none,
                          ),
                        ),
                    ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                    padding: const EdgeInsets.all(4.0),
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                              offset: Offset(0, 1))
                        ]),
                    child: const Center(
                        child: Text(
                      "Search By km.",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    )))
              ],
            ):
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            )
                          ],
                        ),
                        child: const TextField(
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.green,
                            ),
                            hintStyle: TextStyle(
                              fontSize: 14,
                            ),
                            hintText: "Search By Services",
                            border: InputBorder.none,
                          ),
                        ),
                    ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                    padding: const EdgeInsets.all(4.0),
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                              offset: Offset(0, 1))
                        ]),
                    child: const Center(
                        child: Text(
                          "Search By km.",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                    ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 70,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: shopList?.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return shopContainersElement(index);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 15,
                  );
                },
              ),
            ),
            Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.22,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1.0,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                  items: sliderList.map((item) => Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: item == null || item == "" ? Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                            image: AssetImage("assets/images/placeholder.png",),
                            fit: BoxFit.fill),
                      ),
                    ):
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: NetworkImage(
                              "$item",
                            ),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  ).toList(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: SizedBox(
                    width: 100,
                    height: 6,
                    child: Center(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: sliderList.length ?? 0,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 6,
                            width: 6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: index == currentIndex
                                  ? colors.primary
                                  : Colors.grey,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 5,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // CarouselSlider(
            //   options: CarouselOptions(
            //     height: MediaQuery.of(context).size.height * 0.22,
            //     aspectRatio: 16 / 9,
            //     viewportFraction: 1.0,
            //     initialPage: 0,
            //     enableInfiniteScroll: true,
            //     reverse: false,
            //     autoPlay: true,
            //     autoPlayInterval: const Duration(seconds: 3),
            //     autoPlayAnimationDuration: const Duration(milliseconds: 800),
            //     autoPlayCurve: Curves.fastOutSlowIn,
            //     enlargeCenterPage: false,
            //     onPageChanged: (index, reason) {
            //       setState(() {
            //         currentIndex = index;
            //       });
            //     },
            //   ),
            //   items: sliderList.map((item) => Padding(
            //     padding: const EdgeInsets.only(left: 5, right: 5),
            //     child: item == null || item == "" ? Container(
            //       width: MediaQuery.of(context).size.width,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(8),
            //         image: const DecorationImage(
            //             image: AssetImage("assets/images/placeholder.png",),
            //             fit: BoxFit.fill),
            //       ),
            //     ):
            //     Container(
            //       width: MediaQuery.of(context).size.width,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(8),
            //         image: DecorationImage(
            //             image: NetworkImage(
            //               "$item",
            //             ),
            //             fit: BoxFit.fill),
            //       ),
            //     ),
            //   ),
            //   ).toList(),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // Center(
            //   child: SizedBox(
            //     width: 100,
            //     height: 6,
            //     child: Center(
            //       child: ListView.separated(
            //         shrinkWrap: true,
            //         itemCount: sliderList.length ?? 0,
            //         scrollDirection: Axis.horizontal,
            //         itemBuilder: (context, index) {
            //           return Container(
            //             height: 6,
            //             width: 6,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10),
            //               color: index == currentIndex
            //                   ? colors.primary
            //                   : Colors.grey,
            //             ),
            //           );
            //         },
            //         separatorBuilder: (context, index) {
            //           return const SizedBox(
            //             width: 5,
            //           );
            //         },
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            Container(
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selected = 0;
                            });
                            shopTypes();
                            getBanner();
                            getShops();
                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                                color: selected == 0
                                    ? colors.primary
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: colors.primary)),
                            child: Center(
                              child: Text(
                                'Shops',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: selected == 0
                                        ? Colors.white
                                        : colors.primary),
                              ),
                            ),
                          ),
                        ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selected = 1;
                            });
                            shopTypes();
                            getBanner();
                            getShops();
                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                                color: selected == 1
                                    ? colors.primary
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: colors.primary)),
                            child: Center(
                              child: Text(
                                'Services',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: selected == 1
                                        ? Colors.white
                                        : colors.primary),
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
             ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Ads & Offers',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.16,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: const BoxDecoration(
                          // color: Colors.amber,
                          image: DecorationImage(image: AssetImage('assets/images/Image 35.png'), fit: BoxFit.fill),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                              topLeft: Radius.circular(5),
                          ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 15,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selected == 0 ? 'Popular Shops' : 'Top Service',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'View More',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            selected == 0 ?
            Container(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(0),
                itemCount: vendorshopdata?.user?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TopService()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                       // padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            vendorshopdata?.user?[index].profileImage == null || vendorshopdata?.user?[index].profileImage == "" ?  Container(
                                height: 130,
                                width: double.infinity,
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                    child: Image.asset("assets/images/placeholder.png", fit: BoxFit.fill),
                                ),
                            ):
                            Container(
                              height:130 ,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                    child: Image.network("${vendorshopdata?.user?[index].profileImage}", fit: BoxFit.fill,))),
                             Padding(
                               padding: const EdgeInsets.only(left: 3,right: 3),
                               child: Text(
                                '${vendorshopdata?.user?[index].storeName}',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black.withOpacity(0.8),
                                    fontWeight: FontWeight.bold),
                               ),
                             ),
                            const SizedBox(
                              height: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 3,right: 3),
                              child:
                             Row(
                               children: [
                                 RatingBar.builder(
                                   initialRating: vendorshopdata?.user?[index].revies == "" ? 0.0 : double.parse(vendorshopdata?.user?[index].revies.toString() ?? ""),
                                   minRating: 0,
                                   direction: Axis.horizontal,
                                   allowHalfRating: true,
                                   itemCount: 5,
                                   itemSize: 15,
                                   ignoreGestures: true,
                                   unratedColor: Colors.grey,
                                   itemBuilder: (context, _) => const Icon(
                                       Icons.star,
                                       color: Colors.orange),
                                   onRatingUpdate: (rating) {
                                     print(rating);
                                   },
                                 ),
                                 Text(
                                   double.parse(vendorshopdata?.user?[index].revies.toString() ?? '0.0').toStringAsFixed(1),
                                   style: TextStyle(fontSize: 12),
                                   overflow: TextOverflow.ellipsis,
                                 ),
                               ],
                             )
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 3,right: 3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '2km',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black.withOpacity(0.8),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  vendorshopdata?.user?[index].status == "1" ?
                                  const Text(
                                    'Open',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ): const Text(
                                    'Close',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ):
            Container(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(0),
                itemCount: vendorshopdata?.user?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      // padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          vendorshopdata?.user?[index].profileImage == null || vendorshopdata?.user?[index].profileImage == "" ?  Container(
                              height: 130,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                child: Image.asset("assets/images/placeholder.png", fit: BoxFit.fill),
                              )
                          ):
                          Container(
                              height:130 ,
                              width: double.infinity,
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                  child: Image.network("${vendorshopdata?.user?[index].profileImage}", fit: BoxFit.fill,))),
                          Padding(
                            padding: const EdgeInsets.only(left: 3,right: 3),
                            child: Text(
                              '${vendorshopdata?.user?[index].storeName}',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black.withOpacity(0.8),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 3,right: 3),
                              child:
                              Row(
                                children: [
                                  RatingBar.builder(
                                    initialRating: vendorshopdata?.user?[index].revies == "" ? 0.0 : double.parse(vendorshopdata?.user?[index].revies.toString() ?? ""),
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 15,
                                    ignoreGestures: true,
                                    unratedColor: Colors.grey,
                                    itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.orange),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                  Text(
                                    double.parse(vendorshopdata?.user?[index].revies.toString() ?? '0.0').toStringAsFixed(1),
                                    style: TextStyle(fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              )
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 3,right: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '5KM',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black.withOpacity(0.8),
                                      fontWeight: FontWeight.bold),
                                ),
                                vendorshopdata?.user?[index].status == "1" ?
                                const Text(
                                  'Open',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ): const Text(
                                  'Close',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )

          ],
         ),
        ),
      );
  }

  int currentIndex = 0;
  Widget shopContainersElement(index) {
    return Column(
      children: [
        Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: BorderRadius.circular(4),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey, blurRadius: 2, offset: Offset(0, 1))
              ]),
          child:  Image.network("${shopList?.data?[index].image}",)
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "${shopList?.data?[index].name}",
          textAlign: TextAlign.center,
          style: const TextStyle(color: colors.primary, fontSize: 10),
        ),
      ],
    );
  }
}
