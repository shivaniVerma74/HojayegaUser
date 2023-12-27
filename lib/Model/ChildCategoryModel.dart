/// response_code : "1"
/// msg : "Categories Found"
/// data : [{"id":"1","c_name":"tes","image":"https://developmentalphawizz.com/hojayega/uploads/","cat_id":"10","sub_cat_id":"11"}]

class ChildCategoryModel {
  ChildCategoryModel({
      String? responseCode, 
      String? msg, 
      List<ChildCategoryData>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  ChildCategoryModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ChildCategoryData.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<ChildCategoryData>? _data;
ChildCategoryModel copyWith({  String? responseCode,
  String? msg,
  List<ChildCategoryData>? data,
}) => ChildCategoryModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<ChildCategoryData>? get data => _data;

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

/// id : "1"
/// c_name : "tes"
/// image : "https://developmentalphawizz.com/hojayega/uploads/"
/// cat_id : "10"
/// sub_cat_id : "11"

class ChildCategoryData {
  ChildCategoryData({
      String? id, 
      String? cName, 
      String? image, 
      String? catId, 
      String? subCatId,}){
    _id = id;
    _cName = cName;
    _image = image;
    _catId = catId;
    _subCatId = subCatId;
}

  ChildCategoryData.fromJson(dynamic json) {
    _id = json['id'];
    _cName = json['c_name'];
    _image = json['image'];
    _catId = json['cat_id'];
    _subCatId = json['sub_cat_id'];
  }
  String? _id;
  String? _cName;
  String? _image;
  String? _catId;
  String? _subCatId;
  ChildCategoryData copyWith({  String? id,
  String? cName,
  String? image,
  String? catId,
  String? subCatId,
}) => ChildCategoryData(  id: id ?? _id,
  cName: cName ?? _cName,
  image: image ?? _image,
  catId: catId ?? _catId,
  subCatId: subCatId ?? _subCatId,
);
  String? get id => _id;
  String? get cName => _cName;
  String? get image => _image;
  String? get catId => _catId;
  String? get subCatId => _subCatId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['c_name'] = _cName;
    map['image'] = _image;
    map['cat_id'] = _catId;
    map['sub_cat_id'] = _subCatId;
    return map;
  }

}