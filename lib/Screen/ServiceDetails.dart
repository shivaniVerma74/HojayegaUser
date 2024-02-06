import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ho_jayega_user_main/Helper/api.path.dart';
import 'package:ho_jayega_user_main/Model/serviceDetailModel.dart';
import 'package:ho_jayega_user_main/Model/servicesMainCatModel.dart';
import 'package:ho_jayega_user_main/Screen/AppoinementBooking.dart';
import 'package:http/http.dart' as http;
import '../Helper/color.dart';

class ServiceDetails extends StatefulWidget {
  const ServiceDetails(
      {super.key, required this.catgories, required this.vendorId});
  final List<Services> catgories;
  final String vendorId;
  @override
  State<ServiceDetails> createState() => _RbSaloonState();
}

class _RbSaloonState extends State<ServiceDetails> {
  var selectedCat;
  List<Service> selectedService = [];
  double amount = 0.0;
  ServicesDetailModel? serviceDetails;
  Future<void> getServiceDetail({required String id}) async {
    try {
      var headers = {
        'Cookie': 'ci_session=cd91f20bd1b20574b1014667f4766a9a3dd1eae5'
      };
      var request =
          http.MultipartRequest('POST', Uri.parse(ApiServicves.serviceDetail));
      request.fields.addAll({'v_id': widget.vendorId, 'category_id': id});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var json = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        log(json.toString());
        setState(() {
          serviceDetails = ServicesDetailModel.fromJson(json);
        });
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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: colors.appbarColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: Colors.white, //(0xff112C48),
        title: const Text('Service Details'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Beauty Parlour',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            height: 140,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            width: MediaQuery.of(context).size.width,
            child: ListView.separated(
                separatorBuilder: (context, index) =>
                    VerticalDivider(color: Colors.transparent, width: 8),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.catgories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCat = widget.catgories[index].id;
                        getServiceDetail(
                            id: widget.catgories[index].id.toString());
                      });
                    },
                    child: Stack(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Container(
                                height: 90,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        color: colors.primary, width: 1),
                                    image: DecorationImage(
                                        onError: (exception, stackTrace) =>
                                            Icon(
                                              Icons.image,
                                              size: 45,
                                              color: Colors.black,
                                            ),
                                        image: NetworkImage(widget
                                            .catgories[index].image
                                            .toString()),
                                        fit: BoxFit.cover)),
                              ),
                              Text(
                                widget.catgories[index].cName ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        selectedCat == widget.catgories[index].id
                            ? Positioned(
                                top: 2,
                                left: 2,
                                child: Icon(
                                  Icons.check_circle_outline_rounded,
                                  color: Colors.white,
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  );
                }),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: colors.primary, width: 1)),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.43,
                  child: serviceDetails?.data.length == null
                      ? Center(child: Text("Please select a category"))
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: serviceDetails?.data.length ?? 0,
                          itemBuilder: (context, index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                serviceDetails!.data[index].name.toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                itemCount:
                                    serviceDetails!.data[index].services.length,
                                itemBuilder: (context, ind) => Row(
                                  children: [
                                    Container(
                                      height: 6,
                                      width: 6,
                                      decoration: BoxDecoration(
                                        color: colors.primary,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    VerticalDivider(width: 5),
                                    Text(
                                      serviceDetails!
                                          .data[index].services[ind].serviceName
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: colors.primary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "₹${serviceDetails!.data[index].services[ind].specialPrice.toString()}/-",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: colors.primary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (selectedService.contains(
                                              serviceDetails!
                                                  .data[index].services[ind])) {
                                            selectedService.remove(
                                                serviceDetails!
                                                    .data[index].services[ind]);
                                            amount -= double.parse(
                                                serviceDetails!.data[index]
                                                    .services[ind].specialPrice
                                                    .toString());
                                          } else {
                                            selectedService.add(serviceDetails!
                                                .data[index].services[ind]);
                                            amount += double.parse(
                                                serviceDetails!.data[index]
                                                    .services[ind].specialPrice
                                                    .toString());
                                          }
                                        });
                                        print("Amount: $amount");
                                      },
                                      child: selectedService.contains(
                                              serviceDetails!
                                                  .data[index].services[ind])
                                          ? Icon(
                                              Icons.check_circle_rounded,
                                              color: Colors.green,
                                              size: 25,
                                            )
                                          : Icon(
                                              Icons.circle_outlined,
                                              color: Colors.green,
                                              size: 25,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: colors.primary, width: 1)),
                  child: Text("Note: Rate might change as per work"),
                ),
                Divider(
                  color: Colors.transparent,
                  height: 7,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedService.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Please Select any service.")));
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AppointmentBooking(
                              amount: amount.toString(),
                              vendor_id: widget.vendorId),
                        ));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        fixedSize: Size(double.maxFinite, 45),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      "Book",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
