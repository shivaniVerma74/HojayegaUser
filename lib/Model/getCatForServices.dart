
class GetCatogriesForServiceModel {
  String responseCode;
  String msg;
  List<GetCatListModel> data;

  GetCatogriesForServiceModel({
    required this.responseCode,
    required this.msg,
    required this.data,
  });

  factory GetCatogriesForServiceModel.fromJson(Map<String, dynamic> json) => GetCatogriesForServiceModel(
    responseCode: json["response_code"],
    msg: json["msg"],
    data: List<GetCatListModel>.from(json["data"].map((x) => GetCatListModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response_code": responseCode,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetCatListModel {
  String ?id;
  String ?cName;
  String ?cNameA;
  String? icon;
  dynamic subTitle;
  dynamic description;
  String? img;
  String? otherImg;
  String? type;
  String? pId;
  String? serviceType;
  String ?image;

  GetCatListModel({
     this.id,
     this.cName,
     this.cNameA,
     this.icon,
     this.subTitle,
     this.description,
     this.img,
     this.otherImg,
     this.type,
     this.pId,
     this.serviceType,
     this.image,
  });

  factory GetCatListModel.fromJson(Map<String, dynamic> json) => GetCatListModel(
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

  Map<String, dynamic> toJson() => {
    "id": id,
    "c_name": cName,
    "c_name_a": cNameA,
    "icon": icon,
    "sub_title": subTitle,
    "description": description,
    "img": img,
    "other_img": otherImg,
    "type": type,
    "p_id": pId,
    "service_type": serviceType,
    "image": image,
  };
}
