import 'dart:io' show Platform;

import 'package:apk_iman_ba/src/features/authentication/presentation/pages/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

import '../../../../../Services/auth_service.dart';
import '../../../../shared/common_widgets/custom_textfield.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoginLoading = false;
  bool isGoogleLoading = false;
  bool isAppleLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void handleLogin() async {
    setState(() {
      isLoginLoading = true;
    });
    await AuthService.signUserIn(context, emailController, passwordController);
    setState(() {
      isLoginLoading = false;
    });
  }

  void handleGoogleLogin() async {
    setState(() {
      isGoogleLoading = true;
    });
    await AuthService().signInWithGoogle(context);
    setState(() {
      isGoogleLoading = false;
    });
  }

  void handleAppleLogin() async {
    setState(() {
      isAppleLoading = true;
    });

    await AuthService()
        .signInWithApple(context, scopes: [Scope.email, Scope.fullName]);

    setState(() {
      isAppleLoading = true;
    });
  }

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
            child: SingleChildScrollView(
              reverse: true,
              child: Column(children: [
                // Iman Logo
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset("assets/images/logo.jpg"),
                  ),
                ),

                // Dobrodosli na IMAN
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Dobrodošli na IMAN",
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
                    "Prijavite se na svoj IMAN račun\n ili kreirajte novi",
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
                        hintText: 'Vaš e-mail',
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
                        "Šifra",
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

                // Registracija i Zaboravili ste šifru?
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const RegistrationPage(),
                          ),
                        ),
                        child: Text(
                          "Registracija",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff5449d2),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ForgotPasswordPage(),
                          ),
                        ),
                        child: Text(
                          "Zaboravili ste šifru?",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff5449d2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // "Prijavi se - button"
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Ink(
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
                    child: InkWell(
                      splashFactory: InkRipple.splashFactory,
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        handleLogin();
                      },
                      child: Center(
                        child: isLoginLoading
                            ? const SpinKitDualRing(
                                size: 24,
                                color: Colors.white,
                              )
                            : const Text(
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
                ),

                // Text - Prijavite se preko Google racuna
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Prijavite se drugim metodama",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: const Color(0xff626164),
                      letterSpacing: 0.32,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // Buttons - Google & Apple Login
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (Platform.isIOS) // Show for iOS only
                        Ink(
                          width: 65,
                          height: 64,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xff626164),
                            ),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: InkWell(
                            splashFactory: InkRipple.splashFactory,
                            borderRadius: BorderRadius.circular(24),
                            onTap: () {
                              handleAppleLogin();
                            },
                            child: isAppleLoading
                                ? const SpinKitDualRing(
                                    color: Colors.black,
                                    size: 24,
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      "assets/images/apple.png",
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                          ),
                        ),
                      if (Platform.isIOS)
                        const SizedBox(
                          width: 20,
                        ),
                      if (Platform.isIOS)
                        Ink(
                          width: 65,
                          height: 64,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xff626164),
                            ),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: InkWell(
                            splashFactory: InkRipple.splashFactory,
                            borderRadius: BorderRadius.circular(24),
                            onTap: () {
                              handleGoogleLogin();
                            },
                            child: isGoogleLoading
                                ? const SpinKitDualRing(
                                    color: Colors.black,
                                    size: 24,
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      "assets/images/google.png",
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                          ),
                        ),
                      if (Platform.isAndroid)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Ink(
                            width: 325,
                            height: 64,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xff626164),
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: InkWell(
                              splashFactory: InkRipple.splashFactory,
                              borderRadius: BorderRadius.circular(24),
                              onTap: () {
                                handleGoogleLogin();
                              },
                              child: isGoogleLoading
                                  ? const SpinKitDualRing(
                                      color: Colors.black,
                                      size: 24,
                                    )
                                  : Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 10.0, 0),
                                          width: 24,
                                          height: 24,
                                          child: Image.asset(
                                              "assets/images/google.png"),
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
                          ),
                        ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
