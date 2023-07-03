import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
// Google Sign In
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

// Sign Up (using E-mail and PW)
  static Future<void> signUpEmail(
    BuildContext context,
    passwordController,
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
        Navigator.pop(context);
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
