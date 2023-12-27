/// error : false
/// message : "Banners Found"
/// data : [{"image":"https://developmentalphawizz.com/hojayega/uploads/"},{"image":"https://developmentalphawizz.com/hojayega/uploads/"},{"image":"https://developmentalphawizz.com/hojayega/uploads/"}]

class SliderMOdel {
  SliderMOdel({
      bool? error, 
      String? message, 
      List<SliderData>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  SliderMOdel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SliderData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<SliderData>? _data;
SliderMOdel copyWith({  bool? error,
  String? message,
  List<SliderData>? data,
}) => SliderMOdel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<SliderData>? get data => _data;

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

/// image : "https://developmentalphawizz.com/hojayega/uploads/"

class SliderData {
  Data({
      String? image,}){
    _image = image;
}

  SliderData.fromJson(dynamic json) {
    _image = json['image'];
  }
  String? _image;
  SliderData copyWith({  String? image,
}) => Data(  image: image ?? _image,
);
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = _image;
    return map;
  }

}