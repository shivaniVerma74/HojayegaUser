class ServicesDetailModel {
  ServicesDetailModel({
    required this.responseCode,
    required this.msg,
    required this.data,
  });

  final String? responseCode;
  final String? msg;
  final List<DetailData> data;

  factory ServicesDetailModel.fromJson(Map<String, dynamic> json) {
    return ServicesDetailModel(
      responseCode: json["response_code"],
      msg: json["msg"],
      data: json["data"] == null
          ? []
          : List<DetailData>.from(
              json["data"]!.map((x) => DetailData.fromJson(x))),
    );
  }
}

class DetailData {
  DetailData({
    required this.name,
    required this.services,
  });

  final String? name;
  final List<Service> services;

  factory DetailData.fromJson(Map<String, dynamic> json) {
    return DetailData(
      name: json["Name"],
      services: json["Services"] == null
          ? []
          : List<Service>.from(
              json["Services"]!.map((x) => Service.fromJson(x))),
    );
  }
}

class Service {
  Service({
    required this.serviceName,
    required this.mrpPrice,
    required this.specialPrice,
    required this.artistName,
  });

  final String? serviceName;
  final String? mrpPrice;
  final String? specialPrice;
  final String? artistName;

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      serviceName: json["service_name"],
      mrpPrice: json["mrp_price"],
      specialPrice: json["special_price"],
      artistName: json["artist_name"],
    );
  }
}
