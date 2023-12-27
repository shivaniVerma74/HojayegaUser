/// response_code : "1"
/// msg : "Categories Found"
/// data : [{"id":"8","c_name":"sdfasdfasd","image":"https://developmentalphawizz.com/hojayega/uploads/65607ae9cc427.png","cat_id":"0"},{"id":"9","c_name":"Tasty food ","image":"https://developmentalphawizz.com/hojayega/uploads/6565cb8ce9b0b.png","cat_id":"0"},{"id":"10","c_name":"adfasdfasdfasd","image":"https://developmentalphawizz.com/hojayega/uploads/6567399a2cd18.png","cat_id":"0"}]

class CategoryModel {
  CategoryModel({
      String? responseCode, 
      String? msg, 
      List<CategoryData>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  CategoryModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CategoryData.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<CategoryData>? _data;
CategoryModel copyWith({  String? responseCode,
  String? msg,
  List<CategoryData>? data,
}) => CategoryModel(responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<CategoryData>? get data => _data;

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

/// id : "8"
/// c_name : "sdfasdfasd"
/// image : "https://developmentalphawizz.com/hojayega/uploads/65607ae9cc427.png"
/// cat_id : "0"

class CategoryData {
  CategoryData({
      String? id, 
      String? cName, 
      String? image, 
      String? catId,}){
    _id = id;
    _cName = cName;
    _image = image;
    _catId = catId;
}

  CategoryData.fromJson(dynamic json) {
    _id = json['id'];
    _cName = json['c_name'];
    _image = json['image'];
    _catId = json['cat_id'];
  }
  String? _id;
  String? _cName;
  String? _image;
  String? _catId;
  CategoryData copyWith({  String? id,
  String? cName,
  String? image,
  String? catId,
}) => CategoryData(  id: id ?? _id,
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