import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const channelId = "we_chat_channel";
const channelName = "WeChat Notification Channel";
const channelDescription = "WeChat Notification Channel";

class FCMService {
  static final FCMService _singleton = FCMService._internal();

  factory FCMService() => _singleton;

  FCMService._internal();

  /// fcm instance
  final FirebaseMessaging _fcmMessaging = FirebaseMessaging.instance;

  /// notification channel
  final AndroidNotificationChannel _notificationChannel =
      const AndroidNotificationChannel(
    channelId,
    channelName,
    description: channelDescription,
    importance: Importance.high,
  );

  /// notification plugin instance
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// foreground notification setting set up for ANDROID(flutter local notification)
  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings('wechat_logo');

  void listenForMessages() async {
    /// initialize local notification
    /// and register channel
    await initFlutterLocalNotification();
    await registerChannel();

    /// app is killed
    _fcmMessaging.getInitialMessage().then(
        (value) => debugPrint("APP IS KILLED >>> ${value?.data['data']}"));

    /// user tap on push notification and
    /// launch app
    /// app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      debugPrint("APP IS IN BACKGROUND >>> ${event.data['data']}");
    });

    /// firebase in active
    /// app is in foreground
    FirebaseMessaging.onMessage.listen((remoteMessage) {
      final RemoteNotification? _notification = remoteMessage.notification;
      final AndroidNotification? _androidNotification =
          remoteMessage.notification?.android;

      if (_notification != null && _androidNotification != null) {
        _notificationsPlugin.show(
          _notification.hashCode,
          _notification.title,
          _notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _notificationChannel.id,
              _notificationChannel.name,
              channelDescription: _notificationChannel.description,
              importance: Importance.max,
              icon: _androidNotification.smallIcon,
            ),
          ),
          payload: remoteMessage.data['moment_id'].toString(),
        );
      }
    });
  }

  /// initialize local notification
  Future initFlutterLocalNotification() {
    final InitializationSettings _initializationSettings =
        InitializationSettings(
      android: _androidInitializationSettings,
      iOS: null,
      macOS: null,
    );
    return _notificationsPlugin.initialize(
      _initializationSettings,
      onSelectNotification: (payload) => debugPrint(payload),
    );
  }

  /// register notification channel
  Future? registerChannel() {
    return _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_notificationChannel);
  }

  Future<String?> getFCMToken() async {
    /// get device token for notification
    return await _fcmMessaging.getToken();
  }
}
