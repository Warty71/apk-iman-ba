import 'package:apk_iman_ba/Pages/Extra/authpage.dart';
import 'package:flutter/material.dart';

class AlertService {
// On Sign-In, if the e-mail is incorrect.
  static void showWrongEmailMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Pogresan email"),
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

// On Sign-In, if the password is incorrect.
  static void showWrongPasswordMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Pogresna sifra"),
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

  static void showEmailVerifMessageSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Registracija uspješna"),
          content: const Text(
            "Na Vašu email adresu je poslan verifikacijski email. "
            "Molimo Vas da verifikujete svoj email prije prijave.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const AuthPage()),
                  (route) => false,
                );
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
