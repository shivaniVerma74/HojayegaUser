class SearchModel {
  SearchModel({
    required this.responseCode,
    required this.message,
    required this.restaurants,
    required this.status,
  });

  final String? responseCode;
  final String? message;
  final List<Restaurant> restaurants;
  final String? status;

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      responseCode: json["response_code"],
      message: json["message"],
      restaurants: json["restaurants"] == null
          ? []
          : List<Restaurant>.from(
              json["restaurants"]!.map((x) => Restaurant.fromJson(x))),
      status: json["status"],
    );
  }
}

class Restaurant {
  Restaurant({
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
    required this.rowOrder,
    required this.productId,
    required this.catId,
    required this.subcatId,
    required this.childCategory,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productImage,
    required this.proRatings,
    required this.roleId,
    required this.sellingPrice,
    required this.productCreateDate,
    required this.vendorId,
    required this.otherImage,
    required this.productStatus,
    required this.variantName,
    required this.productType,
    required this.tax,
    required this.unit,
    required this.unitType,
    required this.like,
    required this.ratting,
    required this.km,
    required this.vendor_roll,
  });

  final String? id;
  final String? email;
  final String? mobile;
  final String? address;
  final String? description;
  final String? categoryId;
  final String? perDCharge;
  final dynamic perHCharge;
  final dynamic experience;
  final dynamic vehicleNumber;
  final dynamic vehicleType;
  final dynamic rcBook;
  final dynamic perKmCharge;
  final String? lat;
  final String? lang;
  final String? uname;
  final String? password;
  final String? profileImage;
  final String? deviceToken;
  final dynamic otp;
  final String? status;
  final String? wallet;
  final String? balance;
  final dynamic lastLogin;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? roll;
  final String? adharCard;
  final String? pancard;
  final String? gstNo;
  final String? fssai;
  final String? storeName;
  final String? bandDetails;
  final String? cityId;
  final String? vehicleNo;
  final String? registarionCard;
  final String? drivingLicense;
  final String? categoriesId;
  final String? vendor_roll;
  final String? companyName;
  final String? roleUser;
  final String? event;
  final String? latitude;
  final String? longitude;
  final String? deliveryType;
  final String? refferalCode;
  final String? friendCode;
  final String? onlineStatus;
  final String? storeDescription;
  final String? commision;
  final String? restoType;
  final dynamic gender;
  final String? cashCollection;
  final String? commisionAmountType;
  final String? state;
  final String? city;
  final String? region;
  final String? shopType;
  final String? shopName;
  final String? customerLocation;
  final String? yearOfExperience;
  final DateTime? dob;
  final String? gstNumber;
  final String? shopImage;
  final String? selfiImage;
  final String? panImage;
  final String? adharFront;
  final String? adharBack;
  final String? dCard;
  final String? bCard;
  final String? landMark;
  final String? rowOrder;
  final String? productId;
  final String? catId;
  final String? subcatId;
  final String? childCategory;
  final String? productName;
  final String? productDescription;
  final String? productPrice;
  final String? productImage;
  final String? proRatings;
  final String? roleId;
  final String? sellingPrice;
  final DateTime? productCreateDate;
  final String? vendorId;
  final String? otherImage;
  final String? productStatus;
  final String? variantName;
  final String? productType;
  final String? tax;
  final String? unit;
  final String? unitType;
  final int? like;
  final int? ratting;
  final String? km;

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      vendor_roll: json["vendor_roll"],
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
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
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
      dob: DateTime.tryParse(json["dob"] ?? ""),
      gstNumber: json["gst_number"],
      shopImage: json["shop_image"],
      selfiImage: json["selfi_image"],
      panImage: json["pan_image"],
      adharFront: json["adhar_front"],
      adharBack: json["adhar_back"],
      dCard: json["d_card"],
      bCard: json["b_card"],
      landMark: json["land_mark"],
      rowOrder: json["row_order"],
      productId: json["product_id"],
      catId: json["cat_id"],
      subcatId: json["subcat_id"],
      childCategory: json["child_category"],
      productName: json["product_name"],
      productDescription: json["product_description"],
      productPrice: json["product_price"],
      productImage: json["product_image"],
      proRatings: json["pro_ratings"],
      roleId: json["role_id"],
      sellingPrice: json["selling_price"],
      productCreateDate: DateTime.tryParse(json["product_create_date"] ?? ""),
      vendorId: json["vendor_id"],
      otherImage: json["other_image"],
      productStatus: json["product_status"],
      variantName: json["variant_name"],
      productType: json["product_type"],
      tax: json["tax"],
      unit: json["unit"],
      unitType: json["unit_type"],
      like: json["like"],
      ratting: json["ratting"],
      km: json["km"],
    );
  }
}
