import 'package:apk_iman_ba/Services/database_service.dart';
import 'package:apk_iman_ba/components/custom_fab.dart';
import 'package:apk_iman_ba/models/question_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'detailspage.dart';

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
      floatingActionButton: const CustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
