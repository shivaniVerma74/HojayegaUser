
class GetCartListModel {
  String responseCode;
  String message;
  List<CarLlist> cart;
  String cartTotal;
  String totalItems;
  String status;

  GetCartListModel({
    required this.responseCode,
    required this.message,
    required this.cart,
    required this.cartTotal,
    required this.totalItems,
    required this.status,
  });

  factory GetCartListModel.fromJson(Map<String, dynamic> json) => GetCartListModel(
    responseCode: json["response_code"],
    message: json["message"],
    cart:json["cart"]==null?[]: List<CarLlist>.from(json["cart"].map((x) => CarLlist.fromJson(x))),
    cartTotal: json["cart_total"],
    totalItems: json["total_items"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "response_code": responseCode,
    "message": message,
    "cart": List<dynamic>.from(cart.map((x) => x.toJson())),
    "cart_total": cartTotal,
    "total_items": totalItems,
    "status": status,
  };
}

class CarLlist {
  String? productId;
  String? cartId;
  String? vendorId;
  String? productImage;
  String? productName;
  String? quantity;
  String? price;

  CarLlist({
     this.productId,
     this.cartId,
    this.vendorId,
     this.productImage,
     this.productName,
     this.quantity,
     this.price,
  });

  factory CarLlist.fromJson(Map<String, dynamic> json) => CarLlist(
    productId: json["product_id"],
    cartId: json["cart_id"],
    vendorId: json["vendor_id"],
    productImage: json["product_image"],
    productName: json["product_name"],
    quantity: json["quantity"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "cart_id": cartId,
    "vendor_id": vendorId,
    "product_image": productImage,
    "product_name": productName,
    "quantity": quantity,
    "price": price,
  };
}
