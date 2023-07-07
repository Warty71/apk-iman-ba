import 'package:apk_iman_ba/Pages/askpage.dart';
import 'package:apk_iman_ba/Pages/detailspage.dart';
import 'package:apk_iman_ba/Pages/favoritespage.dart';
import 'package:apk_iman_ba/Pages/searchpage.dart';
import 'package:apk_iman_ba/Pages/userpage.dart';
import 'package:apk_iman_ba/models/question_model.dart';
import 'package:apk_iman_ba/services/database_service.dart';
import 'package:apk_iman_ba/utility/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<String> topics = [
  "🔥Popularno",
  "📖Kur'an",
  "🧎Namaz",
  "🍽️Post",
  "Zekat",
  "Hadz i Umra",
  "Bracno Pravo",
  "Nasljedno Pravo",
  "Lijecenje Kur'anom",
  "Trgovina",
  "Islamsko Vjerovanje",
  "Hadis",
  "Ostalo",
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: unused_field
  final DatabaseService _database = DatabaseService();

  String currentTopic = "Kur'an";

  List<Question> questionList = [];

  @override
  void initState() {
    super.initState();
    currentTopic = "Kur'an";
    _fetchQuestions(currentTopic);
  }

  Future<void> _fetchQuestions(String topic) async {
    final List<Question> questions = await _database.homePageIndex(topic);
    setState(() {
      questionList = questions;
    });
  }

// I DID THIS TO SOLVE AN ISSUE. NEVER CALLBACK A SETSTATE AND AN ASYNC AT ONCE.
  void _updateCurrentTopic(String topic) {
    setState(() {
      currentTopic = Utils().removeEmojis(topic);
    });
    _fetchQuestions(currentTopic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const AskPage(),
            ),
          );
        },
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
                    onPressed: () {},
                    icon: const Icon(Icons.home_outlined),
                    color: Colors.white,
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
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: topics.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      decoration: BoxDecoration(
                          color: const Color(0xff190c3f),
                          borderRadius: BorderRadius.circular(14.0)),
                      child: Material(
                        child: Ink(
                          decoration: BoxDecoration(
                            color: const Color(0xff190c3f),
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              _updateCurrentTopic(topics[index]);
                            },
                            splashColor: Colors.white
                                .withOpacity(0.3), // Customize the splash color
                            borderRadius: BorderRadius.circular(14.0),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  topics[index],
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  for (Question question in questionList)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => DetailsPage(
                                  answer: question.answer,
                                  title: question.question,
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
