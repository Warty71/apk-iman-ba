import 'package:apk_iman_ba/src/features/authentication/presentation/provider/user_state.dart';
import 'package:apk_iman_ba/src/features/notifications/data/repositories/notification_repository.dart';
import 'package:apk_iman_ba/src/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:apk_iman_ba/firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationRepository().initialize();

  // Initialize the notification service and listen for foreground and background notifications
  NotificationRepository notificationRepository = NotificationRepository();
  notificationRepository.handleForegroundNotifications();

  // Check if the app was opened from a terminated state
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    if (kDebugMode) {
      print(
          'Terminated Notification received: ${initialMessage.notification?.body}');
    }
    // You can handle the notification here when the app was opened from a terminated state
    // For example, you can navigate to a specific screen
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserState>(
          create: (_) => UserState(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const OnboardingPage(),
    );
  }
}
