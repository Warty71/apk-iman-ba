import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WaitAnswerpage extends StatefulWidget {
  final String questionTitle;

  const WaitAnswerpage({super.key, required this.questionTitle});

  @override
  State<WaitAnswerpage> createState() => _WaitAnswerpageState();
}

class _WaitAnswerpageState extends State<WaitAnswerpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: const Color(0xffeff2f8),
                          ),
                          height: 48,
                          child: Image.asset(
                            "assets/images/back.png",
                            height: 4,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: Colors.white),
                          height: 48,
                          width: 48,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Vase pitanje
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Text(
                    "Vaše pitanje: ",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.14,
                      color: const Color(0xFF626164),
                    ),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    widget.questionTitle,
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF201E22)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Text(
                    "Odgovor: ",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.14,
                      color: const Color(0xFF626164),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Text(
                    "Molimo da sačekate dok naš tim da odgovor na vaše pitanje.",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.28,
                      color: const Color(0xFFA6A6AD),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: SizedBox(
                    height: 250,
                    width: 250,
                    child: Image.asset(
                      'assets/images/hourglass.png',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
