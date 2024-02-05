class FaqModel {
  FaqModel({
    required this.status,
    required this.msg,
    required this.setting,
  });

  final String? status;
  final String? msg;
  final List<Setting> setting;

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      status: json["status"],
      msg: json["msg"],
      setting: json["setting"] == null
          ? []
          : List<Setting>.from(
              json["setting"]!.map((x) => Setting.fromJson(x))),
    );
  }
}

class Setting {
  Setting({
    required this.id,
    required this.title,
    required this.description,
  });

  final String? id;
  final String? title;
  final String? description;

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
      id: json["id"],
      title: json["title"],
      description: json["description"],
    );
  }
}
