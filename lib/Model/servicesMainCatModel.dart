class ServiceMainCat {
  ServiceMainCat({
    required this.responseCode,
    required this.msg,
    required this.data,
  });

  final String? responseCode;
  final String? msg;
  final List<Services> data;

  factory ServiceMainCat.fromJson(Map<String, dynamic> json) {
    return ServiceMainCat(
      responseCode: json["response_code"],
      msg: json["msg"],
      data: json["data"] == null
          ? []
          : List<Services>.from(json["data"]!.map((x) => Services.fromJson(x))),
    );
  }
}

class Services {
  Services({
    required this.id,
    required this.cName,
    required this.cNameA,
    required this.icon,
    required this.subTitle,
    required this.description,
    required this.img,
    required this.otherImg,
    required this.type,
    required this.pId,
    required this.serviceType,
    required this.image,
  });

  final String? id;
  final String? cName;
  final String? cNameA;
  final String? icon;
  final dynamic? subTitle;
  final dynamic? description;
  final String? img;
  final String? otherImg;
  final String? type;
  final String? pId;
  final String? serviceType;
  final String? image;

  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(
      id: json["id"],
      cName: json["c_name"],
      cNameA: json["c_name_a"],
      icon: json["icon"],
      subTitle: json["sub_title"],
      description: json["description"],
      img: json["img"],
      otherImg: json["other_img"],
      type: json["type"],
      pId: json["p_id"],
      serviceType: json["service_type"],
      image: json["image"],
    );
  }
}
