import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ho_jayega_user_main/Helper/api.path.dart';
import 'package:ho_jayega_user_main/Helper/color.dart';
import 'package:ho_jayega_user_main/Model/VendorChargeModel.dart';
import 'package:ho_jayega_user_main/Model/VendorShopDataModel.dart';
import 'package:ho_jayega_user_main/Model/getCartListModel.dart';
import 'package:ho_jayega_user_main/Model/vendorBankDetail.dart';
import 'package:ho_jayega_user_main/Screen/BookingConfirmed.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ServicePayment extends StatefulWidget {
  final String amount;
  final DateTime selectedDate;
  final String vendor_id;
  const ServicePayment(
      {super.key,
      required this.amount,
      required this.selectedDate,
      required this.vendor_id});
  @override
  State<ServicePayment> createState() => _ServicePaymentState();
}

class _ServicePaymentState extends State<ServicePayment> {
  VendorBankDetailModel? vendor;
  Future<void> getQrCode() async {
    try {
      var headers = {
        'Cookie': 'ci_session=cd91f20bd1b20574b1014667f4766a9a3dd1eae5'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse(ApiServicves.vendor_bank_detail));
      request.fields.addAll({'vendor_id': widget.vendor_id});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var json = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        log(json.toString());
        setState(() {
          vendor = VendorBankDetailModel.fromJson(json);
        });
      } else {
        print(response.reasonPhrase);
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

  Future<void> paymentDone({required String transaction_id}) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? user_id = sharedPreferences.getString('user_id');
      var headers = {
        'Cookie': 'ci_session=5f91c234da6f33183d40b0f3e599b8a5cce1ca4a'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse(ApiServicves.servicePaymentDone));
      request.fields.addAll({
        'user_id': user_id.toString(),
        'amount': widget.amount,
        'payment_method': 'UPI',
        'transaction_id': transaction_id,
        'payment_status': '1'
      });

      request.files.add(await http.MultipartFile.fromPath('image', image!));
      request.headers.addAll(headers);
      log(request.fields.toString());
      http.StreamedResponse response = await request.send();
      var json = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        log(json.toString());
        if (json['msg'] == " Transasction Succesfuly") {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) =>
                    BookingConfirmed(date: widget.selectedDate),
              ),
              (route) => false);
        }
      } else {
        print(response.reasonPhrase);
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

  File? _image;
  String? image;
  final picker = ImagePicker();
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    print(pickedFile!.path.toString());
    image = pickedFile.path.toString();
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
    setState(() {});
  }

  late Future myFuture;
  TextEditingController Transaction = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    myFuture = getQrCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.appbarColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: Colors.white, //(0xff112C48),
        title: const Text('Payment'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
          future: myFuture,
          builder: (context, snap) {
            return snap.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 100,
                            backgroundImage: NetworkImage(
                              vendor!.data.first.qrCode.toString(),
                            ),
                            onBackgroundImageError: (exception, stackTrace) =>
                                CircularProgressIndicator(),
                          ),
                          Divider(color: Colors.transparent),
                          Text(
                            "Amount : ₹${widget.amount}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(color: Colors.transparent),
                          TextField(
                            controller: Transaction,
                            decoration: InputDecoration(
                              labelText: "Transaction ID",
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: colors.primary,
                                ),
                              ),
                            ),
                          ),
                          Divider(color: Colors.transparent),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => getImageFromGallery(),
                                child: Container(
                                  height: 170,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: colors.primary),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_photo_alternate_outlined,
                                        color: colors.primary,
                                        size: 30,
                                      ),
                                      Text("Select Screenshot"),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 170,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: colors.primary),
                                ),
                                child: image == null
                                    ? Center(
                                        child: Text(
                                        "Please Select Screenshot",
                                        textAlign: TextAlign.center,
                                      ))
                                    : Image.file(_image!),
                              ),
                            ],
                          ),
                          const Divider(color: Colors.transparent),
                          ElevatedButton(
                            onPressed: () {
                              if (Transaction.text.isEmpty || image == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Some Fields are Missing")));
                              } else {
                                paymentDone(
                                    transaction_id:
                                        Transaction.text.toString());
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                fixedSize: Size(double.maxFinite, 45),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: Text(
                              "DONE",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          }),
    );
  }
}
