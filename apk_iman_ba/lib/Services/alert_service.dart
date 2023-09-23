import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlertService {
  static void showSnackbar(
    BuildContext context, {
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.poppins(
            fontSize: 14,
          ),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

// On Sign-In, if the e-mail is incorrect.
  static void showWrongEmailMessage(BuildContext context) {
    showSnackbar(
      context,
      message: "E-mail koji ste unijeli nije registrovan.",
    );
  }

// On Sign-In, if the password is incorrect.
  static void showWrongPasswordMessage(BuildContext context) {
    showSnackbar(
      context,
      message: "Šifra koju ste unijeli nije tačna.",
    );
  }

  static void showEmailVerifMessageSuccess(BuildContext context) {
    showSnackbar(
      context,
      message: "Na Vašu email adresu je poslan verifikacijski email. "
          "Molimo Vas da verifikujete svoj email prije prijave.",
    );
  }

  // Feature coming soon alert window.
  static void showComingSoon(BuildContext context) {
    showSnackbar(
      context,
      message: "InšAllah, ubrzo dolazi ova funkcija.",
    );
  }
}
