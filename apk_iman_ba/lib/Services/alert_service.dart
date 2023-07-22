import 'package:apk_iman_ba/Pages/Extra/authpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertService {
  static void _showPlatformSpecificAlertDialog(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    if (Theme.of(context).platform == TargetPlatform.android) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
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
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              CupertinoDialogAction(
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

// On Sign-In, if the e-mail is incorrect.
  static void showWrongEmailMessage(BuildContext context) {
    _showPlatformSpecificAlertDialog(
      context,
      title: "Pogresan e-mail",
      content:
          "E-mail koji ste unijeli nije registrovan.", // Customize the content here
    );
  }

// On Sign-In, if the password is incorrect.
  static void showWrongPasswordMessage(BuildContext context) {
    _showPlatformSpecificAlertDialog(
      context,
      title: "Pogresna šifra",
      content:
          "Šifra koju ste unijeli nije tačna.", // Customize the content here
    );
  }

  static void showEmailVerifMessageSuccess(BuildContext context) {
    _showPlatformSpecificAlertDialog(
      context,
      title: "Registracija uspješna",
      content: "Na Vašu email adresu je poslan verifikacijski email. "
          "Molimo Vas da verifikujete svoj email prije prijave.", // Customize the content here
    );
  }
}
