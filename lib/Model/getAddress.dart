
class GetAddressModel {
  String responseCode;
  String msg;
  List<AddressList> data;

  GetAddressModel({
    required this.responseCode,
    required this.msg,
    required this.data,
  });

  factory GetAddressModel.fromJson(Map<String, dynamic> json) => GetAddressModel(
    responseCode: json["response_code"],
    msg: json["msg"],
    data: List<AddressList>.from(json["data"].map((x) => AddressList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response_code": responseCode,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class AddressList {
  String ?id;
  String ? userId;
  String ? address;
  String  ?building;
  String ? city;
  String  ?pincode;
  String  ?state;
  String  ?country;
  String ? isDefault;
  dynamic isSetFor;
  String ? lat;
  String ? lng;
  dynamic altMobile;
  DateTime  ?createdAt;
  DateTime ? updatedAt;
  dynamic name;
  String  ?region;
  String  ?cityName;
  String ? stateName;
  String  ?religionName;
  String  ?countryName;

  AddressList({
    this.id,
    this.userId,
    this.address,
    this.building,
    this.city,
    this.pincode,
    this.state,
    this.country,
    this.isDefault,
    this.isSetFor,
    this.lat,
    this.lng,
    this.altMobile,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.region,
    this.cityName,
    this.stateName,
    this.religionName,
    this.countryName,
  });

  factory AddressList.fromJson(Map<String, dynamic> json) => AddressList(
    id: json["id"],
    userId: json["user_id"],
    address: json["address"],
    building: json["building"],
    city: json["city"],
    pincode: json["pincode"],
    state: json["state"],
    country: json["country"],
    isDefault: json["is_default"],
    isSetFor: json["is_set_for"],
    lat: json["lat"],
    lng: json["lng"],
    altMobile: json["alt_mobile"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    name: json["name"],
    region: json["region"],
    cityName: json["city_name"],
    stateName: json["state_name"],
    religionName: json["religion_name"],
    countryName: json["country_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "address": address,
    "building": building,
    "city": city,
    "pincode": pincode,
    "state": state,
    "country": country,
    "is_default": isDefault,
    "is_set_for": isSetFor,
    "lat": lat,
    "lng": lng,
    "alt_mobile": altMobile,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "name": name,
    "region": region,
    "city_name": cityName,
    "state_name": stateName,
    "religion_name": religionName,
    "country_name": countryName,
  };
}
