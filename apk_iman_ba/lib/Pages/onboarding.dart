import 'package:flutter/material.dart';

import 'Extra/authpage.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/onboarding01.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(76, 89, 89, 228),
                Color.fromARGB(95, 20, 6, 50),
              ],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  const Text(
                    "Dobrodošli na IMAN",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    "Jedno mjesto za sva vaša\n šerijatska pitanja",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  Ink(
                    width: 325,
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white,
                    ),
                    child: InkWell(
                      splashFactory: InkRipple.splashFactory,
                      borderRadius: BorderRadius.circular(24),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const AuthPage(),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Prijavi se",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff24195b),
                            fontSize: 18,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.36,
                          ),
                        ),
                      ),
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
