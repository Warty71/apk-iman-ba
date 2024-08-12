import 'package:apk_iman_ba/src/features/notifications/data/repositories/notification_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Future<void> initialize() async {
    await requestNotificationPermissions();
    setupNotificationListeners();
  }

  @override
  Future<String?> getFCMToken() async {
    // Get the FCM token for the current device
    String? token = await _firebaseMessaging.getToken();
    return token;
  }

  @override
  Future<void> requestNotificationPermissions() async {
    // Request notification permissions
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    debugPrint('User granted permission: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User has granted permission.');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User has granted provisional permission.');
    } else {
      debugPrint('User has not granted permission.');
    }
  }

  void setupNotificationListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(
          'Received a message while in the foreground: ${message.messageId}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('App opened from a background state: ${message.messageId}');
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    debugPrint('Handling a background message: ${message.messageId}');
  }
}
