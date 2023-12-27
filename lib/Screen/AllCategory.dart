import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ho_jayega_user_main/Helper/api.path.dart';
import 'package:ho_jayega_user_main/Screen/ProductDetail.dart';
import 'package:http/http.dart' as http;

import '../Helper/color.dart';
import '../Model/CategoryModel.dart';
import '../Model/ChildCategoryModel.dart';
import '../Model/SubCategoryModel.dart';

class AllCategory extends StatefulWidget {
  const AllCategory({super.key});

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
  List <String> categoryImageList = [];
  List <String> categoryNameList = [];

  getShopCategory() async {
    var headers = {
      'Cookie': 'ci_session=70c618f5670ba3cd3a735fde130cab16e002a8af'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getShopCategories));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print("this is a response===========> $result");
      categoryList1 = CategoryModel.fromJson(json.decode(result)).data??[];
      print("this is category slider===========> $categoryList1");
      setState(() {
        for(int i=0;i<categoryList1.length;i++){
          categoryImageList.add(categoryList1[i].image ?? '');
          categoryNameList.add(categoryList1[i].cName ?? '');
          print("imageg ${categoryList1[i].image}");
        }
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  SubCategoryModel? subCatData;
  getSubCat() async {
    var headers = {
      'Cookie': 'ci_session=bc5faeb8b724ab48c93561cf6ee609d9ec876621'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getSubCategories));
    request.fields.addAll({
      'cat_id': '10'
    });
    print("seb category parameteer ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = SubCategoryModel.fromJson(json.decode(finalResponse));
      print("sub category responsee $finalResult");
      setState(() {
        subCatData = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  ChildCategoryModel? childCategoryModel;
  getChildCat() async{
    var headers = {
      'Cookie': 'ci_session=e456fb4275aab002e5eb6c860cc3811ebb3a9fa7'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.childCategories));
    request.fields.addAll({
      'cat_id': '11'
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = ChildCategoryModel.fromJson(json.decode(finalResponse));
      print("child category responsee $finalResult");
      setState(() {
        childCategoryModel = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

 int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colors.appbarColor,
      body: Column(
        children: [
          const SizedBox(height: 10),
        SingleChildScrollView(
         scrollDirection: Axis.horizontal,
          child: Row(
            children: categoryImageList.map((e) {
              print(e);
              var item = e ;
              return Column(
                children: [
                  Padding(
                  padding: const EdgeInsets.only(left: 3, right: 3),
                  child:
                  item == null || item == "" ? Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                          image: AssetImage("assets/images/placeholder.png",),
                          fit: BoxFit.fill),
                    ),
                  ):
                  Container(
                    //width: MediaQuery.of(context).size.width,
                    width: 110,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: NetworkImage(item,),
                          fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ],
              );
            },).toList()
          ),
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
                            :Colors.grey,
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                      borderRadius: BorderRadius.only(topRight: Radius.circular(25)),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: subCatData?.data?.length ?? 0,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      subCatData?.data?[index].image == null || subCatData?.data?[index].image == "" ? Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child: Image.asset(
                                          "assets/images/placeholder.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ):
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child: Image.network(
                                          '${subCatData?.data?[index].image}',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text("${subCatData?.data?[index].cName}", style: TextStyle(fontWeight: FontWeight.w500),),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        Container(
                          width: 100,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0XFF112c48),
                                // shape: RoundedRectangleBorder(),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'More',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.57,
                          width: size.width * 0.7,
                          // color: Colors.orange,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: 30,
                                  child: const Text(
                                    'Child category',
                                    style: TextStyle(fontSize: 18),
                                  ),
                              ),
                              Container(
                                height: 50,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 4,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 90,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(color: Colors.black),
                                                  color: const Color(0XFF112c48),
                                                ),
                                                child: const Center(
                                                    child: Text(
                                                  'Data',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                 ),
                                                ),
                                              ),
                                            ],
                                          ),
                                      );
                                    }),
                              ),
                              SingleChildScrollView(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5, right: 5),
                                  height: 210,
                                  width: 280,
                                  child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                            mainAxisExtent: 190,
                                        ),
                                    itemCount: childCategoryModel?.data?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          margin: const EdgeInsets.only(top: 0),
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(5),
                                                  topLeft: Radius.circular(5),
                                              ),
                                              color: Colors.white),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              childCategoryModel?.data?[index].image == null ||  childCategoryModel?.data?[index].image == "" ?
                                              ClipRRect(
                                                child: Image.asset("assets/images/placeholder.png", height: 110),
                                              ):
                                              ClipRRect(
                                                child: Image.network("${childCategoryModel?.data?[index].image}", height: 110),
                                              ),
                                               Padding(
                                                 padding: const EdgeInsets.only(left: 3),
                                                 child: Column(
                                                   children: [
                                                     Text(
                                                       '${childCategoryModel?.data?[index].cName} ',
                                                       style: const TextStyle(color: colors.primary, fontSize: 15, fontWeight: FontWeight.w600)),
                                                     const Text("1KG", style: TextStyle(color: colors.primary, fontWeight: FontWeight.w600),),
                                                     const SizedBox(height: 5,),
                                                     const Text("200", style: TextStyle(color: colors.primary, fontWeight: FontWeight.w600),),
                                                     const SizedBox(height: 5,),
                                                     const Text("300", style: TextStyle(color: colors.primary, fontWeight: FontWeight.w600)),
                                                   ],
                                                 ),
                                               ),
                                              SizedBox(height: 5,),
                                              Center(
                                                child: Container(
                                                  height: 30,
                                                  child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                                      onPressed: () {},
                                                      child: const Text(
                                                        'Add',
                                                        style: TextStyle(color: Colors.white),
                                                      ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                      );
                                    },
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
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails()));
                                      },
                                      child: const Text(
                                        'Buy', style: TextStyle(
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
}
