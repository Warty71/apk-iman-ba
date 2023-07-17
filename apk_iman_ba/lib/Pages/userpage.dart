import 'package:apk_iman_ba/Pages/Extra/authpage.dart';
import 'package:apk_iman_ba/Pages/addentrypage.dart';
import 'package:apk_iman_ba/Pages/myquestionspage.dart';
import 'package:apk_iman_ba/State%20Management/user_state.dart';
import 'package:apk_iman_ba/components/custom_fab.dart';
import 'package:apk_iman_ba/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'waitinglistpage.dart';

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
  }

  void signUserOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Provider.of<UserState>(context, listen: false).updateUser(null);

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
                          "Moj Racun",
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
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1.5,
                            color: Color(0xFFEFF2F8),
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
                            color: const Color(0xFF201D22),
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
              Container(
                margin: const EdgeInsets.fromLTRB(25, 5, 25, 10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xCCEFF2F8),
                      width: 3,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person_outline, size: 24),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 2.0),
                            child: Text(
                              "Moja Pitanja",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                letterSpacing: 0.28,
                                color: const Color(0xFF201E22),
                              ),
                            ),
                          ),
                          Text(lengthQuestions),
                        ],
                      ),
                      IconButton(
                        iconSize: 20,
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const MyQuestionsPage(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),

              // Na cekanju
              Container(
                margin: const EdgeInsets.fromLTRB(25, 5, 25, 10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xCCEFF2F8),
                      width: 3,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.history, size: 24),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "Pitanja na Čekanju",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                letterSpacing: 0.28,
                                color: const Color(0xFF201E22),
                              ),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        iconSize: 20,
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const WaitingPage(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),

              // Unos u bazu - TEST
              Container(
                margin: const EdgeInsets.fromLTRB(25, 5, 25, 10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xCCEFF2F8),
                      width: 3,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.add, size: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "UNOS U BAZU",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            letterSpacing: 0.28,
                            color: const Color(0xFF201E22),
                          ),
                        ),
                      ),
                      IconButton(
                        iconSize: 20,
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const AddEntryPage(),
                            ),
                          );
                        },
                      )
                    ],
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
              Container(
                margin: const EdgeInsets.fromLTRB(25, 5, 25, 10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xCCEFF2F8),
                      width: 3,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.help_outline, size: 24),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
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
                      IconButton(
                        iconSize: 20,
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                        ),
                        onPressed: () {
                          _showDialog(context);
                        },
                      )
                    ],
                  ),
                ),
              ),

              // Uslovi koristenja
              Container(
                margin: const EdgeInsets.fromLTRB(25, 5, 25, 10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xCCEFF2F8),
                      width: 3,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.text_snippet_outlined, size: 24),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
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
                      IconButton(
                        iconSize: 20,
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                        ),
                        onPressed: () {
                          _showDialog(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15, 20, 15, 100),
                child: GestureDetector(
                  onTap: () => signUserOut(context),
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

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Nema nista."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Close"),
          ),
        ],
      );
    },
  );
}
