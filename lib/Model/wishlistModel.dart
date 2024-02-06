class WishlistModel {
    WishlistModel({
        required this.responseCode,
        required this.message,
        required this.wishlist,
        required this.status,
    });

    final String? responseCode;
    final String? message;
    final List<Map<String, String>> wishlist;
    final String? status;

    factory WishlistModel.fromJson(Map<String, dynamic> json){ 
        return WishlistModel(
            responseCode: json["response_code"],
            message: json["message"],
            wishlist: json["wishlist"] == null ? [] : List<Map<String, String>>.from(json["wishlist"]!.map((x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v)))),
            status: json["status"],
        );
    }

}
