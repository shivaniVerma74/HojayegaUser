class TimeSlotCharge {
  TimeSlotCharge({
    required this.responseCode,
    required this.message,
    required this.status,
    required this.data,
  });

  final String? responseCode;
  final String? message;
  final String? status;
  final Data? data;

  factory TimeSlotCharge.fromJson(Map<String, dynamic> json) {
    return TimeSlotCharge(
      responseCode: json["response_code"],
      message: json["message"],
      status: json["status"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.id,
    required this.stateTime,
    required this.endTime,
    required this.price,
    required this.createAt,
    required this.updateAt,
    required this.status,
    required this.type,
  });

  final String? id;
  final String? stateTime;
  final String? endTime;
  final String? price;
  final DateTime? createAt;
  final DateTime? updateAt;
  final String? status;
  final String? type;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"],
      stateTime: json["state_time"],
      endTime: json["end_time"],
      price: json["price"],
      createAt: DateTime.tryParse(json["create_at"] ?? ""),
      updateAt: DateTime.tryParse(json["update_at"] ?? ""),
      status: json["status"],
      type: json["type"],
    );
  }
}
