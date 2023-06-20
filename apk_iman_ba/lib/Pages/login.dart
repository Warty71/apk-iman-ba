import 'package:apk_iman_ba/Pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Components/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
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

                // Dobrodosli na IMAN
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Dobrodosli na IMAN",
                    style: GoogleFonts.poppins(
                      color: const Color(0xff190c3f),
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // Prijavite se na svoj IMAN racun ili kreirajte novi
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    "Prijavite se na svoj IMAN racun\n ili kreirajte novi",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: const Color(0xff626164),
                      letterSpacing: 0.32,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // E-mail text i field za unos e-maila
                Container(
                  margin: const EdgeInsets.fromLTRB(25, 25, 25, 5),
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

                // Sifra i textfield za unos sifre
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
                          obscureText: true)
                    ],
                  ),
                ),

                // Zaboravili ste sifru?
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Zaboravili ste sifru?",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff5449d2),
                        ),
                      ),
                    ),
                  ),
                ),

                // "Prijavi se - button"
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const HomePage(),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
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
                        "Prijavi se",
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

                // Prijavite se preko Google racuna
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    "Prijavite se preko Google racuna",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: const Color(0xff626164),
                      letterSpacing: 0.32,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // Google Log In
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
                        "Google Login",
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
    );
  }
}
