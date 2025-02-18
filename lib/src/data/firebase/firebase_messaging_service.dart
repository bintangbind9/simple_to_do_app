import 'dart:convert';
import 'dart:developer' as dev;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart' show GetIt;

import '../../common/utils/platform_util.dart';

const String notificationIcon = '@mipmap/ic_launcher';

const Map<AppPlatform, bool> platformUseNotifications = {
  AppPlatform.web: false,
  AppPlatform.android: true,
  AppPlatform.fuchsia: false,
  AppPlatform.iOS: false,
  AppPlatform.linux: false,
  AppPlatform.macOS: false,
  AppPlatform.windows: false,
};

bool get isPlatformUseNotification {
  return platformUseNotifications[getCurrentPlatform] ?? false;
}

bool isTargetPlatformUseNotification(AppPlatform target) {
  return platformUseNotifications[target] ?? false;
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  if (!isPlatformUseNotification) {
    dev.log(
        '[handleBackgroundMessage] Platform ${getCurrentPlatform.name} is not using notification');
    return;
  }

  dev.log(
      'Receive Notification in background state ${getCurrentPlatform.name} App');
  dev.log('Notification Title: ${message.notification?.title}');
  dev.log('Notification Body: ${message.notification?.body}');
  dev.log('Notification Payload: ${message.data}');
}

class FirebaseMessagingService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'main_channel',
    'Main Channel Notifications',
    description: 'This channel is used for Main Channel Notifications',
    importance: Importance.defaultImportance,
  );

  final _localNotifications = GetIt.I<FlutterLocalNotificationsPlugin>();

  void handleForegroundMessage(RemoteMessage message) {
    if (!isPlatformUseNotification) {
      dev.log(
          '[handleForegroundMessage] Platform ${getCurrentPlatform.name} is not using notification');
      return;
    }

    final notification = message.notification;
    if (notification == null) return;

    dev.log(
        'Receive Notification in foreground state ${getCurrentPlatform.name} App');
    dev.log('Notification Title: ${notification.title}');
    dev.log('Notification Body: ${notification.body}');
    dev.log('Notification Payload: ${message.data}');

    _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          icon: notificationIcon,
        ),
      ),
      payload: jsonEncode(message.toMap()),
    );
  }

  void handleMessage(RemoteMessage? message) {
    if (!isPlatformUseNotification) {
      dev.log(
          '[handleMessage] Platform ${getCurrentPlatform.name} is not using notification');
      return;
    }

    if (message == null) return;

    final notification = message.notification;
    if (notification == null) return;

    dev.log('Message opened in ${getCurrentPlatform.name} App');
    dev.log('Notification Title: ${notification.title}');
    dev.log('Notification Body: ${notification.body}');
    dev.log('Notification Payload: ${message.data}');
  }

  Future<void> initLocalNotifications() async {
    if (!isPlatformUseNotification) {
      dev.log(
          '[initLocalNotifications] Platform ${getCurrentPlatform.name} is not using notification');
      return;
    }

    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings(notificationIcon);
    const settings = InitializationSettings(android: android, iOS: iOS);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (notificationResponse) {
        final payload = notificationResponse.payload;
        if (payload == null) return;

        final message = RemoteMessage.fromMap(jsonDecode(payload));
        handleMessage(message);
      },
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  void initHandlerNotifications() {
    if (!isPlatformUseNotification) {
      dev.log(
          '[initHandlerNotifications] Platform ${getCurrentPlatform.name} is not using notification');
      return;
    }

    // handle message when clicked message (notif) in app state terminated
    _firebaseMessaging.getInitialMessage().then(handleMessage);

    // handle message when clicked message (notif) in app state background
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    // handle message when receive message (notif) in app state background or terminated
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    // handle message when receive message (notif) in app state foreground
    FirebaseMessaging.onMessage.listen(handleForegroundMessage);
  }

  Future<void> initNotifications() async {
    if (!isPlatformUseNotification) {
      dev.log(
          '[initNotifications] Platform ${getCurrentPlatform.name} is not using notification');
      return;
    }

    await _firebaseMessaging.requestPermission();
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    initHandlerNotifications();
    initLocalNotifications();
  }

  Future<void> subscribeToTopic(String userUid) async {
    String topic = 'user_$userUid';

    await _firebaseMessaging.subscribeToTopic(topic);
    dev.log('Subscribed to topic: $topic');
  }

  Future<void> unsubscribeFromTopic(String? userUid) async {
    if (userUid == null) return;
    await _firebaseMessaging.unsubscribeFromTopic('user_$userUid');
  }
}
