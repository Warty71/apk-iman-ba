import 'package:apk_iman_ba/Pages/homepage.dart';
import 'package:apk_iman_ba/Pages/searchpage.dart';
import 'package:apk_iman_ba/Pages/userpage.dart';
import 'package:apk_iman_ba/Services/database_service.dart';
import 'package:apk_iman_ba/models/question_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'detailspage.dart';

List<Map<String, String>> qaList = [
  {
    'question': "Sta je Kur'an?",
    'answer':
        "Kur'an je posljednja objava našeg Gospodara. Objavljen je na čistom arapskom jeziku poslaniku Muhammedu s.a.w.s.",
  },
  {
    'question': "Koja je vrijednost okupljanja radi učenja Kur’ana?",
    'answer':
        "Ebu Hurejre prenosi da je Poslanik, sallallahu alejhi ve sellem, kazao: „ Kada god se okupi grupa ljudi u nekoj Allahovoj kući radi učenja i proučavanja Kur’ana, na njih se spusti smirenost, obaspe ih milost, okruže ih meleki i Allah ih spomene kod onih koji su kod Njega. Ko zaostaje zbog svojih dijela, njegovo porijeklo mu neće pomoći da napreduje.“ (Bilježi Muslim). Ebu Hurejre prenosi da je Poslanik, sallallahu alejhi ve sellem, kazao: „ Kada god se okupi grupa ljudi u nekoj Allahovoj kući radi učenja i proučavanja Kur’ana, na njih se spusti smirenost, obaspe ih milost, okruže ih meleki i Allah ih spomene kod onih koji su kod Njega. Ko zaostaje zbog svojih dijela, njegovo porijeklo mu neće pomoći da napreduje.“ (Bilježi Muslim). Ebu Hurejre prenosi da je Poslanik, sallallahu alejhi ve sellem, kazao: „ Kada god se okupi grupa ljudi u nekoj Allahovoj kući radi učenja i proučavanja Kur’ana, na njih se spusti smirenost, obaspe ih milost, okruže ih meleki i Allah ih spomene kod onih koji su kod Njega. Ko zaostaje zbog svojih dijela, njegovo porijeklo mu neće pomoći da napreduje.“ (Bilježi Muslim).",
  },
  {
    'question': "Šta je Kur’an?",
    'answer':
        "Kur'an je posljednja objava našeg Gospodara. Objavljen je na čistom arapskom jeziku poslaniku Muhammedu s.a.w.s.",
  },
  {
    'question': 'Question 4',
    'answer': 'Answer 4',
  },
  {
    'question': 'Question 5',
    'answer': 'Answer 5',
  },
];

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Question> favorites = [];

  @override
  void initState() {
    super.initState();
    fetchFavoriteQuestions();
  }

  void fetchFavoriteQuestions() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final String userId = user.uid;
        final List<Question> questions =
            await DatabaseService().fetchFavorites(userId);

        setState(() {
          favorites = questions;
        });
      }
    } catch (error) {
      print('Failed to fetch favorite questions: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_outline),
                    color: Colors.white,
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const UserPage(),
                        ),
                      );
                    },
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
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Sacuvana pitanja",
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
            Expanded(
              child: ListView(
                children: [
                  for (Question question in favorites)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => DetailsPage(
                                  id: question.id,
                                  answer: question.answer,
                                  title: question.question,
                                  views: question.views,
                                ),
                              ),
                            );
                          },
                          splashColor: Colors.blue
                              .withOpacity(0.5), // Customize the splash color
                          borderRadius: BorderRadius.circular(8.0),
                          child: Card(
                            child: ListTile(
                              title: Container(
                                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Text(
                                  question.question,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    letterSpacing: 0.32,
                                    color: const Color(0xff201d22),
                                  ),
                                ),
                              ),
                              subtitle: Text(
                                question.answer,
                                maxLines: 5,
                                overflow: TextOverflow.fade,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  letterSpacing: 0.28,
                                  color: const Color(0xff626164),
                                ),
                              ),
                              tileColor: const Color(0xffeff2f8),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
