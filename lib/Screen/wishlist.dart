import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ho_jayega_user_main/Helper/api.path.dart';
import 'package:ho_jayega_user_main/Helper/color.dart';
import 'package:ho_jayega_user_main/Model/VendorChargeModel.dart';
import 'package:ho_jayega_user_main/Model/wishlistModel.dart';
import 'package:ho_jayega_user_main/Screen/AllCategory.dart';
import 'package:ho_jayega_user_main/Screen/TopServices.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/VendorShopDataModel.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  WishlistModel? wishlist;
  getShops() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString('user_id');
    try {
      var headers = {
        'Cookie': 'ci_session=430ab6c05fea61adf343951d98f72fa714919a82'
      };
      var request = http.MultipartRequest('POST',
          Uri.parse('https://developmentalphawizz.com/hojayega/api/wishlist'));
      request.fields.addAll({'user_id': userId.toString()});
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var json = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        log(json.toString());
        setState(() {
          wishlist = WishlistModel.fromJson(json);
        });
      } else {
        print(response.reasonPhrase);
      }
    } catch (e, stackTrace) {
      print(stackTrace);
    }
  }

  Future<void> unLike({
    required String user_id,
    required String vendor_id,
  }) async {
    try {
      var headers = {
        'Cookie': 'ci_session=f00a19157f1b62046c6d05a4f796699917768b97'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse(ApiServicves.removeFromWishlist));
      request.fields.addAll({'vendor_id': vendor_id, 'user_id': user_id});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        getShops();
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
    // TODO: implement initState
    super.initState();
    myFuture = getShops();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: colors.primary,
          foregroundColor: Colors.white, //(0xff112C48),
          title: Text('Wishlist'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
          )),
      backgroundColor: colors.appbarColor,
      body: FutureBuilder(
          future: myFuture,
          builder: (context, snap) {
            return snap.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: wishlist!.wishlist.length == null  || wishlist!.wishlist.length == 0 ? Center(child: Text("Products Not Found", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)):
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2 / 3,
                          crossAxisSpacing: 10),
                      itemCount: wishlist!.wishlist.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          if (wishlist!.wishlist[index].roll == '1') {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AllCategory(
                                  ShopId:
                                      wishlist!.wishlist[index].id.toString()),
                            ));
                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => TopService(
                                    VendorId: wishlist!.wishlist[index].id
                                        .toString()),
                              ),
                            );
                          }
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 190,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  wishlist!.wishlist[index].profileImage ==
                                              null ||
                                          wishlist!.wishlist[index]
                                                  .profileImage ==
                                              ""
                                      ? SizedBox(
                                          height: 120,
                                          width: double.infinity,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10)),
                                            child: Image.network(
                                              wishlist!
                                                  .wishlist[index].shopImage
                                                  .toString(),
                                              fit: BoxFit.fill,
                                            ),
                                          ))
                                      : SizedBox(
                                          height: 120,
                                          width: double.infinity,
                                          child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10)),
                                              child: Image.network(
                                                wishlist!.wishlist[index]
                                                    .profileImage
                                                    .toString(),
                                                fit: BoxFit.fill,
                                              ))),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3, right: 3),
                                    child: Text(
                                      wishlist!.wishlist[index].companyName
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 3, right: 3),
                                      child: Row(
                                        children: [
                                          Icon(Icons.star,
                                              color: Colors.yellow, size: 15),
                                          Text(
                                            double.parse(wishlist!
                                                        .wishlist[index].ratting
                                                        .toString() ??
                                                    '0.0')
                                                .toStringAsFixed(1),
                                            style:
                                                const TextStyle(fontSize: 12),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      )),
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
                                          '${wishlist!.wishlist[index].perKmCharge}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  Colors.black.withOpacity(0.8),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        wishlist!.wishlist[index].status == "1"
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
                            Positioned(
                              right: 5,
                              top: 5,
                              child: GestureDetector(
                                //test to upload
                                onTap: () => setState(() {
                                  unLike(
                                      user_id: wishlist!.wishlist[index].userId
                                          .toString(),
                                      vendor_id: wishlist!.wishlist[index].id
                                          .toString());
                                }),
                                child: wishlist!.wishlist[index].like == 1
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : Icon(
                                        Icons.favorite_border,
                                        color: Colors.red,
                                      ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
          }),
    );
  }
}
