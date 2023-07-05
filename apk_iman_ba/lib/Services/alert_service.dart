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
}
