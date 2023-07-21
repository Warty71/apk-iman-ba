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
            'zadnjePitanje': '2021-01-11T21:47:42.316387',
            'favoriteQuestions': [],
            'personalQuestions': [],
            'naČekanjuPitanja': [],
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

  static Future<void> signUserIn(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      final loggedInUser = userCredential.user;

      if (loggedInUser != null) {
        if (!loggedInUser.emailVerified) {
          // If the email is not verified, display an error message and prevent login.
          await FirebaseAuth.instance.signOut();
          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("E-mail nije verifikovan."),
                content: const Text(
                  "Molimo vas da potvrdite vas e-mail prije prijave.",
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"),
                  ),
                ],
              );
            },
          );
        } else {
          // Email is verified, continue with login.
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
              'zadnjePitanje': '2021-01-11T21:47:42.316387',
              'favoriteQuestions': [],
              'personalQuestions': [],
              'naČekanjuPitanja': [],
            });
            await userRef.set(newUser.toJson());
          }

          // Update the user state using the provider
          // ignore: use_build_context_synchronously
          Provider.of<UserState>(context, listen: false)
              .updateUser(loggedInUser);
        }
      }
    } on FirebaseAuthException catch (e) {
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
        final UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        // Send email verification
        await userCredential.user?.sendEmailVerification();

        // ignore: use_build_context_synchronously
        AlertService.showEmailVerifMessageSuccess(context);
      } on Exception catch (e) {
        Navigator.pop(context);
        // Handle the sign-up error (e.g., display an error message)
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Greška prilikom registracije"),
              content: Text(e.toString()),
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
