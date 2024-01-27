import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../MainClass.dart';

Future<void> handleBackgroundMessage(RemoteMessage? message) async {}

class FirebaseApi {
  // Private constructor to prevent instantiation from outside.
  FirebaseApi._privateConstructor();

  // The single instance of the class.
  static final FirebaseApi _instance = FirebaseApi._privateConstructor();
   String? fcmToken;
// Getter to access the instance.
  factory FirebaseApi() {
    return _instance;
  }

  // create an instance of firebase messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
      "high_importance_channel", "High Importance Notification",
      description: "Jatin Kum Sahoo", importance: Importance.defaultImportance);

  final _localNotification = FlutterLocalNotificationsPlugin();

  getFCMToken() async {
    fcmToken = await _firebaseMessaging.getToken();
    print(">>>>>>>>>>>>>>>>>>>Token$fcmToken");
  }

  // function to initialize notification
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    fcmToken = await _firebaseMessaging.getToken();
    print(">>>>>>>>>>>>>>>>>>>Token$fcmToken");
    initPushNotifications();
    initLocalNotifications();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed("/logesticdashboard", arguments: {});

    // get in notification page final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
  }

  // function to initialize background settings

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            sound: true, alert: true, badge: true);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      _localNotification.show(
        notification.hashCode,
        notification.title ?? "",
        notification.body ?? "Please be ready for trips",
        NotificationDetails(
            android: AndroidNotificationDetails(
                _androidChannel.id ?? "eViman-rider",
                _androidChannel.name ?? "foregrounf service",
                channelDescription: _androidChannel.description,
                icon: '@mipmap/ic_launcher',
                ongoing: true,
                enableVibration: true,
                importance: Importance.high,
                autoCancel: true,
                sound:
                    const RawResourceAndroidNotificationSound('excuseme_boss'),
                channelShowBadge: true,
                enableLights: true,
                color: Colors.green,
                colorized: true,
                playSound: true)),
      );
    });
  }

  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings("@drawable/ic_launcher");
    const ios = DarwinInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: ios);
    await _localNotification.initialize(settings,
        onDidReceiveNotificationResponse: (payload) {
      final message = RemoteMessage.fromMap(jsonDecode(payload.payload ?? ""));
      handleMessage(message);
    });
    final platform = _localNotification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }
}
