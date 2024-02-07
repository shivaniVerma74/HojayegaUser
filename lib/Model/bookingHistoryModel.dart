class BookingModel {
  BookingModel({
    required this.responseCode,
    required this.msg,
    required this.data,
  });

  final String? responseCode;
  final String? msg;
  final List<BookingData> data;

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      responseCode: json["response_code"],
      msg: json["msg"],
      data: json["data"] == null
          ? []
          : List<BookingData>.from(
              json["data"]!.map((x) => BookingData.fromJson(x))),
    );
  }
}

class BookingData {
  BookingData({
    required this.email,
    required this.mobile,
    required this.username,
    required this.vendorName,
    required this.vendorAddress,
    required this.bookingAmount,
    required this.shopImage,
    required this.date,
    required this.status,
    required this.booking_id,
  });

  final String? email;
  final String? mobile;
  final String? username;
  final String? vendorName;
  final String? vendorAddress;
  final String? bookingAmount;
  final String? shopImage;
  final String? date;
  final String? status;
  final String? booking_id;

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      email: json["email"],
      mobile: json["mobile"],
      username: json["username"],
      vendorName: json["vendor_name"],
      vendorAddress: json["vendor_address"],
      bookingAmount: json["booking_amount"],
      shopImage: json["shop_image"],
      date: json['date'],
      status: json['status'],
      booking_id: json['booking_id'],
    );
  }
}
