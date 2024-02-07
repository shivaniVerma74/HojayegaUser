class WishlistModel {
  WishlistModel({
    required this.responseCode,
    required this.message,
    required this.wishlist,
    required this.status,
  });

  final String? responseCode;
  final String? message;
  final List<WishlistData> wishlist;
  final String? status;

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      responseCode: json["response_code"],
      message: json["message"],
      wishlist: json["wishlist"] == String
          ? []
          : List<WishlistData>.from(
              json["wishlist"]!.map((x) => WishlistData.fromJson(x))),
      status: json["status"],
    );
  }
}

class WishlistData {
  String? id;
  String? email;
  String? mobile;
  String? address;
  String? description;
  String? categoryId;
  String? perDCharge;
  String? perHCharge;
  String? experience;
  String? vehicleNumber;
  String? vehicleType;
  String? rcBook;
  String? perKmCharge;
  String? lat;
  String? lang;
  String? uname;
  String? password;
  String? profileImage;
  String? deviceToken;
  String? otp;
  String? status;
  String? wallet;
  String? balance;
  String? lastLogin;
  String? createdAt;
  String? updatedAt;
  String? roll;
  String? adharCard;
  String? pancard;
  String? gstNo;
  String? fssai;
  String? storeName;
  String? bandDetails;
  String? cityId;
  String? vehicleNo;
  String? registarionCard;
  String? drivingLicense;
  String? categoriesId;
  String? companyName;
  String? roleUser;
  String? event;
  String? latitude;
  String? longitude;
  String? deliveryType;
  String? refferalCode;
  String? friendCode;
  String? onlineStatus;
  String? storeDescription;
  String? commision;
  String? restoType;
  String? gender;
  String? cashCollection;
  String? commisionAmountType;
  String? state;
  String? city;
  String? region;
  String? shopType;
  String? shopName;
  String? customerLocation;
  String? yearOfExperience;
  String? dob;
  String? gstNumber;
  String? shopImage;
  String? selfiImage;
  String? panImage;
  String? adharFront;
  String? adharBack;
  String? dCard;
  String? bCard;
  String? landMark;
  String? rowOrder;
  String? likeId;
  String? proId;
  String? userId;
  String? date;
  int? like;
  int? ratting;

  WishlistData(
      {this.id,
      this.email,
      this.mobile,
      this.address,
      this.description,
      this.categoryId,
      this.perDCharge,
      this.perHCharge,
      this.experience,
      this.vehicleNumber,
      this.vehicleType,
      this.rcBook,
      this.perKmCharge,
      this.lat,
      this.lang,
      this.uname,
      this.password,
      this.profileImage,
      this.deviceToken,
      this.otp,
      this.status,
      this.wallet,
      this.balance,
      this.lastLogin,
      this.createdAt,
      this.updatedAt,
      this.roll,
      this.adharCard,
      this.pancard,
      this.gstNo,
      this.fssai,
      this.storeName,
      this.bandDetails,
      this.cityId,
      this.vehicleNo,
      this.registarionCard,
      this.drivingLicense,
      this.categoriesId,
      this.companyName,
      this.roleUser,
      this.event,
      this.latitude,
      this.longitude,
      this.deliveryType,
      this.refferalCode,
      this.friendCode,
      this.onlineStatus,
      this.storeDescription,
      this.commision,
      this.restoType,
      this.gender,
      this.cashCollection,
      this.commisionAmountType,
      this.state,
      this.city,
      this.region,
      this.shopType,
      this.shopName,
      this.customerLocation,
      this.yearOfExperience,
      this.dob,
      this.gstNumber,
      this.shopImage,
      this.selfiImage,
      this.panImage,
      this.adharFront,
      this.adharBack,
      this.dCard,
      this.bCard,
      this.landMark,
      this.rowOrder,
      this.likeId,
      this.proId,
      this.userId,
      this.date,
      this.like,
      this.ratting});

  WishlistData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    description = json['description'];
    categoryId = json['category_id'];
    perDCharge = json['per_d_charge'];
    perHCharge = json['per_h_charge'];
    experience = json['experience'];
    vehicleNumber = json['vehicle_number'];
    vehicleType = json['vehicle_type'];
    rcBook = json['rc_book'];
    perKmCharge = json['per_km_charge'];
    lat = json['lat'];
    lang = json['lang'];
    uname = json['uname'];
    password = json['password'];
    profileImage = json['profile_image'];
    deviceToken = json['device_token'];
    otp = json['otp'];
    status = json['status'];
    wallet = json['wallet'];
    balance = json['balance'];
    lastLogin = json['last_login'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    roll = json['roll'];
    adharCard = json['adhar_card'];
    pancard = json['pancard'];
    gstNo = json['gst_no'];
    fssai = json['fssai'];
    storeName = json['store_name'];
    bandDetails = json['band_details'];
    cityId = json['city_id'];
    vehicleNo = json['vehicle_no'];
    registarionCard = json['registarion_card'];
    drivingLicense = json['driving_license'];
    categoriesId = json['categories_id'];
    companyName = json['company_name'];
    roleUser = json['role_user'];
    event = json['event'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    deliveryType = json['delivery_type'];
    refferalCode = json['refferal_code'];
    friendCode = json['friend_code'];
    onlineStatus = json['online_status'];
    storeDescription = json['store_description'];
    commision = json['commision'];
    restoType = json['resto_type'];
    gender = json['gender'];
    cashCollection = json['cash_collection'];
    commisionAmountType = json['commision_amount_type'];
    state = json['state'];
    city = json['city'];
    region = json['region'];
    shopType = json['shop_type'];
    shopName = json['shop_name'];
    customerLocation = json['customer_location'];
    yearOfExperience = json['year_of_experience'];
    dob = json['dob'];
    gstNumber = json['gst_number'];
    shopImage = json['shop_image'];
    selfiImage = json['selfi_image'];
    panImage = json['pan_image'];
    adharFront = json['adhar_front'];
    adharBack = json['adhar_back'];
    dCard = json['d_card'];
    bCard = json['b_card'];
    landMark = json['land_mark'];
    rowOrder = json['row_order'];
    likeId = json['like_id'];
    proId = json['pro_id'];
    userId = json['user_id'];
    date = json['date'];
    like = json['like'];
    ratting = json['ratting'];
  }
}
