class OrderDetails {
  OrderDetails({
    required this.data,
  });

  final Datas? data;

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      data: json["data"] == null ? null : Datas.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Datas {
  Datas({
    required this.id,
    required this.orderId,
    required this.name,
    required this.phone,
    required this.email,
    required this.region,
    required this.address,
    required this.totalAmount,
    required this.totalQuanity,
    required this.deliveryCharge,
    required this.status,
    required this.comment,
    required this.createdAt,
    required this.productItems,
  });

  final int? id;
  final String? orderId;
  final String? name;
  final String? phone;
  final String? email;
  final String? region;
  final String? address;
  final String? totalAmount;
  final int? totalQuanity;
  final num? deliveryCharge;
  final String? status;
  final String? comment;
  final DateTime? createdAt;
  final List<ProductItem> productItems;

  factory Datas.fromJson(Map<String, dynamic> json) {
    return Datas(
      id: json["id"],
      orderId: json["order_id"],
      name: json["name"],
      phone: json["phone"],
      email: json["email"],
      region: json["region"],
      address: json["address"],
      totalAmount: json["total_amount"],
      totalQuanity: json["total_quanity"],
      deliveryCharge: json["delivery_charge"],
      status: json["status"],
      comment: json["comment"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      productItems: json["product_items"] == null ? [] : List<ProductItem>.from(json["product_items"]!.map((x) => ProductItem.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "name": name,
        "phone": phone,
        "email": email,
        "region": region,
        "address": address,
        "total_amount": totalAmount,
        "total_quanity": totalQuanity,
        "delivery_charge": deliveryCharge,
        "status": status,
        "comment": comment,
        "created_at": createdAt?.toIso8601String(),
        "product_items": productItems.map((x) => x.toJson()).toList(),
      };
}

class ProductItem {
  ProductItem({
    required this.productName,
    required this.quantity,
    required this.price,
    required this.vat,
    required this.subTotal,
    required this.image,
  });

  final String? productName;
  final String? quantity;
  final String? price;
  final String? vat;
  final String? subTotal;
  final String? image;

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      productName: json["product_name"],
      quantity: json["quantity"],
      price: json["price"],
      vat: json["vat"],
      subTotal: json["sub_total"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
        "product_name": productName,
        "quantity": quantity,
        "price": price,
        "vat": vat,
        "sub_total": subTotal,
        "image": image,
      };
}
