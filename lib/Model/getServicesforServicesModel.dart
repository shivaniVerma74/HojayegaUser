
class GetservicesForServicesModel {
  bool error;
  String message;
  List<GetServicesListModel> data;

  GetservicesForServicesModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory GetservicesForServicesModel.fromJson(Map<String, dynamic> json) => GetservicesForServicesModel(
    error: json["error"],
    message: json["message"],
    data: List<GetServicesListModel>.from(json["data"].map((x) => GetServicesListModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetServicesListModel {
  String? id;
  String? name;
  String? image;
  String ?type;
  String? title;

  GetServicesListModel({
    this.id,
    this.name,
    this.image,
    this.type,
    this.title,
  });

  factory GetServicesListModel.fromJson(Map<String, dynamic> json) => GetServicesListModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    type: json["type"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "type": type,
    "title": title,
  };
}
