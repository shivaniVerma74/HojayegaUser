/// response_code : "1"
/// msg : "Categories Found"
/// data : [{"id":"11","c_name":"asdfasdf","image":"https://developmentalphawizz.com/hojayega/uploads/65673a0f935ec.jpg","cat_id":"10"},{"id":"12","c_name":"t","image":"https://developmentalphawizz.com/hojayega/uploads/656757184dbf5.jpg","cat_id":"10"}]

class SubCategoryModel {
  SubCategoryModel({
      String? responseCode, 
      String? msg, 
      List<SubCategoryData>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  SubCategoryModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SubCategoryData.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<SubCategoryData>? _data;
SubCategoryModel copyWith({  String? responseCode,
  String? msg,
  List<SubCategoryData>? data,
}) => SubCategoryModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<SubCategoryData>? get data => _data;

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

/// id : "11"
/// c_name : "asdfasdf"
/// image : "https://developmentalphawizz.com/hojayega/uploads/65673a0f935ec.jpg"
/// cat_id : "10"

class SubCategoryData {
  SubCategoryData({
      String? id, 
      String? cName, 
      String? image, 
      String? catId,}){
    _id = id;
    _cName = cName;
    _image = image;
    _catId = catId;
}

  SubCategoryData.fromJson(dynamic json) {
    _id = json['id'];
    _cName = json['c_name'];
    _image = json['image'];
    _catId = json['cat_id'];
  }
  String? _id;
  String? _cName;
  String? _image;
  String? _catId;
  SubCategoryData copyWith({  String? id,
  String? cName,
  String? image,
  String? catId,
}) => SubCategoryData(  id: id ?? _id,
  cName: cName ?? _cName,
  image: image ?? _image,
  catId: catId ?? _catId,
);
  String? get id => _id;
  String? get cName => _cName;
  String? get image => _image;
  String? get catId => _catId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['c_name'] = _cName;
    map['image'] = _image;
    map['cat_id'] = _catId;
    return map;
  }

}