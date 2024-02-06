import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ho_jayega_user_main/Helper/api.path.dart';
import 'package:ho_jayega_user_main/Helper/color.dart';
import 'package:ho_jayega_user_main/Screen/TopServices.dart';
import 'package:http/http.dart' as http;
import '../Model/VendorShopDataModel.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  VendorShopDataModel? vendorshopdata;

  getShops() async {
    try {
      var headers = {
        'Cookie': 'ci_session=430ab6c05fea61adf343951d98f72fa714919a82'
      };
      var request = http.MultipartRequest('POST',
          Uri.parse('https://developmentalphawizz.com/hojayega/api/wishlist'));
      request.fields.addAll({'user_id': '511'});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var json = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        log(json);
        // setState(() {
        //   vendorshopdata = json;
        // });
      } else {
        print(response.reasonPhrase);
      }
    } catch (e, stackTrace) {
      print(stackTrace);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShops();
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
    //   body: Padding(
    //     padding: const EdgeInsets.all(16.0),
    //     child: GridView.builder(
    //       gridDelegate:
    //           SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    //       itemBuilder: (context, index) => InkWell(
    //         onTap: () {
    //           Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                   builder: (context) => TopService(
    //                         VendorId: vendorshopdata!.user[index].id.toString(),
    //                       )));
    //         },
    //         child: Stack(
    //           children: [
    //             Container(
    //               decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.circular(10),
    //               ),
    //               child: Container(
    //                 // padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     vendorshopdata?.user?[index].profileImage == null ||
    //                             vendorshopdata?.user[index].profileImage == ""
    //                         ? SizedBox(
    //                             height: 130,
    //                             width: double.infinity,
    //                             child: ClipRRect(
    //                               borderRadius: const BorderRadius.only(
    //                                   topLeft: Radius.circular(10),
    //                                   topRight: Radius.circular(10)),
    //                               child: Image.asset(
    //                                   "assets/images/placeholder.png",
    //                                   fit: BoxFit.fill),
    //                             ))
    //                         : SizedBox(
    //                             height: 130,
    //                             width: double.infinity,
    //                             child: ClipRRect(
    //                                 borderRadius: const BorderRadius.only(
    //                                     topLeft: Radius.circular(10),
    //                                     topRight: Radius.circular(10)),
    //                                 child: Image.network(
    //                                   "${vendorshopdata?.user?[index].profileImage}",
    //                                   fit: BoxFit.fill,
    //                                 ))),
    //                     Padding(
    //                       padding: const EdgeInsets.only(left: 3, right: 3),
    //                       child: Text(
    //                         '${vendorshopdata?.user?[index].companyName}',
    //                         style: TextStyle(
    //                             fontSize: 12,
    //                             color: Colors.black.withOpacity(0.8),
    //                             fontWeight: FontWeight.bold),
    //                       ),
    //                     ),
    //                     const SizedBox(
    //                       height: 2,
    //                     ),
    //                     Padding(
    //                         padding: const EdgeInsets.only(left: 3, right: 3),
    //                         child: Row(
    //                           children: [
    //                             RatingBar.builder(
    //                               initialRating:
    //                                   vendorshopdata?.user?[index].revies == ""
    //                                       ? 0.0
    //                                       : double.parse(vendorshopdata
    //                                               ?.user?[index].revies
    //                                               .toString() ??
    //                                           ""),
    //                               minRating: 0,
    //                               direction: Axis.horizontal,
    //                               allowHalfRating: true,
    //                               itemCount: 5,
    //                               itemSize: 15,
    //                               ignoreGestures: true,
    //                               unratedColor: Colors.grey,
    //                               itemBuilder: (context, _) => const Icon(
    //                                   Icons.star,
    //                                   color: Colors.orange),
    //                               onRatingUpdate: (rating) {
    //                                 print(rating);
    //                               },
    //                             ),
    //                             Text(
    //                               double.parse(vendorshopdata
    //                                           ?.user?[index].revies
    //                                           .toString() ??
    //                                       '0.0')
    //                                   .toStringAsFixed(1),
    //                               style: const TextStyle(fontSize: 12),
    //                               overflow: TextOverflow.ellipsis,
    //                             ),
    //                           ],
    //                         )),
    //                     const SizedBox(
    //                       height: 2,
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.only(left: 3, right: 3),
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           Text(
    //                             '${vendorshopdata?.user[index].km}',
    //                             style: TextStyle(
    //                                 fontSize: 14,
    //                                 color: Colors.black.withOpacity(0.8),
    //                                 fontWeight: FontWeight.bold),
    //                           ),
    //                           vendorshopdata?.user?[index].status == "1"
    //                               ? const Text(
    //                                   'Open',
    //                                   style: TextStyle(
    //                                       fontSize: 14,
    //                                       color: Colors.green,
    //                                       fontWeight: FontWeight.bold),
    //                                 )
    //                               : const Text(
    //                                   'Close',
    //                                   style: TextStyle(
    //                                       fontSize: 14,
    //                                       color: Colors.red,
    //                                       fontWeight: FontWeight.bold),
    //                                 ),
    //                         ],
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             Positioned(
    //               right: 5,
    //               top: 5,
    //               child: GestureDetector(
    //                 onTap: () => setState(() {
    //                   // addToFav(
    //                   //     vendor_id: vendorshopdata!.user[index].id.toString());
    //                 }),
    //                 child: Icon(
    //                   Icons.favorite_border,
    //                   color: Colors.red,
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    );
  }
}
