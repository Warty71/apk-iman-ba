import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Components/custom_textfield.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  //SignUp method
  Future signUserUp(BuildContext context) async {
    //Show dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    //Try to sign up. I need to add an error MSG in case the passwords don't match
    if (passwordController.text == confirmController.text) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } on Exception catch (e) {
        Navigator.pop(context);
        // ignore: avoid_print
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  // Iman Logo
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset("lib/Images/Logo.jpg"),
                    ),
                  ),

                  // Text - Registracija
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Registracija",
                      style: GoogleFonts.poppins(
                        color: const Color(0xff190c3f),
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  // Text - Napravite novi racun
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      "Napravite novi racun",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color(0xff626164),
                        letterSpacing: 0.32,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  // Text - Email + TextField
                  Container(
                    margin: const EdgeInsets.fromLTRB(25, 10, 25, 5),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "E-mail",
                          style: GoogleFonts.poppins(
                            color: const Color(0xff201d22),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        CustomTextField(
                          controller: emailController,
                          hintText: 'Vas e-mail',
                          obscureText: false,
                        ),
                      ],
                    ),
                  ),

                  // Text - Sifra + TextField
                  Container(
                    margin: const EdgeInsets.fromLTRB(25, 5, 25, 10),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sifra",
                          style: GoogleFonts.poppins(
                            color: const Color(0xff201d22),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        CustomTextField(
                          hintText: "**********",
                          controller: passwordController,
                          obscureText: true,
                        )
                      ],
                    ),
                  ),

                  // Text - Potvrda + TextField
                  Container(
                    margin: const EdgeInsets.fromLTRB(25, 5, 25, 10),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Potvrda",
                          style: GoogleFonts.poppins(
                            color: const Color(0xff201d22),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        CustomTextField(
                          hintText: "**********",
                          controller: confirmController,
                          obscureText: true,
                        )
                      ],
                    ),
                  ),

                  // Button - Registracija
                  GestureDetector(
                    onTap: () {
                      signUserUp(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                      width: 325,
                      height: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: const RadialGradient(
                          center: Alignment(-1.538, -3.615),
                          radius: 4,
                          colors: <Color>[Color(0xff5959e4), Color(0xff140632)],
                          stops: <double>[0, 0.99],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Registruj se",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.36,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Text - Registrujte se sa Google racunom
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Registrujte se sa Google racunom",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color(0xff626164),
                        letterSpacing: 0.32,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  // Button - Google Register
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                    width: 325,
                    height: 64,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff626164),
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                          width: 24,
                          height: 24,
                          child: Image.asset("lib/Images/google.png"),
                        ),
                        const Text(
                          "Google",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff24195b),
                            fontSize: 18,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.36,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
