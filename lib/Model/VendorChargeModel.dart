// To parse this JSON data, do
//
//     final vendorChargeModel = vendorChargeModelFromJson(jsonString);

import 'dart:convert';

VendorChargeModel vendorChargeModelFromJson(String str) => VendorChargeModel.fromJson(json.decode(str));

String vendorChargeModelToJson(VendorChargeModel data) => json.encode(data.toJson());

class VendorChargeModel {
  String responseCode;
  String msg;
  List<VendorData> data;

  VendorChargeModel({
    required this.responseCode,
    required this.msg,
    required this.data,
  });

  factory VendorChargeModel.fromJson(Map<String, dynamic> json) => VendorChargeModel(
    responseCode: json["response_code"],
    msg: json["msg"],
    data: List<VendorData>.from(json["data"].map((x) => VendorData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response_code": responseCode,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class VendorData {
  String id;
  String perClickUser;
  String perClickUserService;
  String orderConfirmed;
  String userSendBilling;
  String vendorId;
  String bookingConfirm;

  VendorData({
    required this.id,
    required this.perClickUser,
    required this.perClickUserService,
    required this.orderConfirmed,
    required this.userSendBilling,
    required this.vendorId,
    required this.bookingConfirm,
  });

  factory VendorData.fromJson(Map<String, dynamic> json) => VendorData(
    id: json["id"],
    perClickUser: json["per_click_user"],
    perClickUserService: json["per_click_user_service"],
    orderConfirmed: json["order_confirmed"],
    userSendBilling: json["user_send_billing"],
    vendorId: json["vendor_id"],
    bookingConfirm: json["booking_confirm"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "per_click_user": perClickUser,
    "per_click_user_service": perClickUserService,
    "order_confirmed": orderConfirmed,
    "user_send_billing": userSendBilling,
    "vendor_id": vendorId,
    "booking_confirm": bookingConfirm,
  };
}
