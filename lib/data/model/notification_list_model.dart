// To parse this JSON data, do
//
//     final notificationList = notificationListFromJson(jsonString);

import 'dart:convert';

NotificationList notificationListFromJson(String str) => NotificationList.fromJson(json.decode(str));

String notificationListToJson(NotificationList data) => json.encode(data.toJson());

class NotificationList {
    List<Notifications>? data;

    NotificationList({
        this.data,
    });

    factory NotificationList.fromJson(Map<String, dynamic> json) => NotificationList(
    data: json["data"] == null
        ? []
        : List<Notifications>.from(json["data"].map((x) => Notifications.fromJson(x))),
);


    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Notifications {
    String? title;
    String? body;
    DateTime? createdAt;

    Notifications({
        this.title,
        this.body,
        this.createdAt,
    });

    factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        title: json["title"],
        body: json["body"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "created_at": createdAt?.toIso8601String(),
    };
}
