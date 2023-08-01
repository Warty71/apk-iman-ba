import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                            "FAQ",
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
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Opšta Pitanja\n',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xff5449d2)),
                      ),
                      TextSpan(
                        text:
                            '1. Koja je svrha ove aplikacije?\nNaša aplikacija ima za cilj pružanje platforme korisnicima za pristup i dijeljenje islamskog znanja, postavljanje pitanja i dobijanje odgovora od kvalifikovanih učenjaka.\n\n',
                      ),
                      TextSpan(
                        text:
                            '2. Da li je ova aplikacija dostupna na Android i iOS uređajima?\nTrenutno, aplikacija je dostupna na Android operativnom sistemu. U narednih par dana inšAllah, bit će dostupna i na iOS operativnom sistemu, na odgovarajućim prodavnicama.\n\n',
                      ),
                      TextSpan(
                        text:
                            '3. Mogu li postaviti pitanje anonimno?\nNijedan korisnik nema informaciju ko je postavio bilo koje pitanje. Vaš identitet je anoniman svim korisnicima, osim učenjaku koji vidi ko je postavio pitanje.\n\n',
                      ),
                      TextSpan(
                        text: 'Postavljanje Pitanja\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xff5449d2),
                        ),
                      ),
                      TextSpan(
                        text:
                            '4. Kako postaviti pitanje?\nDa biste postavili pitanje, idite na dugme "Postavi Pitanje", unesite vaše pitanje u predviđeni tekstualni prostor.\n\n',
                      ),
                      TextSpan(
                        text:
                            '5. Postoje li smjernice za postavljanje pitanja?\nDa, ohrabrujemo korisnike da se pridržavaju naših smjernica zajednice pri postavljanju pitanja. Obezbjedite da vaša pitanja budu poštovanja vrijedna, relevantna i u skladu sa našim uslovima korištenja.\n\n',
                      ),
                      TextSpan(
                        text: 'Odgovaranje na Pitanja\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xff5449d2),
                        ),
                      ),
                      TextSpan(
                        text:
                            '6. Kako funkcionišu odgovori na pitanja?\nVaše pitanje je vidljivo učenjacima. Kroz određeni vremenski period će doći odgovor na Vaše pitanje, shodno zauzetosti osoba zaduženih za odgovore, te količini pitanja od svih korisnika. Čim dođe odgovor na Vaše pitanje, dobit ćete notifikaciju, i sva Vaša pitanja možete vidjeti u sekciji "Moja Pitanja". Molimo Vas za razumijevanje i strpljenje. Hvala!\n\n',
                      ),
                      TextSpan(
                        text: 'Moderacija\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xff5449d2),
                        ),
                      ),
                      TextSpan(
                        text:
                            '7. Kako se vrši moderacija pitanja i odgovora?\nNaša aplikacija ima tim moderatora koji pregledaju sve sadržaje kako bi obezbjedili usklađenost sa smjernicama zajednice. Neprikladan ili neadekvatan sadržaj će biti uklonjen.\n\n',
                      ),
                      TextSpan(
                        text: 'Privatnost i Bezbjednost\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xff5449d2),
                        ),
                      ),
                      TextSpan(
                        text:
                            '8. Da li su moji lični podaci sigurni na ovoj aplikaciji?\nApsolutno. Mi ozbiljno shvatamo privatnost i bezbjednost. Vaši lični podaci su enkriptovani i bezbjedno sačuvani.\n\n',
                      ),
                      TextSpan(
                        text:
                            '9. Da li drugi korisnici mogu vidjeti moju email adresu?\nNe, vaša email adresa je privatna i nije vidljiva drugim korisnicima.\n\n',
                      ),
                      TextSpan(
                        text: 'Kontakt i Podrška\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xff5449d2),
                        ),
                      ),
                      TextSpan(
                        text:
                            '10. Kako mogu kontaktirati korisničku podršku?\nUkoliko imate bilo kakva pitanja ili naiđete na probleme pri korištenju naše aplikacije, možete kontaktirati našu korisničku podršku direktnim pitanjem, kao što biste postavili pitanje vezano za islam. Također možete koristiti i komunikaciju putem Google Play Store ili AppStore. Trudimo se da odgovorimo brzo na Vaše upite.\n\n',
                      ),
                      TextSpan(
                        text:
                            'Ako imate još nekih pitanja ili trebate dodatnu pomoć, slobodno nas kontaktirajte. Tu smo da Vam pomognemo!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
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
    );
  }
}
