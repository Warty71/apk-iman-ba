import 'package:apk_iman_ba/Pages/Extra/authpage.dart';
import 'package:apk_iman_ba/Services/alert_service.dart';
import 'package:apk_iman_ba/State%20Management/user_state.dart';
import 'package:apk_iman_ba/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class AuthService {
// Sign-In (Google)
  signInWithGoogle(BuildContext context) async {
    try {
      // Begin the process
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      // Obtain details from the request
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      // Create new credentials for the user
      final credentials = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credentials);

      final User? loggedInUser = userCredential.user;
      if (loggedInUser != null) {
        // Update the user state using the provider
        // ignore: use_build_context_synchronously
        Provider.of<UserState>(context, listen: false).updateUser(loggedInUser);

        // Check if it's the user's first login
        final DatabaseReference userRef = FirebaseDatabase.instance
            .ref()
            .child("Korisnici")
            .child(loggedInUser.uid);
        final DatabaseEvent event = await userRef.once();
        final DataSnapshot snapshot = event.snapshot;
        final dynamic userData = snapshot.value;

        if (userData == null) {
          // User's first login, copy data to Realtime Database
          final newUser = Users.fromJson({
            'id': loggedInUser.uid,
            'email': loggedInUser.email,
            'favoriteQuestions': [],
            'personalQuestions': [],
          });
          await userRef.set(newUser.toJson());
        }
      }

      // Sign in
      return userCredential;
    } catch (e, stackTrace) {
      // Handle and log the error
      debugPrint('Failed to sign in with Google: $e');
      debugPrintStack(label: 'StackTrace: ', stackTrace: stackTrace);
      return null;
    }
  }

// Sign-In (Traditional)
  static Future<void> signUserIn(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) async {
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

        final DatabaseReference userRef = FirebaseDatabase.instance
            .ref()
            .child("Korisnici")
            .child(loggedInUser.uid);
        final DatabaseEvent event = await userRef.once();
        final DataSnapshot snapshot = event.snapshot;
        final dynamic userData = snapshot.value;

        if (userData == null) {
          // User's first login, copy data to Realtime Database
          final newUser = Users.fromJson({
            'id': loggedInUser.uid,
            'email': loggedInUser.email,
            'favoriteQuestions': [],
            'personalQuestions': [],
          });
          await userRef.set(newUser.toJson());
        }
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
