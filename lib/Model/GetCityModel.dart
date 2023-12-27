/// response_code : "1"
/// msg : "City List"
/// data : [{"id":"120","name":"Indore","image":null,"description":null,"country_id":"0","state_id":"15","created_at":"2023-11-18 18:21:12","updated_at":"2023-11-18 18:21:12"},{"id":"121","name":"Riwa","image":null,"description":null,"country_id":"0","state_id":"15","created_at":"2023-11-18 18:21:24","updated_at":"2023-11-18 18:21:24"},{"id":"122","name":"Guna","image":null,"description":null,"country_id":"0","state_id":"15","created_at":"2023-11-18 18:21:33","updated_at":"2023-11-18 18:21:33"},{"id":"123","name":"Bhind","image":null,"description":null,"country_id":"0","state_id":"15","created_at":"2023-11-18 18:21:51","updated_at":"2023-11-18 18:21:51"}]

class GetCityModel {
  GetCityModel({
      String? responseCode, 
      String? msg, 
      List<CityData>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  GetCityModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CityData.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<CityData>? _data;
GetCityModel copyWith({  String? responseCode,
  String? msg,
  List<CityData>? data,
}) => GetCityModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<CityData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "120"
/// name : "Indore"
/// image : null
/// description : null
/// country_id : "0"
/// state_id : "15"
/// created_at : "2023-11-18 18:21:12"
/// updated_at : "2023-11-18 18:21:12"

class CityData {
  CityData({
      String? id, 
      String? name, 
      dynamic image, 
      dynamic description, 
      String? countryId, 
      String? stateId, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _image = image;
    _description = description;
    _countryId = countryId;
    _stateId = stateId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  CityData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _description = json['description'];
    _countryId = json['country_id'];
    _stateId = json['state_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _name;
  dynamic _image;
  dynamic _description;
  String? _countryId;
  String? _stateId;
  String? _createdAt;
  String? _updatedAt;
  CityData copyWith({  String? id,
  String? name,
  dynamic image,
  dynamic description,
  String? countryId,
  String? stateId,
  String? createdAt,
  String? updatedAt,
}) => CityData(  id: id ?? _id,
  name: name ?? _name,
  image: image ?? _image,
  description: description ?? _description,
  countryId: countryId ?? _countryId,
  stateId: stateId ?? _stateId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get name => _name;
  dynamic get image => _image;
  dynamic get description => _description;
  String? get countryId => _countryId;
  String? get stateId => _stateId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['description'] = _description;
    map['country_id'] = _countryId;
    map['state_id'] = _stateId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}