class PrivacyPolicy {
  PrivacyPolicy({
    required this.status,
    required this.msg,
    required this.setting,
  });

  final String? status;
  final String? msg;
  final Setting? setting;

  factory PrivacyPolicy.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicy(
      status: json["status"],
      msg: json["msg"],
      setting:
          json["setting"] == null ? null : Setting.fromJson(json["setting"]),
    );
  }
}

class Setting {
  Setting({
    required this.id,
    required this.data,
    required this.discription,
  });

  final String? id;
  final String? data;
  final String? discription;

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
      id: json["id"],
      data: json["data"],
      discription: json["discription"],
    );
  }
}
