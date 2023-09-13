import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  "High Importance Notifications",
  description: "This channel is used important notification",
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationplugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Handling a background message : ${message.messageId}");
  debugPrint(message.data.toString());
}

class FirebaseNotifcation {
  late FirebaseMessaging _messaging;

  Future<String?> initialize() async {
    _messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await flutterLocalNotificationplugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    var intializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: intializationSettingsAndroid);

    flutterLocalNotificationplugin.initialize(initializationSettings);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      debugPrint("onMessageOpenedApp: $message");
      // navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => const NotificationPage()));
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      debugPrint("onMessageOpenedApp: $message");
      RemoteNotification? notification = message?.notification;
      AndroidNotification? android = message?.notification?.android;
      if (notification != null && android != null) {
        // navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => const NotificationPage()));
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        AndroidNotificationDetails notificationDetails =
            AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                importance: Importance.max,
                priority: Priority.high,
                groupKey: channel.groupId);
        NotificationDetails notificationDetailsPlatformSpefics =
            NotificationDetails(android: notificationDetails);
        flutterLocalNotificationplugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            notificationDetailsPlatformSpefics);
      }
    });
    await _messaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    if (Platform.isIOS) {
      await _messaging.getAPNSToken();
    }
    return await getToken();
  }

  Future<String?> getToken() async {
    String? token = await _messaging.getToken();
    debugPrint("Firebase token : $token");
    return token;
  }

  subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
  }
}
