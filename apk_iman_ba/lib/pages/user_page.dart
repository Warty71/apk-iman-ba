import 'package:apk_iman_ba/Pages/Extra/auth_page.dart';
import 'package:apk_iman_ba/Pages/my_questions_page.dart';
import 'package:apk_iman_ba/state_management/user_state.dart';
import 'package:apk_iman_ba/components/custom_fab.dart';
import 'package:apk_iman_ba/pages/faq_page.dart';
import 'package:apk_iman_ba/pages/terms_of_use_page.dart';
import 'package:apk_iman_ba/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'waiting_list_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String userID = FirebaseAuth.instance.currentUser!.uid;
  late String lengthQuestions = '';

  @override
  void initState() {
    super.initState();
    getUserQuestionsLength();
  }

  void getUserQuestionsLength() async {
    lengthQuestions = await DatabaseService().fetchMyQuestionsLength(userID);
    setState(() {});
  }

  void signUserOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Provider.of<UserState>(context, listen: false).updateUser(null);

    // Remove the user ID from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user_id');

    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const AuthPage()),
      (route) => false,
    );
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "Moj profil",
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
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(25, 10, 25, 5),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "E-mail",
                      style: GoogleFonts.poppins(
                        color: const Color(0xff201d22),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      decoration: ShapeDecoration(
                        // color: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1.5,
                            color: Colors.grey.shade200,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: Text(
                          FirebaseAuth.instance.currentUser!.email.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.14,
                            color:
                                Colors.grey.shade500, //const Color(0xFF201D22),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // PITANJA
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    25,
                    25,
                    25,
                    5,
                  ),
                  child: Text(
                    "PITANJA",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.36,
                      color: const Color(0xFF201E22),
                    ),
                  ),
                ),
              ),

              // Moja Pitanja
              Ink(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const MyQuestionsPage(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xCCEFF2F8),
                            width: 3,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.person_outline, size: 24),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 2.0),
                                  child: Text(
                                    "Moja pitanja",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      letterSpacing: 0.28,
                                      color: const Color(0xFF201E22),
                                    ),
                                  ),
                                ),
                                Text("($lengthQuestions)"),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Na cekanju
              Ink(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const WaitingPage(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xCCEFF2F8),
                            width: 3,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.history, size: 24),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    "Pitanja na čekanju",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      letterSpacing: 0.28,
                                      color: const Color(0xFF201E22),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // USLOVI KORIŠTENJA
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    25,
                    25,
                    25,
                    5,
                  ),
                  child: Text(
                    "USLOVI KORIŠTENJA",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.36,
                      color: const Color(0xFF201E22),
                    ),
                  ),
                ),
              ),

              // FAQ
              Ink(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const FAQPage(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xCCEFF2F8),
                            width: 3,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.help_outline, size: 24),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    "FAQ",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      letterSpacing: 0.28,
                                      color: const Color(0xFF201E22),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Uslovi koristenja
              Ink(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const TermsOfUsePage(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xCCEFF2F8),
                            width: 3,
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xCCEFF2F8),
                              width: 3,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.text_snippet_outlined,
                                      size: 24),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                      "Uslovi korištenja",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        letterSpacing: 0.28,
                                        color: const Color(0xFF201E22),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15, 20, 15, 100),
                child: GestureDetector(
                  onTap: () {
                    signUserOut(context);
                  },
                  child: Text(
                    "Odjava",
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
