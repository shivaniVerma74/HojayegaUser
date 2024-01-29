import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ho_jayega_user_main/Helper/appBar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/api.path.dart';
import '../Helper/color.dart';
import '../Model/getprodutcatwise.dart';
import 'Cart.dart';
import 'bottomScreen.dart';

class ProductDetails extends StatefulWidget {
  Product? productId;
  String? vendorId;
  ProductDetails({Key? key, this.productId,this.vendorId}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: colors.primary,
          foregroundColor: Colors.white, //(0xff112C48),
          title: Text('Product Details'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
          )),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            CarouselSlider(
              options: CarouselOptions(
                height: 180,
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
              items: widget.productId?.productImage
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
                    itemCount: widget.productId?.productImage?.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: index == currentIndex
                              ? colors.secondary
                              : const Color(0xffFEE9E9E9),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    "${widget.productId?.productName}",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                   Text(
                    "${widget.productId?.productDescription}",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children:  [
                      Text(
                        "Unit: ",
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "${widget.productId?.unit??""}kg",
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children:  [
                      Text(
                        "\u{20B9} ${widget.productId?.sellingPrice??""}",
                        style:
                            TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                      ),
                      Spacer(),
                      Text(
                        "${widget.productId?.proRatings??""}",
                        style:
                            TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                      ),
                      Icon(Icons.star,color: Colors.yellow,),
                      Icon(Icons.star,color: Colors.yellow,),
                      Icon(Icons.star,color: Colors.yellow,),
                      Icon(Icons.star,color: Colors.yellow,),
                      Icon(Icons.star,color: Colors.yellow,),
                    ],
                  ),
                  Text("\u{20B9} ${widget.productId?.productPrice??""}", style: TextStyle(color: colors.primary,decoration: TextDecoration.lineThrough,fontSize:22 )),
SizedBox(height: 20,),
                  Container(height: 50,

                  width: 150,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                    border: Border.all(color: colors.secondary)
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
SizedBox(),
                      InkWell(
                          onTap: () {

                            decrementfun();

                          },

                          child: Icon(Icons.remove)

                      ),
                      Text(increment.toString()),
                      InkWell(

                          onTap: () {

                            incrementfun();
                          },
                          child: Icon(Icons.add)),
                          SizedBox(),


                        ]),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 90,
            ),
            InkWell(
              onTap: () {
                addTocart();
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => const Cart()));
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colors.secondary),
                child: const Center(
                    child: Text(
                  "Send For Billing",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: colors.appbarColor),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int currentIndex = 0;
  int increment=1;
  void incrementfun(){
    increment++;
    setState(() {

    });

  }
  void decrementfun(){

    if(increment>1){
    increment--;
    setState(() {

    });

  }


}

@override
  void initState() {
    // TODO: implement initState

  print("===my technic=======${widget.productId?.productId}===============");
  }
Future<void> addTocart(

    ) async {


  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? user_id = sharedPreferences.getString('user_id');
  var headers = {
    'Cookie': 'ci_session=d09fc39a8b8a97b07417a28e972b458e44a87757'
  };
  var request = http.MultipartRequest('POST', Uri.parse('${ApiServicves.baseUrl}add_to_cart'));

  request.fields.addAll({
    'user_id': "${user_id.toString()}",
    'product_id': '${widget.productId?.productId}',
    'quantity': "${increment.toString()}",
    'vendor_id': '${widget.vendorId.toString()}'
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  print("===my technic=======${request.fields}===============");
  print("===my technic=======${request.url}===============");
  if (response.statusCode == 200) {
   var result=await response.stream.bytesToString();
   var finalresult=jsonDecode(result);


   if(finalresult['response_code']=="1"){

    Fluttertoast.showToast(msg: "${finalresult['message']}");

     Navigator.pushReplacement(context,
         MaterialPageRoute(builder: (context) =>  BottomNavBar()));
   }
  }
  else {
  print(response.reasonPhrase);
  }



}

}
