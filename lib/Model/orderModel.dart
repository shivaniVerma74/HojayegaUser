class OrderModel {
  OrderModel({
    required this.responseCode,
    required this.message,
    required this.orders,
    required this.status,
  });

  final String? responseCode;
  final String? message;
  final List<Order> orders;
  final String? status;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      responseCode: json["response_code"],
      message: json["message"],
      orders: json["orders"] == null
          ? []
          : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
      status: json["status"],
    );
  }
}

class Order {
  Order({
    required this.orderId,
    required this.total,
    required this.date,
    required this.assignId,
    required this.driverData,
    required this.paymentMode,
    required this.address,
    required this.ordersType,
    required this.vehicleType,
    required this.time,
    required this.subTotal,
    required this.orderStatus,
    required this.deliveryCharge,
    required this.discount,
    required this.acceptRejectVendor,
    required this.paymentStatus,
    required this.vendorName,
    required this.orderItems,
    required this.count,
  });

  final String? orderId;
  final String? total;
  final DateTime? date;
  final String? assignId;
  final List<dynamic> driverData;
  final String? paymentMode;
  final String? address;
  final String? ordersType;
  final String? vehicleType;
  final String? time;
  final String? subTotal;
  final String? orderStatus;
  final String? deliveryCharge;
  final String? discount;
  final String? acceptRejectVendor;
  final String? paymentStatus;
  final String? vendorName;
  final List<OrderItem> orderItems;
  final int? count;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json["order_id"],
      total: json["total"],
      date: DateTime.tryParse(json["date"] ?? ""),
      assignId: json["assign_id"],
      driverData: json["driver_data"] == null
          ? []
          : List<dynamic>.from(json["driver_data"]!.map((x) => x)),
      paymentMode: json["payment_mode"],
      address: json["address"],
      ordersType: json["orders_type"],
      vehicleType: json["vehicle_type"],
      time: json["time"],
      subTotal: json["sub_total"],
      orderStatus: json["order_status"],
      deliveryCharge: json["delivery_charge"],
      discount: json["discount"],
      acceptRejectVendor: json["accept_reject_vendor"],
      paymentStatus: json["payment_status"],
      vendorName: json["vendor_name"],
      orderItems: json["order_items"] == null
          ? []
          : List<OrderItem>.from(
              json["order_items"]!.map((x) => OrderItem.fromJson(x))),
      count: json["count"],
    );
  }
}

class OrderItem {
  OrderItem({
    required this.productId,
    required this.catId,
    required this.subcatId,
    required this.childCategory,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productImage,
    required this.proRatings,
    required this.roleId,
    required this.sellingPrice,
    required this.productCreateDate,
    required this.vendorId,
    required this.otherImage,
    required this.productStatus,
    required this.variantName,
    required this.productType,
    required this.tax,
    required this.unit,
    required this.unitType,
    required this.qty,
  });

  final String? productId;
  final String? catId;
  final String? subcatId;
  final String? childCategory;
  final String? productName;
  final String? productDescription;
  final String? productPrice;
  final String? productImage;
  final String? proRatings;
  final String? roleId;
  final String? sellingPrice;
  final DateTime? productCreateDate;
  final String? vendorId;
  final String? otherImage;
  final String? productStatus;
  final String? variantName;
  final String? productType;
  final String? tax;
  final String? unit;
  final String? unitType;
  final String? qty;

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json["product_id"],
      catId: json["cat_id"],
      subcatId: json["subcat_id"],
      childCategory: json["child_category"],
      productName: json["product_name"],
      productDescription: json["product_description"],
      productPrice: json["product_price"],
      productImage: json["product_image"],
      proRatings: json["pro_ratings"],
      roleId: json["role_id"],
      sellingPrice: json["selling_price"],
      productCreateDate: DateTime.tryParse(json["product_create_date"] ?? ""),
      vendorId: json["vendor_id"],
      otherImage: json["other_image"],
      productStatus: json["product_status"],
      variantName: json["variant_name"],
      productType: json["product_type"],
      tax: json["tax"],
      unit: json["unit"],
      unitType: json["unit_type"],
      qty: json["qty"],
    );
  }
}
