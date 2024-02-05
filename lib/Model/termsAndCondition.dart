class TermsAndCondition {
  TermsAndCondition({
    required this.status,
    required this.msg,
    required this.setting,
  });

  final String? status;
  final String? msg;
  final Setting? setting;

  factory TermsAndCondition.fromJson(Map<String, dynamic> json) {
    return TermsAndCondition(
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
    required this.title,
    required this.slug,
    required this.html,
    required this.createdAt,
    required this.updatedAt,
    required this.heading,
    required this.img1,
    required this.img2,
    required this.img3,
    required this.img4,
    required this.url,
  });

  final String? id;
  final String? title;
  final String? slug;
  final String? html;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? heading;
  final String? img1;
  final String? img2;
  final String? img3;
  final String? img4;
  final String? url;

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
      id: json["id"],
      title: json["title"],
      slug: json["slug"],
      html: json["html"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      heading: json["heading"],
      img1: json["img_1"],
      img2: json["img_2"],
      img3: json["img_3"],
      img4: json["img_4"],
      url: json["url"],
    );
  }
}
