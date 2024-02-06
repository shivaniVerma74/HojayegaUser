class ServicesModel {
  ServicesModel({
    required this.status,
    required this.msg,
    required this.restaurants,
  });

  final int? status;
  final String? msg;
  final List<Restaurant> restaurants;

  factory ServicesModel.fromJson(Map<String, dynamic> json) {
    return ServicesModel(
      status: json["status"],
      msg: json["msg"],
      restaurants: json["restaurants"] == null
          ? []
          : List<Restaurant>.from(
              json["restaurants"]!.map((x) => Restaurant.fromJson(x))),
    );
  }
}

class Restaurant {
  Restaurant({
    required this.id,
    required this.artistName,
    required this.categoryId,
    required this.subId,
    required this.servicesImage,
    required this.profileImage,
    required this.mrpPrice,
    required this.specialPrice,
    required this.vId,
    required this.roll,
    required this.serDesc,
    required this.serviceStatus,
    required this.taxStatus,
    required this.gstAmount,
    required this.perDayCharge,
  });

  final String? id;
  final String? artistName;
  final String? categoryId;
  final String? subId;
  final String? servicesImage;
  final String? profileImage;
  final String? mrpPrice;
  final String? specialPrice;
  final String? vId;
  final String? roll;
  final String? serDesc;
  final String? serviceStatus;
  final String? taxStatus;
  final String? gstAmount;
  final String? perDayCharge;

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json["id"],
      artistName: json["artist_name"],
      categoryId: json["category_id"],
      subId: json["sub_id"],
      servicesImage: json["services_image"],
      profileImage: json["profile_image"],
      mrpPrice: json["mrp_price"],
      specialPrice: json["special_price"],
      vId: json["v_id"],
      roll: json["roll"],
      serDesc: json["ser_desc"],
      serviceStatus: json["service_status"],
      taxStatus: json["tax_status"],
      gstAmount: json["gst_amount"],
      perDayCharge: json["per_day_charge"],
    );
  }
}
