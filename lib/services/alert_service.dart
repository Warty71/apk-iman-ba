import 'package:apk_iman_ba/services/database_service.dart';
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
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Generic method to show AlertDialog
  static void showAlertDialog(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Nazad"),
            ),
            TextButton(
              onPressed: () {
                DatabaseService().deleteUserAccount(context);
              },
              child: Text(
                "Obriši",
                style: GoogleFonts.poppins(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

// ! Account Deletion Pop Up
  static void showAccountDeleteDialog(BuildContext context) {
    showAlertDialog(context,
        title: "Jeste li sigurni?",
        content: "Klikom na 'Obriši' ćete u potpunosti obrisati svoj račun!");
  }

// ! Account Deletion Snackbar
  static void showAccountDeletionSnackBar(BuildContext context) {
    showSnackbar(context,
        message:
            "Ovo je veoma osjetljiva funkcija. Molimo Vas, prvo se odjavite i opet prijavite, da biste mogli obrisati svoj račun. Hvala.");
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

  // On Sign-In, if there are too many attempts.
  static void showTooManyAttempts(BuildContext context) {
    showSnackbar(
      context,
      message: "Previše pokušaja. Molimo pokušajte malo kasnije.",
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

  // ! Registration Page Alerts

  static void registrationPasswordsWrong(BuildContext context) {
    showSnackbar(
      context,
      message: "Šifre nisu iste.",
    );
  }

  static void registrationMailMissing(BuildContext context) {
    showSnackbar(
      context,
      message: "Morate unijeti e-mail.",
    );
  }

  static void registrationMailInvalid(BuildContext context) {
    showSnackbar(
      context,
      message: "Format e-maila nije validan.",
    );
  }

  static void registrationPasswordsWeak(BuildContext context) {
    showSnackbar(
      context,
      message: "Šifra mora imati minimalno 6 karaktera.",
    );
  }
}
