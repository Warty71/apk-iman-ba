import 'package:apk_iman_ba/pages/extra/authpage.dart';
import 'package:apk_iman_ba/services/alert_service.dart';
import 'package:apk_iman_ba/State%20Management/user_state.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class AuthService {
// Sign-In (Google)
  signInWithGoogle() async {
    // Begin the process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    // Obtain details from the request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    // Create new credentials for the user
    final credentials = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    // Sign in
    return await FirebaseAuth.instance.signInWithCredential(credentials);
  }

// Sign-In (Traditional)
  static Future<void> signUserIn(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      final userState = Provider.of<UserState>(context, listen: false);
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      final loggedInUser = userCredential.user;
      if (loggedInUser != null) {
        userState.updateUser(loggedInUser);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        AlertService.showWrongEmailMessage(context);
      } else if (e.code == 'wrong-password') {
        AlertService.showWrongPasswordMessage(context);
      }
    }
  }

// Sign-Up (Traditional)
  static Future<void> signUpEmail(
    BuildContext context,
    TextEditingController passwordController,
    TextEditingController confirmController,
    TextEditingController emailController,
  ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Try to sign up
    if (passwordController.text == confirmController.text) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const AuthPage()),
          (route) => false,
        );
      } on Exception catch (e) {
        Navigator.pop(context);
        // ignore: avoid_print
        print(e);
      }
    } else {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Sifre nisu iste."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Zatvori"),
              ),
            ],
          );
        },
      );
    }
  }
}
