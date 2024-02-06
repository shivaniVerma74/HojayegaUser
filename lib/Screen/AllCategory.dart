import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ho_jayega_user_main/Helper/api.path.dart';
import 'package:ho_jayega_user_main/Screen/MyCart.dart';
import 'package:ho_jayega_user_main/Screen/ProductDetail.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/appBar.dart';
import '../Helper/color.dart';
import '../Model/CategoryModel.dart';
import '../Model/ChildCategoryModel.dart';
import '../Model/SubCategoryModel.dart';
import '../Model/getprodutcatwise.dart';
import 'Cart.dart';
import 'bottomScreen.dart';

class AllCategory extends StatefulWidget {
  String? ShopId;
  AllCategory({super.key, this.ShopId});

  @override
  State<AllCategory> createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  @override
  void initState() {
    super.initState();
    getShopCategory();
    getSubCat();
    getChildCat();
  }

  CategoryModel? categoryModel;
  List<CategoryData> categoryList1 = [];
  List<String> categoryImageList = [];
  List<String> categoryNameList = [];

  String? Selectcat = "0";

  bool isLoading = false;
  getShopCategory() async {
    setState(() {
      isLoading = true;
    });
    var headers = {
      'Cookie': 'ci_session=70c618f5670ba3cd3a735fde130cab16e002a8af'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiServicves.getShopCategories));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("===my technic=======${request.fields}===============");
    print("===my technic=======${request.url}===============");
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print("this is a response===========> $result");
      var finalresult = jsonDecode(result);
      if (finalresult['response_code'] == "1") {
        categoryList1 = CategoryModel.fromJson(json.decode(result)).data ?? [];
        print("this is category slider===========> $categoryList1");
        setState(() {
          for (int i = 0; i < categoryList1.length; i++) {
            categoryImageList.add(categoryList1[i].image ?? '');
            categoryNameList.add(categoryList1[i].cName ?? '');
            setState(() {});
          }
        });
        Selectcat = categoryList1[0].id;
        getSubCat();
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print("===my technic=======cat not found==============");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  String? subcatid = "0";
  SubCategoryModel? subCatData;
  getSubCat() async {
    var headers = {
      'Cookie': 'ci_session=bc5faeb8b724ab48c93561cf6ee609d9ec876621'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getSubCategories));
    request.fields.addAll({'cat_id': Selectcat.toString()});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("===my technic=======${request.fields}===============");
    print("===my technic=======${request.url}===============");
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      print("===my technic=======$finalResponse===============");
      var dinalresult = jsonDecode(finalResponse);
      if (dinalresult['response_code'] == "1") {
        subCatData = SubCategoryModel.fromJson(dinalresult);
        subcatid = subCatData?.data?[0].id;
        getChildCat();
        setState(() {});
      } else {
        setState(() {
          subCatData = null;
          subcatid = null;

          getChildCat();
        });
        print("===my technic=======vsub cat not found===============");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  String? chidcatId = "0";
  ChildCategoryModel? childCategoryModel;
  getChildCat() async {
    var headers = {
      'Cookie': 'ci_session=e456fb4275aab002e5eb6c860cc3811ebb3a9fa7'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.childCategories));
    request.fields.addAll({'cat_id': subcatid.toString()});

    request.headers.addAll(headers);
    print("===my technic=======${request.fields}===============");
    print("===my technic=======${request.url}===============");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      var finalresult = jsonDecode(finalResponse);
      if (finalresult['response_code'] == "1") {
        childCategoryModel = ChildCategoryModel.fromJson(finalresult);
        chidcatId = childCategoryModel?.data?[0].id;
        getProduct();
        setState(() {});
      } else {
        setState(() {
          childCategoryModel = null;
          chidcatId = null;
          getProduct();
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  GerProductcatWise? gerProductcatWise;
  List<Product> productList = [];

  bool isLoading2 = false;
  getProduct() async {
    setState(() {
      isLoading2 = true;
    });
    var headers = {
      'Cookie': 'ci_session=e456fb4275aab002e5eb6c860cc3811ebb3a9fa7'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiServicves.getProductCatwise));
    request.fields.addAll({
      'cat_id': Selectcat.toString(),
      'sub_id': subcatid.toString(),
      'child_id': chidcatId.toString(),
      'vendor_id': widget.ShopId.toString()
    });
    request.headers.addAll(headers);
    print("===my technic=======${request.fields}===============");
    print("===my technic=======${request.url}==========Navigatorinit=====");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      var finalresult = jsonDecode(finalResponse);
      if (finalresult['status'] == "1") {
        productList =
            GerProductcatWise.fromJson(json.decode(finalResponse)).products ??
                [];
        setState(() {
          isLoading2 = false;
        });
      } else {
        setState(() {
          isLoading2 = false;
        });
        productList.clear();
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: commonAppBar(context, text: "Products"),
        ),
        backgroundColor: colors.appbarColor,
        body: !isLoading
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
//
//         SingleChildScrollView(
//          scrollDirection: Axis.horizontal,
//           child: Row(
//             children: categoryImageList.map((e) {
// print("===my technic=======${e}===============");              var item = e ;
//               return
//
//
//                 Column(
//                 children: [
//                   Padding(
//                   padding: const EdgeInsets.only(left: 3, right: 3),
//                   child:
//                   // item == null || item == "" ?
//
//                   Container(
//                     height: 100,
//                     // width: MediaQuery.of(context).size.width,
//                     width: 100,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       image: const DecorationImage(
//                           image: AssetImage("assets/images/3.png",),
//                           fit: BoxFit.fill),
//                     ),
//                   )
//
//                   //     :
//                   // Container(
//                   //   //width: MediaQuery.of(context).size.width,
//                   //   width: 110,
//                   //   height: 100,
//                   //   decoration: BoxDecoration(
//                   //     borderRadius: BorderRadius.circular(8),
//                   //     image: DecorationImage(
//                   //         image: NetworkImage(item,),
//                   //         fit: BoxFit.fill),
//                   //     ),
//                   //   ),
//
//
//
//                   ),
//
//                 ],
//               );
//             },).toList()
//           ),
//          ),
                    Container(
                      height: 110,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryImageList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                Selectcat = categoryList1[index].id;
                              });

                              getSubCat();
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Stack(
                                    children: [
                                      Container(
                                        //width: MediaQuery.of(context).size.width,
                                        width: 90,
                                        height: 90,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border:
                                              Border.all(color: colors.primary),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  '${categoryImageList[index]}'),
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                      Selectcat == categoryList1[index].id
                                          ? Positioned(
                                              top: 6,
                                              left: 6,
                                              child: Container(
                                                //width: MediaQuery.of(context).size.width,
                                                width: 20,
                                                height: 20,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.green,
                                                ),
                                                child: const Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.all(2),
                                                    child: Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                      size: 15,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                                Text(
                                  categoryNameList[index],
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: colors.text1,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 6,
                    ),
                    Center(
                      child: SizedBox(
                        width: 100,
                        height: 6,
                        child: Center(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: categoryImageList.length ?? 0,
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
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            'Sub Category',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: size.height * 0.57,
                              width: size.width * 0.3,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(25)),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: subCatData?.data?.isNotEmpty ?? false
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount:
                                                subCatData?.data?.length ?? 0,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    subcatid = subCatData
                                                        ?.data?[index].id;
                                                  });
                                                  getChildCat();
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Column(
                                                    children: [
                                                      subCatData?.data?[index]
                                                                      .image ==
                                                                  null ||
                                                              subCatData
                                                                      ?.data?[
                                                                          index]
                                                                      .image ==
                                                                  ""
                                                          ? Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              child:
                                                                  Image.asset(
                                                                "assets/images/placeholder.png",
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            )
                                                          : Stack(
                                                              children: [
                                                                Container(
                                                                  height: 60,
                                                                  width: 80,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: Colors
                                                                        .white,
                                                                    image:
                                                                        DecorationImage(
                                                                      image: NetworkImage(
                                                                          '${subCatData?.data?[index].image}'),
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),
                                                                ),
                                                                subcatid ==
                                                                        subCatData
                                                                            ?.data?[
                                                                                index]
                                                                            .id
                                                                    ? Positioned(
                                                                        top: 6,
                                                                        left: 6,
                                                                        child:
                                                                            Container(
                                                                          //width: MediaQuery.of(context).size.width,
                                                                          width:
                                                                              20,
                                                                          height:
                                                                              20,
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color:
                                                                                Colors.green,
                                                                          ),
                                                                          child:
                                                                              const Center(
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.all(2),
                                                                              child: Icon(
                                                                                Icons.check,
                                                                                color: Colors.white,
                                                                                size: 15,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : const SizedBox
                                                                        .shrink(),
                                                              ],
                                                            ),
                                                      Text(
                                                        "${subCatData?.data?[index].cName}",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })
                                        : Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2.5,
                                            child: const Center(
                                                child: Text("Data Not Found"))),
                                  ),
                                  Container(
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5)),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0XFF112c48),
                                        // shape: RoundedRectangleBorder(),
                                      ),
                                      onPressed: () {},
                                      child: const Text(
                                        'More',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    // height: size.height * 0.57,
                                    width: size.width * 0.7,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                         Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Text(
                                                'Child category',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: colors.text1),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 50,
                                          child: childCategoryModel
                                                      ?.data?.isNotEmpty ??
                                                  false
                                              ? ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: childCategoryModel
                                                          ?.data?.length ??
                                                      0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          chidcatId =
                                                              childCategoryModel
                                                                  ?.data?[index]
                                                                  .id;
                                                        });
                                                        getProduct();
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 90,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border: Border.all(
                                                                    color: chidcatId ==
                                                                            childCategoryModel
                                                                                ?.data?[
                                                                                    index]
                                                                                .id
                                                                        ? colors
                                                                            .secondary
                                                                        : Colors
                                                                            .black,
                                                                    width: 3),
                                                                color: const Color(
                                                                    0XFF112c48),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  '${childCategoryModel?.data?[index].cName}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  })
                                              : Center(
                                                  child: Text('Data Not Found'),
                                                ),
                                        ),
                                        SingleChildScrollView(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 5, right: 5),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3.6,
                                            width: 230,
                                            child: !isLoading2
                                                ? productList.isNotEmpty
                                                    ? GridView.builder(
                                                        gridDelegate:
                                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          crossAxisSpacing: 10,
                                                          mainAxisSpacing: 10,
                                                          mainAxisExtent: 260,
                                                        ),
                                                        itemCount:
                                                            productList.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return InkWell(
                                                            onTap: () {
                                                              // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(productId: productList[index],vendorId: widget.ShopId.toString(),)));
                                                            },
                                                            child: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 0),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: Colors
                                                                      .white),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  InkWell(
                                                                    onTap: () {
                                                                      Navigator.pushReplacement(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => ProductDetails(
                                                                                    productId: productList[index],
                                                                                    vendorId: widget.ShopId.toString(),
                                                                                  )));
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              5),
                                                                      child:
                                                                          CarouselSlider(
                                                                        options:
                                                                            CarouselOptions(
                                                                          height:
                                                                              50,
                                                                          aspectRatio:
                                                                              16 / 9,
                                                                          viewportFraction:
                                                                              1.0,
                                                                          initialPage:
                                                                              0,
                                                                          enableInfiniteScroll:
                                                                              true,
                                                                          reverse:
                                                                              false,
                                                                          autoPlay:
                                                                              true,
                                                                          autoPlayInterval:
                                                                              const Duration(seconds: 3),
                                                                          autoPlayAnimationDuration:
                                                                              const Duration(milliseconds: 800),
                                                                          autoPlayCurve:
                                                                              Curves.fastOutSlowIn,
                                                                          enlargeCenterPage:
                                                                              false,
                                                                          onPageChanged:
                                                                              (index, reason) {
                                                                            setState(() {
                                                                              currentIndex = index;
                                                                            });
                                                                          },
                                                                        ),
                                                                        items: productList[index]
                                                                            .productImage
                                                                            ?.map(
                                                                              (item) => Padding(
                                                                                padding: const EdgeInsets.only(left: 5, right: 5),
                                                                                child: Container(
                                                                                  width: MediaQuery.of(context).size.width,
                                                                                  decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(8),
                                                                                      image: DecorationImage(
                                                                                          image: NetworkImage(
                                                                                            "${item}",
                                                                                          ),
                                                                                          fit: BoxFit.fill)),
                                                                                ),
                                                                              ),
                                                                            )
                                                                            .toList(),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          100,
                                                                      height: 6,
                                                                      child:
                                                                          Center(
                                                                        child: ListView
                                                                            .separated(
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemCount:
                                                                              productList[index].productImage?.length ?? 0,
                                                                          scrollDirection:
                                                                              Axis.horizontal,
                                                                          itemBuilder:
                                                                              (context, index) {
                                                                            return Container(
                                                                              height: 6,
                                                                              width: 6,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(10),
                                                                                color: index == currentIndex ? colors.secondary : const Color(0xffFEE9E9E9),
                                                                              ),
                                                                            );
                                                                          },
                                                                          separatorBuilder:
                                                                              (context, index) {
                                                                            return const SizedBox(
                                                                              width: 5,
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  // ClipRRect(
                                                                  //   child: Image.network("${productList[index].productImage}", height: 110),
                                                                  // ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            '${productList[index].productName}',
                                                                            style: const TextStyle(
                                                                                color: colors.primary,
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.w600)),
                                                                        Text(
                                                                          "${productList[index].unit ?? ""}kg",
                                                                          style: TextStyle(
                                                                              color: colors.primary,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 16),
                                                                        ),
                                                                        Text(
                                                                          "\u{20B9} ${productList[index].sellingPrice}",
                                                                          style: TextStyle(
                                                                              color: colors.primary,
                                                                              fontSize: 13),
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text("\u{20B9} ${productList[index].productPrice}",
                                                                                style: TextStyle(color: colors.primary, decoration: TextDecoration.lineThrough, fontSize: 16)),
                                                                            Spacer(),
                                                                            sddtocart == productList[index].productId
                                                                                ? SizedBox.shrink()
                                                                                : InkWell(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        increment = 1;
                                                                                        sddtocart = productList[index].productId;
                                                                                      });
                                                                                    },
                                                                                    child: Container(
                                                                                      alignment: Alignment.bottomRight,
                                                                                      height: 20,
                                                                                      width: 50,
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: colors.secondary),
                                                                                      child: Center(
                                                                                        child: const Text(
                                                                                          'Add',
                                                                                          style: TextStyle(color: Colors.white),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                          ],
                                                                        ),
                                                                        sddtocart ==
                                                                                productList[index].productId
                                                                            ? Column(
                                                                                children: [
                                                                                  SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  Container(
                                                                                    height: 20,
                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: colors.secondary),
                                                                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                                      SizedBox(),
                                                                                      InkWell(
                                                                                          onTap: () {
                                                                                            decrementfun();
                                                                                          },
                                                                                          child: Icon(
                                                                                            Icons.remove,
                                                                                            color: colors.whiteTemp,
                                                                                          )),
                                                                                      Text(
                                                                                        "${increment.toString()}",
                                                                                        style: TextStyle(color: colors.whiteTemp),
                                                                                      ),
                                                                                      InkWell(
                                                                                          onTap: () {
                                                                                            incrementfun();
                                                                                          },
                                                                                          child: Icon(
                                                                                            Icons.add,
                                                                                            color: colors.whiteTemp,
                                                                                          )),
                                                                                      SizedBox(),
                                                                                    ]),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  InkWell(
                                                                                    onTap: () {
                                                                                      addTocart(productList[index].productId.toString());
                                                                                    },
                                                                                    child: Container(
                                                                                      height: 20,
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: colors.secondary),
                                                                                      child: Center(
                                                                                        child: const Text(
                                                                                          'Add To Cart',
                                                                                          style: TextStyle(color: Colors.white),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            : SizedBox.shrink(),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      )
                                                    : Center(
                                                        child: Text(
                                                            'Product Not Found'),
                                                      )
                                                : Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            5,
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: colors.primary,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 93,
                                        ),
                                        Center(
                                          child: Container(
                                            height: 45,
                                            width: 200,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.green),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Cart()));
                                              },
                                              child: const Text(
                                                'Buy',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: CircularProgressIndicator(
                    color: colors.primary,
                  ),
                ),
              ),
      ),
    );
  }

  buildproduct({required int index, required String name}) => Container(
        width: 90,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0XFF112c48), borderRadius: BorderRadius.circular(8)),
        child: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
      );

  int increment = 1;
  var sddtocart;
  void incrementfun() {
    increment++;
    setState(() {});
  }

  void decrementfun() {
    if (increment > 1) {
      increment--;
      setState(() {});
    }
  }

  Future<void> addTocart(String productIddd) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? user_id = sharedPreferences.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=d09fc39a8b8a97b07417a28e972b458e44a87757'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiServicves.baseUrl}add_to_cart'));

    request.fields.addAll({
      'user_id': "${user_id.toString()}",
      'product_id': '${productIddd.toString()}',
      'quantity': "${increment.toString()}",
      'vendor_id': '${widget.ShopId.toString()}'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("===my technic=======${request.fields}===============");
    print("===my technic=======${request.url}===============");
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print("===my technic=======${result}===============");

      var finalresult = jsonDecode(result);

      if (finalresult['response_code'] == "1") {
        Fluttertoast.showToast(msg: "${finalresult['message']}");

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomNavBar()));
      } else {
        Fluttertoast.showToast(msg: "${finalresult['message']}");
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
