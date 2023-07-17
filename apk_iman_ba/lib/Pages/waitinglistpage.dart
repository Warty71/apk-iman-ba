import 'package:apk_iman_ba/Services/database_service.dart';
import 'package:apk_iman_ba/models/question_model.dart';
import 'package:apk_iman_ba/pages/waitanswerpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WaitingPage extends StatefulWidget {
  const WaitingPage({super.key});

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  List<Question> onHoldQuestions = [];

  @override
  void initState() {
    super.initState();
    fetchOnHoldQuestions();
  }

  void fetchOnHoldQuestions() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final String userId = user.uid;
        final List<Question> questions =
            await DatabaseService().fetchOnHoldQuestions(userId);

        setState(() {
          onHoldQuestions = questions;
        });
      }
    } catch (error) {
      if (kDebugMode) {
        print('Failed to fetch personal questions: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Text(
                        "Pitanja na Čekanju",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.32,
                          color: const Color(0xFF190C3F),
                        ),
                      ),
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
              child: ListView(
                children: [
                  for (Question question in onHoldQuestions)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 8),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => WaitAnswerpage(
                                questionTitle: question.question,
                              ),
                            ),
                          );
                        },
                        splashColor: Colors.blue
                            .withOpacity(0.5), // Customize the splash color
                        borderRadius: BorderRadius.circular(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
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
                              tileColor: const Color(0xFFEFF2F8)),
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
