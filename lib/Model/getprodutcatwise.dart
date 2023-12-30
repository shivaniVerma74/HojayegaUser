
class GerProductcatWise {
  String status;
  String message;
  List<Product> products;

  GerProductcatWise({
    required this.status,
    required this.message,
    required this.products,
  });

  factory GerProductcatWise.fromJson(Map<String, dynamic> json) => GerProductcatWise(
    status: json["status"],
    message: json["message"],
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Product {
  String? productId;
  String? catId;
  String? subcatId;
  String? childCategory;
  String ?productName;
  String? productDescription;
  String? productPrice;
  List<String>? productImage;
  String? proRatings;
  String? roleId;
  String? sellingPrice;
  DateTime? productCreateDate;
  String? vendorId;
  String ?otherImage;
  String? productStatus;
  String? variantName;
  String? productType;
  String? tax;
  String? unit;

  Product({
    this.productId,
    this.catId,
    this.subcatId,
    this.childCategory,
    this.productName,
    this.productDescription,
    this.productPrice,
    this.productImage,
    this.proRatings,
    this.roleId,
    this.sellingPrice,
    this.productCreateDate,
    this.vendorId,
    this.otherImage,
    this.productStatus,
    this.variantName,
    this.productType,
    this.tax,
    this.unit,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json["product_id"],
    catId: json["cat_id"],
    subcatId: json["subcat_id"],
    childCategory: json["child_category"],
    productName: json["product_name"],
    productDescription: json["product_description"],
    productPrice: json["product_price"],
    productImage:json["product_image"]==null?[]: List<String>.from(json["product_image"].map((x) => x)),
    proRatings: json["pro_ratings"],
    roleId: json["role_id"],
    sellingPrice: json["selling_price"],
    productCreateDate: DateTime.parse(json["product_create_date"]),
    vendorId: json["vendor_id"],
    otherImage: json["other_image"],
    productStatus: json["product_status"],
    variantName: json["variant_name"],
    productType: json["product_type"],
    tax: json["tax"],
    unit: json["unit"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "cat_id": catId,
    "subcat_id": subcatId,
    "child_category": childCategory,
    "product_name": productName,
    "product_description": productDescription,
    "product_price": productPrice,
    "product_image": List<dynamic>.from(productImage!.map((x) => x)),
    "pro_ratings": proRatings,
    "role_id": roleId,
    "selling_price": sellingPrice,
    "product_create_date": productCreateDate,
    "vendor_id": vendorId,
    "other_image": otherImage,
    "product_status": productStatus,
    "variant_name": variantName,
    "product_type": productType,
    "tax": tax,
    "unit": unit,
  };
}
