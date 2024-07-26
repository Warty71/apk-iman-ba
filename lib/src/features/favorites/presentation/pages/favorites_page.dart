import 'package:apk_iman_ba/Services/database_service.dart';
import 'package:apk_iman_ba/src/shared/common_widgets/custom_fab.dart';
import 'package:apk_iman_ba/src/shared/common_widgets/custom_listview.dart';
import 'package:apk_iman_ba/src/features/questions/domain/models/question_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Question> favorites = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFavoriteQuestions();
  }

  void fetchFavoriteQuestions() async {
    setState(() {
      isLoading = true; // Show shimmer while loading
    });
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final String userId = user.uid;
        final List<Question> questions =
            await DatabaseService().fetchFavorites(userId);

        setState(() {
          favorites = questions;
          isLoading = false;
        });
      }
    } catch (error) {
      //failed to fetch favorite questions
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: const CustomFAB(
        shouldRebuild: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
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
                      "Sačuvana pitanja",
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
              child: CustomListView(
                itemCount: favorites.length,
                loadingFlag: isLoading,
                questionList: favorites,
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
