// To parse this JSON data, do
//
//     final vendorShopDataModel = vendorShopDataModelFromJson(jsonString);

import 'dart:convert';

VendorShopDataModel vendorShopDataModelFromJson(String str) => VendorShopDataModel.fromJson(json.decode(str));

String vendorShopDataModelToJson(VendorShopDataModel data) => json.encode(data.toJson());

class VendorShopDataModel {
  bool error;
  String message;
  String status;
  List<UserData> user;

  VendorShopDataModel({
    required this.error,
    required this.message,
    required this.status,
    required this.user,
  });

  factory VendorShopDataModel.fromJson(Map<String, dynamic> json) => VendorShopDataModel(
    error: json["error"],
    message: json["message"],
    status: json["status"],
    user: List<UserData>.from(json["user"].map((x) => UserData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "status": status,
    "user": List<dynamic>.from(user.map((x) => x.toJson())),
  };
}

class UserData {
  String id;
  String email;
  String mobile;
  String address;
  String description;
  String categoryId;
  String perDCharge;
  dynamic perHCharge;
  dynamic experience;
  dynamic vehicleNumber;
  dynamic vehicleType;
  dynamic rcBook;
  dynamic perKmCharge;
  String lat;
  String lang;
  String uname;
  String password;
  String profileImage;
  String deviceToken;
  dynamic otp;
  String status;
  String wallet;
  String balance;
  dynamic lastLogin;
  DateTime createdAt;
  DateTime updatedAt;
  String roll;
  String adharCard;
  String pancard;
  String gstNo;
  String fssai;
  String storeName;
  String bandDetails;
  String cityId;
  String vehicleNo;
  String registarionCard;
  String drivingLicense;
  String categoriesId;
  String companyName;
  String roleUser;
  String event;
  String latitude;
  String longitude;
  String deliveryType;
  String refferalCode;
  String friendCode;
  String onlineStatus;
  String storeDescription;
  String commision;
  String restoType;
  dynamic gender;
  String cashCollection;
  String commisionAmountType;
  String state;
  String city;
  String region;
  String shopType;
  String shopName;
  String customerLocation;
  String yearOfExperience;
  DateTime dob;
  String gstNumber;
  String shopImage;
  String selfiImage;
  String panImage;
  String adharFront;
  String adharBack;
  String dCard;
  String bCard;
  String landMark;
  int revies;
  String km;

  UserData({
    required this.id,
    required this.email,
    required this.mobile,
    required this.address,
    required this.description,
    required this.categoryId,
    required this.perDCharge,
    required this.perHCharge,
    required this.experience,
    required this.vehicleNumber,
    required this.vehicleType,
    required this.rcBook,
    required this.perKmCharge,
    required this.lat,
    required this.lang,
    required this.uname,
    required this.password,
    required this.profileImage,
    required this.deviceToken,
    required this.otp,
    required this.status,
    required this.wallet,
    required this.balance,
    required this.lastLogin,
    required this.createdAt,
    required this.updatedAt,
    required this.roll,
    required this.adharCard,
    required this.pancard,
    required this.gstNo,
    required this.fssai,
    required this.storeName,
    required this.bandDetails,
    required this.cityId,
    required this.vehicleNo,
    required this.registarionCard,
    required this.drivingLicense,
    required this.categoriesId,
    required this.companyName,
    required this.roleUser,
    required this.event,
    required this.latitude,
    required this.longitude,
    required this.deliveryType,
    required this.refferalCode,
    required this.friendCode,
    required this.onlineStatus,
    required this.storeDescription,
    required this.commision,
    required this.restoType,
    required this.gender,
    required this.cashCollection,
    required this.commisionAmountType,
    required this.state,
    required this.city,
    required this.region,
    required this.shopType,
    required this.shopName,
    required this.customerLocation,
    required this.yearOfExperience,
    required this.dob,
    required this.gstNumber,
    required this.shopImage,
    required this.selfiImage,
    required this.panImage,
    required this.adharFront,
    required this.adharBack,
    required this.dCard,
    required this.bCard,
    required this.landMark,
    required this.revies,
    required this.km,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"],
    email: json["email"],
    mobile: json["mobile"],
    address: json["address"],
    description: json["description"],
    categoryId: json["category_id"],
    perDCharge: json["per_d_charge"],
    perHCharge: json["per_h_charge"],
    experience: json["experience"],
    vehicleNumber: json["vehicle_number"],
    vehicleType: json["vehicle_type"],
    rcBook: json["rc_book"],
    perKmCharge: json["per_km_charge"],
    lat: json["lat"],
    lang: json["lang"],
    uname: json["uname"],
    password: json["password"],
    profileImage: json["profile_image"],
    deviceToken: json["device_token"],
    otp: json["otp"],
    status: json["status"],
    wallet: json["wallet"],
    balance: json["balance"],
    lastLogin: json["last_login"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    roll: json["roll"],
    adharCard: json["adhar_card"],
    pancard: json["pancard"],
    gstNo: json["gst_no"],
    fssai: json["fssai"],
    storeName: json["store_name"],
    bandDetails: json["band_details"],
    cityId: json["city_id"],
    vehicleNo: json["vehicle_no"],
    registarionCard: json["registarion_card"],
    drivingLicense: json["driving_license"],
    categoriesId: json["categories_id"],
    companyName: json["company_name"],
    roleUser: json["role_user"],
    event: json["event"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    deliveryType: json["delivery_type"],
    refferalCode: json["refferal_code"],
    friendCode: json["friend_code"],
    onlineStatus: json["online_status"],
    storeDescription: json["store_description"],
    commision: json["commision"],
    restoType: json["resto_type"],
    gender: json["gender"],
    cashCollection: json["cash_collection"],
    commisionAmountType: json["commision_amount_type"],
    state: json["state"],
    city: json["city"],
    region: json["region"],
    shopType: json["shop_type"],
    shopName: json["shop_name"],
    customerLocation: json["customer_location"],
    yearOfExperience: json["year_of_experience"],
    dob: DateTime.parse(json["dob"]),
    gstNumber: json["gst_number"],
    shopImage: json["shop_image"],
    selfiImage: json["selfi_image"],
    panImage: json["pan_image"],
    adharFront: json["adhar_front"],
    adharBack: json["adhar_back"],
    dCard: json["d_card"],
    bCard: json["b_card"],
    landMark: json["land_mark"],
    revies: json["revies"],
    km: json["km"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "mobile": mobile,
    "address": address,
    "description": description,
    "category_id": categoryId,
    "per_d_charge": perDCharge,
    "per_h_charge": perHCharge,
    "experience": experience,
    "vehicle_number": vehicleNumber,
    "vehicle_type": vehicleType,
    "rc_book": rcBook,
    "per_km_charge": perKmCharge,
    "lat": lat,
    "lang": lang,
    "uname": uname,
    "password": password,
    "profile_image": profileImage,
    "device_token": deviceToken,
    "otp": otp,
    "status": status,
    "wallet": wallet,
    "balance": balance,
    "last_login": lastLogin,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "roll": roll,
    "adhar_card": adharCard,
    "pancard": pancard,
    "gst_no": gstNo,
    "fssai": fssai,
    "store_name": storeName,
    "band_details": bandDetails,
    "city_id": cityId,
    "vehicle_no": vehicleNo,
    "registarion_card": registarionCard,
    "driving_license": drivingLicense,
    "categories_id": categoriesId,
    "company_name": companyName,
    "role_user": roleUser,
    "event": event,
    "latitude": latitude,
    "longitude": longitude,
    "delivery_type": deliveryType,
    "refferal_code": refferalCode,
    "friend_code": friendCode,
    "online_status": onlineStatus,
    "store_description": storeDescription,
    "commision": commision,
    "resto_type": restoType,
    "gender": gender,
    "cash_collection": cashCollection,
    "commision_amount_type": commisionAmountType,
    "state": state,
    "city": city,
    "region": region,
    "shop_type": shopType,
    "shop_name": shopName,
    "customer_location": customerLocation,
    "year_of_experience": yearOfExperience,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "gst_number": gstNumber,
    "shop_image": shopImage,
    "selfi_image": selfiImage,
    "pan_image": panImage,
    "adhar_front": adharFront,
    "adhar_back": adharBack,
    "d_card": dCard,
    "b_card": bCard,
    "land_mark": landMark,
    "revies": revies,
    "km": km,
  };
}
