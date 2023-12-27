/// error : false
/// message : "Banners Found"
/// data : [{"id":"1","name":"Vegitables","image":"","type":"shop","title":"test"}]

class GetShopsTypeModel {
  GetShopsTypeModel({
      bool? error, 
      String? message, 
      List<ShoopData>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetShopsTypeModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ShoopData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<ShoopData>? _data;
GetShopsTypeModel copyWith({  bool? error,
  String? message,
  List<ShoopData>? data,
}) => GetShopsTypeModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<ShoopData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// name : "Vegitables"
/// image : ""
/// type : "shop"
/// title : "test"

class ShoopData {
  ShoopData({
      String? id, 
      String? name, 
      String? image, 
      String? type, 
      String? title,}){
    _id = id;
    _name = name;
    _image = image;
    _type = type;
    _title = title;
}

  ShoopData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _type = json['type'];
    _title = json['title'];
  }
  String? _id;
  String? _name;
  String? _image;
  String? _type;
  String? _title;
  ShoopData copyWith({  String? id,
  String? name,
  String? image,
  String? type,
  String? title,
}) => ShoopData(  id: id ?? _id,
  name: name ?? _name,
  image: image ?? _image,
  type: type ?? _type,
  title: title ?? _title,
);
  String? get id => _id;
  String? get name => _name;
  String? get image => _image;
  String? get type => _type;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['type'] = _type;
    map['title'] = _title;
    return map;
  }
}