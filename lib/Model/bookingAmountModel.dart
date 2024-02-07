class BookingAmountModel {
    BookingAmountModel({
        required this.responseCode,
        required this.msg,
        required this.data,
    });

    final String? responseCode;
    final String? msg;
    final List<BookingAmount> data;

    factory BookingAmountModel.fromJson(Map<String, dynamic> json){ 
        return BookingAmountModel(
            responseCode: json["response_code"],
            msg: json["msg"],
            data: json["data"] == null ? [] : List<BookingAmount>.from(json["data"]!.map((x) => BookingAmount.fromJson(x))),
        );
    }

}

class BookingAmount {
    BookingAmount({
        required this.serviceName,
        required this.price,
    });

    final String? serviceName;
    final String? price;

    factory BookingAmount.fromJson(Map<String, dynamic> json){ 
        return BookingAmount(
            serviceName: json["service_name"],
            price: json["price"],
        );
    }

}
