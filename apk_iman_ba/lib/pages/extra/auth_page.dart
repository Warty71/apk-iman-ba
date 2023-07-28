import 'package:apk_iman_ba/pages/login_page.dart';
import 'package:apk_iman_ba/components/custom_bnb.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../State Management/user_state.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context);

    // Check if the user ID is already saved in shared preferences
    final prefsFuture = SharedPreferences.getInstance();
    prefsFuture.then((prefs) {
      final userId = prefs.getString('user_id');

      if (userId != null) {
        // If the user ID is available, set the user as logged in
        Provider.of<UserState>(context, listen: false)
            .updateUser(FirebaseAuth.instance.currentUser);
      }
    });

    if (userState.user == null) {
      return const LoginPage();
    } else {
      return const CustomBNB();
    }
  }
}
