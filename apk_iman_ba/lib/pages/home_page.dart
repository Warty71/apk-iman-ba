import 'package:apk_iman_ba/components/custom_fab.dart';
import 'package:apk_iman_ba/components/custom_listview.dart';
import 'package:apk_iman_ba/models/question_model.dart';
import 'package:apk_iman_ba/services/database_service.dart';
import 'package:apk_iman_ba/utility/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<String> topics = [
  "🆕Novo",
  "🔥Popularno",
  "📖Kur'an",
  "🧎Namaz",
  "🍽️Post",
  "💰Zekat",
  "🕋Hadž i Umra",
  "💍Bračno Pravo",
  "🏚Nasljedno Pravo",
  "📖Liječenje Kur'anom",
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

  String currentTopic = "Novo";
  List<Question> questionList = [];
  int selectedTopicIndex = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchQuestionsByDate();
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

  Future<void> _fetchQuestionsByDate() async {
    setState(() {
      isLoading = true; // Show shimmer while loading
    });

    final List<Question> questions = await _database.filterByDate();

    setState(() {
      questionList = questions;
      isLoading = false; // Hide shimmer when data is loaded
    });
  }

  void _updateCurrentTopic(String topic) {
    setState(() {
      currentTopic = Utils().removeEmojis(topic);
    });
    if (currentTopic == "Popularno") {
      _fetchQuestionsByViews();
    } else if (currentTopic == "Novo") {
      _fetchQuestionsByDate();
    } else {
      _fetchQuestionsByTopic(currentTopic);
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
                        color: index == selectedTopicIndex
                            ? const Color(0xff5449d2)
                            : const Color(0xff190c3f),
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: Material(
                        child: Ink(
                          decoration: BoxDecoration(
                            color: index == selectedTopicIndex
                                ? const Color(0xff5449d2)
                                : const Color(0xff190c3f),
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedTopicIndex = index;
                              });
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
                                    color: index == selectedTopicIndex
                                        ? Colors.white
                                        : Colors.white,
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
              child: CustomListView(
                loadingFlag: isLoading,
                itemCount: questionList.length,
                questionList: questionList,
                useSubtitle: true,
                detailViewSelector: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
