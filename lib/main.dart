import 'package:apk_iman_ba/src/features/authentication/presentation/provider/user_state.dart';
import 'package:apk_iman_ba/src/features/notifications/data/repositories/notification_repository.dart';
import 'package:apk_iman_ba/src/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:apk_iman_ba/src/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:apk_iman_ba/src/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:apk_iman_ba/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserState>(
          create: (_) => UserState(),
        ),
        RepositoryProvider<NotificationRepository>(
          create: (context) => NotificationRepositoryImpl(),
        ),
        BlocProvider<NotificationCubit>(
          create: (context) => NotificationCubit(
            context.read<NotificationRepository>(),
          ),
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
    context.read<NotificationCubit>().init();
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingPage(),
    );
  }
}
