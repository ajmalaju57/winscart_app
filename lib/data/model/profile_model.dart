// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  Data data;

  ProfileModel({
    required this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  DateTime date;
  String time;
  dynamic shipmentInhand;
  dynamic asiignedOrders;
  dynamic unattented;
  dynamic amountCollected;
  dynamic deliveryCharge;
  dynamic settlementAmount;

  Data({
    required this.date,
    required this.time,
    required this.shipmentInhand,
    required this.asiignedOrders,
    required this.unattented,
    required this.amountCollected,
    required this.deliveryCharge,
    required this.settlementAmount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        date: DateTime.parse(json["date"]),
        time: json["time"],
        shipmentInhand: json["shipment_inhand"],
        asiignedOrders: json["asiigned_orders"],
        unattented: json["unattented"],
        amountCollected: json["amount_collected"],
        deliveryCharge: json["delivery_charge"],
        settlementAmount: json["settlement_amount"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "shipment_inhand": shipmentInhand,
        "asiigned_orders": asiignedOrders,
        "unattented": unattented,
        "amount_collected": amountCollected,
        "delivery_charge": deliveryCharge,
        "settlement_amount": settlementAmount,
      };
}
