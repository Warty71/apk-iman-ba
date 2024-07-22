import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationRepository {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // Initialize Firebase
    await _firebaseMessaging.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
  }

  Future<String?> getFCMToken() async {
    // Get the FCM token for the current device
    String? token = await _firebaseMessaging.getToken();
    return token;
  }

  // Method to handle foreground and background notifications
  void handleForegroundNotifications() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // You can handle the notification here when the app is in the foreground
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // You can handle the notification here when the app is in the background
      // For example, you can navigate to a specific screen
    });
  }
}
