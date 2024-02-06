class VendorBankDetailModel {
  VendorBankDetailModel({
    required this.responseCode,
    required this.msg,
    required this.data,
  });

  final String? responseCode;
  final String? msg;
  final List<Datum> data;

  factory VendorBankDetailModel.fromJson(Map<String, dynamic> json) {
    return VendorBankDetailModel(
      responseCode: json["response_code"],
      msg: json["msg"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }
}

class Datum {
  Datum({
    required this.id,
    required this.bankName,
    required this.accountNumber,
    required this.ifscCode,
    required this.upiId,
    required this.qrCode,
    required this.vendorId,
  });

  final String? id;
  final String? bankName;
  final String? accountNumber;
  final String? ifscCode;
  final String? upiId;
  final String? qrCode;
  final String? vendorId;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["id"],
      bankName: json["bank_name"],
      accountNumber: json["account_number"],
      ifscCode: json["ifsc_code"],
      upiId: json["upi_id"],
      qrCode: json["qr_code"],
      vendorId: json["vendor_id"],
    );
  }
}
