class NotificationModel {
    NotificationModel({
        required this.responseCode,
        required this.message,
        required this.notifications,
        required this.status,
    });

    final String? responseCode;
    final String? message;
    final List<Notification> notifications;
    final String? status;

    factory NotificationModel.fromJson(Map<String, dynamic> json){ 
        return NotificationModel(
            responseCode: json["response_code"],
            message: json["message"],
            notifications: json["notifications"] == null ? [] : List<Notification>.from(json["notifications"]!.map((x) => Notification.fromJson(x))),
            status: json["status"],
        );
    }

}

class Notification {
    Notification({
        required this.notId,
        required this.userId,
        required this.dataId,
        required this.type,
        required this.title,
        required this.message,
        required this.date,
    });

    final String? notId;
    final String? userId;
    final String? dataId;
    final String? type;
    final String? title;
    final String? message;
    final DateTime? date;

    factory Notification.fromJson(Map<String, dynamic> json){ 
        return Notification(
            notId: json["not_id"],
            userId: json["user_id"],
            dataId: json["data_id"],
            type: json["type"],
            title: json["title"],
            message: json["message"],
            date: DateTime.tryParse(json["date"] ?? ""),
        );
    }

}
