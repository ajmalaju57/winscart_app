class AssignedOrderList {
  AssignedOrderList({
    required this.data,
  });

  final List<Data> data;

  factory AssignedOrderList.fromJson(List<dynamic> json) {
    return AssignedOrderList(
      data: json.map((item) => Data.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Data {
  Data({
    required this.id,
    required this.orderId,
    required this.productName,
    required this.phone,
    required this.totalAmount,
    required this.totalQuanity,
    required this.deliveryCharge,
    required this.whatsapp,
    required this.status,
    required this.lat,
    required this.long,
    required this.createdAt,
  });

  final int? id;
  final String? orderId;
  final String? productName;
  final String? phone;
  final String? totalAmount;
  final int? totalQuanity;
  final num? deliveryCharge;
  final String? whatsapp;
  final String? status;
  final dynamic lat;
  final dynamic long;
  final DateTime? createdAt;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"],
      orderId: json["order_id"],
      productName: json["product_name"],
      phone: json["phone"],
      totalAmount: json["total_amount"],
      totalQuanity: json["total_quanity"],
      deliveryCharge: json["delivery_charge"],
      whatsapp: json["whatsapp"],
      status: json["status"],
      lat: json["lat"],
      long: json["long"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_name": productName,
        "phone": phone,
        "total_amount": totalAmount,
        "total_quanity": totalQuanity,
        "delivery_charge": deliveryCharge,
        "whatsapp": whatsapp,
        "status": status,
        "lat": lat,
        "long": long,
        "created_at": createdAt?.toIso8601String(),
      };
}
