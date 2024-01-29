// To parse this JSON data, do
//
//     final offerBanners = offerBannersFromJson(jsonString);

import 'dart:convert';

OfferBanners offerBannersFromJson(String str) => OfferBanners.fromJson(json.decode(str));

String offerBannersToJson(OfferBanners data) => json.encode(data.toJson());

class OfferBanners {
  bool error;
  String message;
  List<OfferBannerList> data;
  String image;

  OfferBanners({
    required this.error,
    required this.message,
    required this.data,
    required this.image,
  });

  factory OfferBanners.fromJson(Map<String, dynamic> json) => OfferBanners(
    error: json["error"],
    message: json["message"],
    data: List<OfferBannerList>.from(json["data"].map((x) => OfferBannerList.fromJson(x))),
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "image": image,
  };
}

class OfferBannerList {
  String id;
  String image;
  String type;
  String vendorId;
  String time;

  OfferBannerList({
    required this.id,
    required this.image,
    required this.type,
    required this.vendorId,
    required this.time,
  });

  factory OfferBannerList.fromJson(Map<String, dynamic> json) => OfferBannerList(
    id: json["id"],
    image: json["image"],
    type: json["type"],
    vendorId: json["vendor_id"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "type": type,
    "vendor_id": vendorId,
    "time": time,
  };
}
