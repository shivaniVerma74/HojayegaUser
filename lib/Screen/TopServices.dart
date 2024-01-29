import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ho_jayega_user_main/Helper/api.path.dart';
import 'package:ho_jayega_user_main/Helper/color.dart';
import 'package:http/http.dart' as http;

import '../Model/VendorShopDataModel.dart';
import '../Model/getCatForServices.dart';
import '../Model/getServicesforServicesModel.dart';

class TopService extends StatefulWidget {
  const TopService({Key? key}) : super(key: key);

  @override
  State<TopService> createState() => _Project1State();
}

class _Project1State extends State<TopService> {
  var TextList1 = [
    'Men Salon',
    'Beauty Parlour',
    'Unisex Salon',
    'Men Salon',
    'Unisex Salon',
    'Men Salon',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(child: Text('menu')),
      backgroundColor: Color(0xFFE2EBFE),
      appBar: AppBar(
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 30, bottom: 20),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/girl.png'), // Replace with your image path
            ),
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
        ),
        title: const Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: Text('Top Services '),
        ),
        backgroundColor: const Color(0xFF112c48),
      ),
      body: SingleChildScrollView(
        child: Column(
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
SizedBox(width: 10,),
                        Icon(Icons.search,color: colors.secondary,),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Search Services....',
                              style:
                                  TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    ),
                    height: 50,
                    width: MediaQuery.of(context).size.width/1.7,
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
                    width: MediaQuery.of(context).size.width/4,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(6),
                  color: Color(0xFFFFFFFF),
                ),
                child:

                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: ListView.builder(
                        itemCount: servicesList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {

                        return   Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: InkWell(
                            onTap: () {

                              setState(() {
                                serviceId=servicesList[index].id;
                              });
                              getServicesCat(serviceId);

                            },
                            child: Row(children: [

                              Container(height: 15,width: 15,

                                decoration: BoxDecoration(shape: BoxShape.circle,

                                    color: colors.primary

                                ),
                                child: Center(child: serviceId==servicesList[index].id?Icon(Icons.check,color: colors.whiteTemp,size: 10,):SizedBox.shrink(),),
                              ),
                              SizedBox(width: 2,),

                              Text(
                                "${servicesList[index].name}",
                                style: TextStyle(fontSize: 15),
                              ),


                            ],),
                          ),
                        );
                      },),
                    ),

              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text("Select Category's",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                ],
              ),
            ),


            catList.isNotEmpty?
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              childAspectRatio: 1.2, maxCrossAxisExtent: 120,
              crossAxisSpacing: 3

            ),
            itemCount: catList.length??0, // Adjust the number of items as needed
            itemBuilder: (context, index) {
              return


                InkWell(
                  onTap: () {
                    selectcat=catList[index].id;


                  },
                  child:


                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width/5,
                              height: MediaQuery.of(context).size.width/5,

                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),

                                  image:DecorationImage(image: NetworkImage("${catList[index].img}"),fit: BoxFit.fill)
                              ),

                            ),
                            Text(catList[index].cName??"",
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),

              selectcat==catList[index].id?

              Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,


                        ),

                        ):SizedBox.shrink(),

                    ],
                  ),
                );
              //   Container(
              //   width: 100.0, // Fixed width for each grid item
              //   height: 100.0, // Fixed height for each grid item
              //   color: Colors.blue, // Adjust the color as needed
              //   child:
              //
              //
              //
              // );
            },
          ):

                Container(height: 80,width: MediaQuery.of(context).size.width,
                child: Center(child: Text('Category Not Found'),),
                ),

            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text("Top Services",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                ],
              ),
            ),


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
                  return


                    InkWell(
                      onTap: () {

                        // Navigator.push(context, MaterialPageRoute(builder: (context) => TopService()));

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
                                  '${vendorshopdata?.user?[index].companyName}',
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
                                      '${vendorshopdata?.user?[index].km}',
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
            ),


            // Container(
            //   margin: EdgeInsets.only(left: 20, right: 20),
            //   height: 260,
            //   width: double.infinity,
            //
            //   child: GridView.builder(
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 2,
            //         crossAxisSpacing: 10,
            //         mainAxisSpacing: 10,
            //         mainAxisExtent: 250),
            //     itemCount: 2,
            //     itemBuilder: (context, index) {
            //       return Container(
            //           decoration: const BoxDecoration(
            //               borderRadius: BorderRadius.only(
            //                   topRight: Radius.circular(12),
            //                   topLeft: Radius.circular(12)),
            //               color: Colors.white),
            //           child: Column(
            //             children: [
            //
            //               Image.network("https://img.freepik.com/free-photo/vertical-shot-traditional-indian-paneer-butter-masala-cheese-cottage-curry-black-surface_181624-32001.jpg?w=740&t=st=1704365823~exp=1704366423~hmac=e29d051106665b8b6b7bce6a156378332d7f3cf15836b8bf07640ae0ab86671f", height: 180),
            //               const Text(
            //                 'RB saloon',
            //                 style: TextStyle(fontSize: 13),
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                 children: const [
            //                   Text(
            //                     '2KM',
            //                     style: TextStyle(fontSize: 13),
            //                   ),
            //                   Text(
            //                     'open',
            //                     style: TextStyle(fontSize: 13),
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getServices();
    getShops();
  }
  bool isLoading=false;
  var serviceId;
  List<GetServicesListModel> servicesList=[];
  Future<void> getServices() async {
    var headers = {
      'Cookie': 'ci_session=7545c3ffac3a1cdbb0adae955b28789c66935d55'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiServicves.gerServicesofServices}'));
    request.fields.addAll({
      'type': 'services'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("===my technic=======${request.url}===============");
    print("===my technic=======${request.fields}===============");

    if (response.statusCode == 200) {
   var result=await response.stream.bytesToString();
   print("===my technic=======${result}===============");
   var finalresult=jsonDecode(result);

   if(finalresult['error']==false){

     servicesList=GetservicesForServicesModel.fromJson(finalresult).data??[];
     serviceId=servicesList[0].id.toString();

     getServicesCat(serviceId);
     setState(() {

     });

   }else{
     servicesList.clear();
     serviceId=null;
   }
    }
    else {
    print(response.reasonPhrase);
    }


  }

  List<GetCatListModel>catList=[];
  var selectcat;
  Future<void> getServicesCat(String serviceIddd) async {


      var headers = {
        'Cookie': 'ci_session=7545c3ffac3a1cdbb0adae955b28789c66935d55'
      };
      var request = http.MultipartRequest('POST', Uri.parse('${ApiServicves.getServicesCat}'));
      request.fields.addAll({
        'cat_id': serviceIddd.toString(),
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print("===my technic=======${request.url}===============");
      print("===my technic=======${request.fields}===============");

      if (response.statusCode == 200) {
        var result=await response.stream.bytesToString();
        print("===my technic=======${result}===============");
        var finalresult=jsonDecode(result);

        if(finalresult['response_code']=="1"){

          catList=GetCatogriesForServiceModel.fromJson(finalresult).data??[];
          selectcat=catList[0].id;
          setState(() {

          });

        }else{

          catList.clear();
          selectcat=null;
          setState(() {

          });
        }
      }
      else {
        print(response.reasonPhrase);
      }





  }
  void getsubCat(){


  }


  VendorShopDataModel? vendorshopdata;
  getShops() async {
    var headers = {
      'Cookie': 'ci_session=69e89a4ee64270f8f78288d7b1e45b775bee424f'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getVendors));
    request.fields.addAll({
      'type': "2",
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

}
