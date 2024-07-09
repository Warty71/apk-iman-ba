import 'package:apk_iman_ba/Services/database_service.dart';
import 'package:apk_iman_ba/src/shared/common_widgets/custom_fab.dart';
import 'package:apk_iman_ba/src/shared/common_widgets/custom_listview.dart';
import 'package:apk_iman_ba/src/features/questions/domain/models/question_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyQuestionsPage extends StatefulWidget {
  const MyQuestionsPage({super.key});

  @override
  State<MyQuestionsPage> createState() => _MyQuestionsPageState();
}

class _MyQuestionsPageState extends State<MyQuestionsPage> {
  List<Question> personalQuestions = [];
  String userID = FirebaseAuth.instance.currentUser!.uid;
  late String lengthQuestions = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPersonalQuestions();
    getUserQuestionsLength();
  }

  void fetchPersonalQuestions() async {
    setState(() {
      isLoading = true; // Show shimmer while loading
    });
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final String userId = user.uid;
        final List<Question> questions =
            await DatabaseService().fetchMyQuestions(userId);

        setState(() {
          personalQuestions = questions;
          isLoading = false;
        });
      }
    } catch (error) {
      if (kDebugMode) {
        print('Failed to fetch personal questions: $error');
      }
    }
  }

  void getUserQuestionsLength() async {
    lengthQuestions = await DatabaseService().fetchMyQuestionsLength(userID);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: const CustomFAB(shouldRebuild: true),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                          "assets/images/back.png",
                          height: 4,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Text(
                            "Moja Pitanja",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.32,
                              color: const Color(0xFF190C3F),
                            ),
                          ),
                        ),
                        Text(
                          "($lengthQuestions)",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.32,
                            color: const Color(0xFF190C3F),
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
              child: CustomListView(
                loadingFlag: isLoading,
                itemCount: personalQuestions.length,
                questionList: personalQuestions,
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
