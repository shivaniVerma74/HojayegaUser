class GetOrderModel {
  String responseCode;
  String message;
  List<GetOrderModelList> orders;
  String status;

  GetOrderModel({
    required this.responseCode,
    required this.message,
    required this.orders,
    required this.status,
  });

  factory GetOrderModel.fromJson(Map<String, dynamic> json) => GetOrderModel(
    responseCode: json["response_code"],
    message: json["message"],
    orders: List<GetOrderModelList>.from(json["orders"].map((x) => GetOrderModelList.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "response_code": responseCode,
    "message": message,
    "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
    "status": status,
  };
}

class GetOrderModelList {
  String? orderId;
  String ?total;
  DateTime? date;
  String ?assignId;
  List<DriverDatum> ?driverData;
  String ?paymentMode;
  String? address;
  String? ordersType;
  String? vehicleType;
  String? time;
  String? vendorName;
  String? orderStatus;
  String? paymentStatus;
  List<OrderItem>? orderItems;
  int? count;

  GetOrderModelList({
    this.orderId,
    this.total,
    this.date,
    this.assignId,
    this.driverData,
    this.paymentMode,
    this.address,
    this.ordersType,
    this.vehicleType,
    this.time,
    this.vendorName,
    this.orderStatus,
    this.paymentStatus,
    this.orderItems,
    this.count,
  });

  factory GetOrderModelList.fromJson(Map<String, dynamic> json) => GetOrderModelList(
    orderId: json["order_id"],
    total: json["total"],
    date: DateTime.parse(json["date"]),
    assignId: json["assign_id"],
    driverData:json["driver_data"]==null?[]: List<DriverDatum>.from(json["driver_data"].map((x) => DriverDatum.fromJson(x))),
    paymentMode: json["payment_mode"],
    address: json["address"],
    ordersType: json["orders_type"],
    vehicleType: json["vehicle_type"],
    time: json["time"],
    vendorName: json["vendor_name"],
    orderStatus: json["order_status"],
    paymentStatus: json["payment_status"],
    orderItems:json["order_items"]==null?[]: List<OrderItem>.from(json["order_items"].map((x) => OrderItem.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "total": total,
    "date":  date,
    "assign_id": assignId,
    "driver_data": List<dynamic>.from(driverData!.map((x) => x.toJson())),
    "payment_mode": paymentMode,
    "address": address,
    "orders_type": ordersType,
    "vehicle_type": vehicleType,
    "time": time,
    "vendor_name": vendorName,
    "order_status": orderStatus,
    "payment_status": paymentStatus,
    "order_items": List<dynamic>.from(orderItems!.map((x) => x.toJson())),
    "count": count,
  };
}

class OrderItem {
  String ?productId;
  String? catId;
  String ?subcatId;
  String? childCategory;
  String? productName;
  String? productDescription;
  String? productPrice;
  String? productImage;
  String? proRatings;
  String? roleId;
  String? sellingPrice;
  DateTime? productCreateDate;
  String? vendorId;
  String? otherImage;
  String? productStatus;
  String ?variantName;
  String? productType;
  String? tax;
  String? unit;
  String ?qty;

  OrderItem({
    this.productId,
    this.catId,
    this.subcatId,
    this.childCategory,
    this.productName,
    this.productDescription,
    this.productPrice,
    this.productImage,
    this.proRatings,
    this.roleId,
    this.sellingPrice,
    this.productCreateDate,
    this.vendorId,
    this.otherImage,
    this.productStatus,
    this.variantName,
    this.productType,
    this.tax,
    this.unit,
    this.qty,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
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
    productCreateDate: DateTime.parse(json["product_create_date"]),
    vendorId: json["vendor_id"],
    otherImage: json["other_image"],
    productStatus: json["product_status"],
    variantName: json["variant_name"],
    productType: json["product_type"],
    tax: json["tax"],
    unit: json["unit"],
    qty: json["qty"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "cat_id": catId,
    "subcat_id": subcatId,
    "child_category": childCategory,
    "product_name": productName,
    "product_description": productDescription,
    "product_price": productPrice,
    "product_image": productImage,
    "pro_ratings": proRatings,
    "role_id": roleId,
    "selling_price": sellingPrice,
    "product_create_date": productCreateDate,
    "vendor_id": vendorId,
    "other_image": otherImage,
    "product_status": productStatus,
    "variant_name": variantName,
    "product_type": productType,
    "tax": tax,
    "unit": unit,
    "qty": qty,
  };
}
class DriverDatum {
  String? id;
  String? name;
  String? email;
  String? mobile;
  String? type;
  String? city;
  String ?state;
  String? password;
  String? isVerified;
  String? rcCard;
  String ?licence;
  String ?status;
  String ?otp;
  String? fcmId;
  String ?latitude;
  String ?longitude;
  DateTime? createdAt;
  DateTime? updatedAt;
  String ?address;
  String? proPic;
  String? accessories;
  String? dob;
  String? vehicleNumber;
  String? region;
  String? pincode;
  String? electricityBill;
  String? policyVerification;
  String? adharCarFront;
  String? adharCarBack;
  String? wallet;
  String? cashReceived;
  String? qrCode;
  String? bankName;
  String ?accountNumber;
  String? ifscCode;
  String? upiId;

  DriverDatum({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.type,
    this.city,
    this.state,
    this.password,
    this.isVerified,
    this.rcCard,
    this.licence,
    this.status,
    this.otp,
    this.fcmId,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.proPic,
    this.accessories,
    this.dob,
    this.vehicleNumber,
    this.region,
    this.pincode,
    this.electricityBill,
    this.policyVerification,
    this.adharCarFront,
    this.adharCarBack,
    this.wallet,
    this.cashReceived,
    this.qrCode,
    this.bankName,
    this.accountNumber,
    this.ifscCode,
    this.upiId,
  });

  factory DriverDatum.fromJson(Map<String, dynamic> json) => DriverDatum(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    type: json["type"],
    city: json["city"],
    state: json["state"],
    password: json["password"],
    isVerified: json["is_verified"],
    rcCard: json["rc_card"],
    licence: json["licence"],
    status: json["status"],
    otp: json["otp"],
    fcmId: json["fcm_id"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    address: json["address"],
    proPic: json["pro_pic"],
    accessories: json["accessories"],
    dob: json["dob"],
    vehicleNumber: json["vehicle_number"],
    region: json["region"],
    pincode: json["pincode"],
    electricityBill: json["electricity_bill"],
    policyVerification: json["policy_verification"],
    adharCarFront: json["adhar_car_front"],
    adharCarBack: json["adhar_car_back"],
    wallet: json["wallet"],
    cashReceived: json["cash_received"],
    qrCode: json["qr_code"],
    bankName: json["bank_name"],
    accountNumber: json["account_number"],
    ifscCode: json["ifsc_code"],
    upiId: json["upi_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile": mobile,
    "type": type,
    "city": city,
    "state": state,
    "password": password,
    "is_verified": isVerified,
    "rc_card": rcCard,
    "licence": licence,
    "status": status,
    "otp": otp,
    "fcm_id": fcmId,
    "latitude": latitude,
    "longitude": longitude,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "address": address,
    "pro_pic": proPic,
    "accessories": accessories,
    "dob": dob,
    "vehicle_number": vehicleNumber,
    "region": region,
    "pincode": pincode,
    "electricity_bill": electricityBill,
    "policy_verification": policyVerification,
    "adhar_car_front": adharCarFront,
    "adhar_car_back": adharCarBack,
    "wallet": wallet,
    "cash_received": cashReceived,
    "qr_code": qrCode,
    "bank_name": bankName,
    "account_number": accountNumber,
    "ifsc_code": ifscCode,
    "upi_id": upiId,
  };
}