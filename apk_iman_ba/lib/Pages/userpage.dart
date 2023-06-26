import 'package:apk_iman_ba/Pages/historypage.dart';
import 'package:apk_iman_ba/Pages/myquestionspage.dart';
import 'package:apk_iman_ba/Pages/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'favoritespage.dart';
import 'homepage.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Postavi pitanje"),
        backgroundColor: const Color(0xff5449d2),
        extendedPadding: const EdgeInsets.all(55),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const RadialGradient(
                center: Alignment(-1.538, -3.615),
                radius: 4,
                colors: <Color>[Color(0xff5959e4), Color(0xff140632)],
                stops: <double>[0, 0.99],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const HomePage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.home_outlined),
                    color: Colors.white54,
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const SearchPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.search_outlined),
                    color: Colors.white54,
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const FavoritesPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.favorite_outline),
                    color: Colors.white54,
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.person_2_outlined),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "Moj Racun",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.32,
                          color: const Color(0xFF201E22),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                    Container(
                      width: double.maxFinite,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1.5,
                            color: Color(0xFFEFF2F8),
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: Text(
                          "meris.lihic@gmail.com",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.14,
                            color: const Color(0xFF201D22),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // PITANJA
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    25,
                    25,
                    25,
                    5,
                  ),
                  child: Text(
                    "PITANJA",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.36,
                      color: const Color(0xFF201E22),
                    ),
                  ),
                ),
              ),

              // Moja Pitanja
              Container(
                margin: const EdgeInsets.fromLTRB(25, 5, 25, 10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xCCEFF2F8),
                      width: 3,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person_outline, size: 24),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              "Moja Pitanja",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                letterSpacing: 0.28,
                                color: const Color(0xFF201E22),
                              ),
                            ),
                          ),
                          const Text(
                            "(12)",
                          ),
                        ],
                      ),
                      IconButton(
                        iconSize: 20,
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const MyQuestionsPage(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),

              // Zadnje otvarana pitanja
              Container(
                margin: const EdgeInsets.fromLTRB(25, 5, 25, 10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xCCEFF2F8),
                      width: 3,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.history, size: 24),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              "Zadnje otvarana pitanja",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                letterSpacing: 0.28,
                                color: const Color(0xFF201E22),
                              ),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        iconSize: 20,
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const HistoryPage(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),

              // USLOVI KORISTENJA
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    25,
                    25,
                    25,
                    5,
                  ),
                  child: Text(
                    "USLOVI KORISTENJA",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.36,
                      color: const Color(0xFF201E22),
                    ),
                  ),
                ),
              ),

              // FAQ
              Container(
                margin: const EdgeInsets.fromLTRB(25, 5, 25, 10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xCCEFF2F8),
                      width: 3,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.help_outline, size: 24),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              "FAQ",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                letterSpacing: 0.28,
                                color: const Color(0xFF201E22),
                              ),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        iconSize: 20,
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                        ),
                        onPressed: () {
                          _showDialog(context);
                        },
                      )
                    ],
                  ),
                ),
              ),

              // Uslovi koristenja
              Container(
                margin: const EdgeInsets.fromLTRB(25, 5, 25, 10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xCCEFF2F8),
                      width: 3,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.text_snippet_outlined, size: 24),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              "Uslovi koristenja",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                letterSpacing: 0.28,
                                color: const Color(0xFF201E22),
                              ),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        iconSize: 20,
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                        ),
                        onPressed: () {
                          _showDialog(context);
                        },
                      )
                    ],
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

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Nema nista."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Close"),
          ),
        ],
      );
    },
  );
}
