import 'package:apk_iman_ba/pages/onboarding_page.dart';
import 'package:apk_iman_ba/firebase_options.dart';
import 'package:apk_iman_ba/services/notification_service.dart';
import 'package:apk_iman_ba/utility/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'state_management/user_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationService().initialize();

  // Initialize the notification service and listen for foreground and background notifications
  NotificationService notificationService = NotificationService();
  notificationService.handleForegroundNotifications();

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
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key) {
    Utils().getNumberOfAnswers().then((numberOfAnswers) {
      print("Pitanja i Odgovori: $numberOfAnswers");
    }).catchError((error) {
      print("Error getting number of answers: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingPage(),
    );
  }
}
