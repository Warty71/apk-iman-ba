import 'package:apk_iman_ba/Pages/detailspage.dart';
import 'package:apk_iman_ba/components/custom_fab.dart';
import 'package:apk_iman_ba/components/custom_shimmer.dart';
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
  "💰Zekat",
  "🕋Hadz i Umra",
  "💍Bracno Pravo",
  "🏚Nasljedno Pravo",
  "📖Lijecenje Kur'anom",
  "💶Trgovina",
  "🤲Islamsko Vjerovanje",
  "📜Hadis",
  "Ostalo",
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _database = DatabaseService();

  String currentTopic = "Kur'an";
  List<Question> questionList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    currentTopic = "Kur'an";
    _fetchQuestionsByTopic(currentTopic);
  }

  Future<void> _fetchQuestionsByTopic(String topic) async {
    setState(() {
      isLoading = true; // Show shimmer while loading
    });

    final List<Question> questions = await _database.filterByTopic(topic);

    setState(() {
      questionList = questions;
      isLoading = false; // Hide shimmer when data is loaded
    });
  }

  Future<void> _fetchQuestionsByViews() async {
    setState(() {
      isLoading = true; // Show shimmer while loading
    });

    final List<Question> questions = await _database.filterByViews();

    setState(() {
      questionList = questions;
      isLoading = false; // Hide shimmer when data is loaded
    });
  }

  void _updateCurrentTopic(String topic) {
    setState(() {
      currentTopic = Utils().removeEmojis(topic);
    });
    if (currentTopic != "Popularno") {
      _fetchQuestionsByTopic(currentTopic);
    } else {
      _fetchQuestionsByViews();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const CustomFAB(
        shouldRebuild: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                        borderRadius: BorderRadius.circular(14.0),
                      ),
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
                            splashColor: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(14.0),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  topics[index],
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
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
              child: ListView.builder(
                itemCount: isLoading ? 5 : questionList.length,
                itemBuilder: (context, index) {
                  if (isLoading) {
                    // Display shimmer while loading
                    return const CustomShimmer();
                  } else {
                    // Display actual list item
                    final question = questionList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 8),
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
                        splashColor: Colors.blue.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            title: Container(
                              color: Colors.transparent,
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
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
