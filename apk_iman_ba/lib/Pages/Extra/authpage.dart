import 'package:apk_iman_ba/pages/homepage.dart';
import 'package:apk_iman_ba/pages/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../State Management/user_state.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context);
    if (userState.user == null) {
      return LoginPage();
    } else {
      return const HomePage();
    }
  }
}
