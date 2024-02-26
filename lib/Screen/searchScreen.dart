import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ho_jayega_user_main/Helper/api.path.dart';
import 'package:ho_jayega_user_main/Helper/appBar.dart';
import 'package:ho_jayega_user_main/Model/searchModel.dart';
import 'package:ho_jayega_user_main/Screen/AllCategory.dart';
import 'package:ho_jayega_user_main/Screen/TopServices.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchCtrl = TextEditingController();
  SearchModel? result;
  List<Restaurant> restaurants = [];
  Future<void> search({required String query}) async {
    try {
      var headers = {
        'Cookie': 'ci_session=8ab5a810f9153e7d42453721148484a088c3db4c'
      };
      var request =
          http.MultipartRequest('POST', Uri.parse(ApiServicves.search));
      request.fields.addAll({'text': query});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var json = jsonDecode(await response.stream.bytesToString());
      log(json.toString());
      if (response.statusCode == 200) {
        result = SearchModel.fromJson(json);
        restaurants = result?.restaurants ?? [];
        print(restaurants.length);
        setState(() {});
      } else {
        print(response.reasonPhrase);
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: commonAppBar(context, isHome: false, text: "Search" ,ontap: (){
        Navigator.pop(context);
        }),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
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
                      child: TextField(
                        controller: searchCtrl,
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
                  GestureDetector(
                    onTap: () => search(query: searchCtrl.text),
                    child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 11),
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
                          "Search",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                    ),
                  ),
                ],
              ),
              const Divider(color: Colors.transparent),
              Expanded(
                child: result?.status == 'fail'
                    ? Center(
                        child: Text("Nothing Found"),
                      )
                    : Container(
                        child: GridView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(0),
                          itemCount: restaurants.length ?? 0,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.8,
                            mainAxisSpacing: 10.0,
                          ),
                          itemBuilder: (context, index) {
                            return Card(
                              child: InkWell(
                                onTap: () async {
                                  if (restaurants[index].vendor_roll == '1') {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => AllCategory(
                                          ShopId:
                                              restaurants[index].id.toString()),
                                    ));
                                  } else {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => TopService(
                                          VendorId:
                                              restaurants[index].id.toString()),
                                    ));
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    // padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        restaurants[index].profileImage ==
                                                    null ||
                                                restaurants[index].shopImage ==
                                                    ""
                                            ? Container(
                                                height: 130,
                                                width: double.infinity,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10)),
                                                  child: Image.asset(
                                                      "assets/images/placeholder.png",
                                                      fit: BoxFit.fill),
                                                ),
                                              )
                                            : Container(
                                                height: 130,
                                                width: double.infinity,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10)),
                                                    child: Image.network(
                                                      "https://developmentalphawizz.com/hojayega/uploads/profile_pics/${restaurants[index].shopImage}",
                                                      fit: BoxFit.fill,
                                                    ))),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 3, right: 3),
                                          child: Text(
                                            '${restaurants[index].shopName}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black
                                                    .withOpacity(0.8),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 3, right: 3),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${restaurants[index].km}Km.',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black
                                                        .withOpacity(0.8),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              restaurants[index].status == "1"
                                                  ? const Text(
                                                      'Open',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  : const Text(
                                                      'Close',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
