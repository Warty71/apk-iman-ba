import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
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
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Text(
                            "Uslovi Korištenja",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.32,
                              color: const Color(0xFF190C3F),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.white,
                      ),
                      height: 48,
                      width: 48,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                    children: const <TextSpan>[
                      TextSpan(
                        text: 'Dobrodošli u našu aplikaciju. Korištenjem ove '
                            'aplikacije prihvatate sljedeće uslove korištenja:\n\n',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '1. Odgovornost Korisnika\n\n',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'Korisnik se obavezuje da će odgovorno koristiti '
                            'aplikaciju i neće je zloupotrebljavati u nezakonite '
                            'svrhe. Korisnik prihvata odgovornost za sve aktivnosti '
                            'vezane uz njegov korisnički račun.\n\n',
                      ),
                      TextSpan(
                        text: '2. Autorska Prava\n\n',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'Sva autorska prava u vezi sa sadržajem ove '
                            'aplikacije pripadaju nama ili našim licenciranim '
                            'dobavljačima. Nije dozvoljeno kopiranje, distribuiranje '
                            'ili mijenjanje sadržaja bez naše izričite dozvole. Sama pitanja i odgovori su javni i dozvoljeno ih je dijeliti.\n\n',
                      ),
                      TextSpan(
                        text: '3. Privatnost Korisnika\n\n',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            'Važno nam je zaštiti Vaše podatke i poštovati Vašu '
                            'privatnost. Svi Vaši podaci su sakriveni i zaštićeni.\n\n',
                      ),
                      TextSpan(
                        text: '4. Ograničenje Odgovornosti\n\n',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'Korištenjem ove aplikacije prihvatate da je ona '
                            'dostupna "kako jeste" i da se koristi na Vaš rizik. Mi ne '
                            'snosimo odgovornost za bilo kakvu štetu ili gubitke '
                            'proizašle iz korištenja ove aplikacije.\n\n',
                      ),
                      TextSpan(
                        text: '5. Izmjene Uslova Korištenja\n\n',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            'Zadržavamo pravo izmjene ovih Uslova Korištenja u '
                            'bilo koje vrijeme. Svaka izmjena će biti objavljena u '
                            'aplikaciji, a Vaše korištenje nakon objave znači da '
                            'prihvatate izmijenjene uslove.\n\n',
                      ),
                      TextSpan(
                        text:
                            'Ako imate bilo kakvih pitanja o Uslovima Korištenja, '
                            'molimo Vas da nas kontaktirate.',
                      ),
                    ],
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
