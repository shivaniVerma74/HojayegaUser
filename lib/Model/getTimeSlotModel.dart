class GetTimeSlotModel {
  int status;
  String msg;
  List<TimeSlotListBooking> booking;

  GetTimeSlotModel({
    required this.status,
    required this.msg,
    required this.booking,
  });

  factory GetTimeSlotModel.fromJson(Map<String, dynamic> json) => GetTimeSlotModel(
    status: json["status"],
    msg: json["msg"],
    booking: List<TimeSlotListBooking>.from(json["booking"].map((x) => TimeSlotListBooking.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "booking": List<dynamic>.from(booking.map((x) => x.toJson())),
  };
}

class TimeSlotListBooking {
  String ?id;
  String? fromTime;
  String? toTime;
  String? status;

  TimeSlotListBooking({
     this.id,
     this.fromTime,
     this.toTime,
     this.status,
  });

  factory TimeSlotListBooking.fromJson(Map<String, dynamic> json) => TimeSlotListBooking(
    id: json["id"],
    fromTime: json["from_time"],
    toTime: json["to_time"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "from_time": fromTime,
    "to_time": toTime,
    "status": status,
  };
}
