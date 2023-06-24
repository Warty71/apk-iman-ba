import 'package:apk_iman_ba/Pages/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homepage.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_outline),
                    color: Colors.white54,
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.person_2_outlined),
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
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
                          "lib/Images/back.png",
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
                          color: const Color(0xffeff2f8),
                        ),
                        height: 48,
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Text(
                  "Pitanje: ",
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
                  "Koja je vrijednost okupljanja radi ucenja Kur'ana?",
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
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
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
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: SingleChildScrollView(
                    child: Text(
                      "Ebu Hurejre prenosi da je Poslanik, sallallahu alejhi ve sellem, kazao: „ Kada god se okupi grupa ljudi u nekoj Allahovoj kući radi učenja i proučavanja Kur’ana, na njih se spusti smirenost, obaspe ih milost, okruže ih meleki i Allah ih spomene kod onih koji su kod Njega. Ko zaostaje zbog svojih dijela, njegovo porijeklo mu neće pomoći da napreduje.“ (Bilježi Muslim) Ebu Hurejre prenosi da je Poslanik, sallallahu alejhi ve sellem, kazao: „ Kada god se okupi grupa ljudi u nekoj Allahovoj kući radi učenja i proučavanja Kur’ana, na njih se spusti smirenost, obaspe ih milost, okruže ih meleki i Allah ih spomene kod onih koji su kod Njega. Ko zaostaje zbog svojih dijela, njegovo porijeklo mu neće pomoći da napreduje.“ (Bilježi Muslim). Ebu Hurejre prenosi da je Poslanik, sallallahu alejhi ve sellem, kazao: „ Kada god se okupi grupa ljudi u nekoj Allahovoj kući radi učenja i proučavanja Kur’ana, na njih se spusti smirenost, obaspe ih milost, okruže ih meleki i Allah ih spomene kod onih koji su kod Njega. Ko zaostaje zbog svojih dijela, njegovo porijeklo mu neće pomoći da napreduje.“ (Bilježi Muslim) Ebu Hurejre prenosi da je Poslanik, sallallahu alejhi ve sellem, kazao: „ Kada god se okupi grupa ljudi u nekoj Allahovoj kući radi učenja i proučavanja Kur’ana, na njih se spusti smirenost, obaspe ih milost, okruže ih meleki i Allah ih spomene kod onih koji su kod Njega. Ko zaostaje zbog svojih dijela, njegovo porijeklo mu neće pomoći da napreduje.“ (Bilježi Muslim)",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.28,
                        color: const Color(0xFF626164),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
