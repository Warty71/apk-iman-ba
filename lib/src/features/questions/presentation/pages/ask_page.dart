import 'package:apk_iman_ba/src/features/authentication/presentation/pages/auth_page.dart';
import 'package:apk_iman_ba/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AskPage extends StatefulWidget {
  const AskPage({
    super.key,
  });

  @override
  State<AskPage> createState() => _AskPageState();
}

class _AskPageState extends State<AskPage> {
  final TextEditingController questionController = TextEditingController();
  final DatabaseService _database = DatabaseService();
  bool _isEmpty = true;
  bool _isQuestionPosted = false;

  @override
  void initState() {
    super.initState();
    questionController.addListener(_checkTextEmpty);
  }

  @override
  void dispose() {
    questionController.dispose();
    super.dispose();
  }

  void _checkTextEmpty() {
    setState(() {
      _isEmpty = questionController.text.isEmpty;
    });
  }

  void _handleSubmitQuestion(String question) async {
    if (_isQuestionPosted == false) {
      await _database.askQuestions(context, question);
      setState(() {
        _isQuestionPosted = true;
      });
      questionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              enabled: _isQuestionPosted ? false : true,
              controller: questionController,
              maxLength: null,
              maxLines: null,
              autofocus: true,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                suffixIcon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: animation,
                        alignment: Alignment.centerRight,
                        child: child,
                      ),
                    );
                  },
                  child: _isEmpty
                      ? Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          key: UniqueKey(),
                        )
                      : GestureDetector(
                          onTap: () {
                            _handleSubmitQuestion(questionController.text);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(
                                'Postavi',
                                key: UniqueKey(),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF554AD2),
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                filled: true,
                fillColor:
                    _isQuestionPosted ? Colors.grey : const Color(0xFF554AD2),
                labelText: "Pitanje",
                labelStyle: GoogleFonts.poppins(
                  color: Colors.white38,
                ),
              ),
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.14,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(
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
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const AuthPage()),
                                (route) => false,
                              );
                            },
                            style: TextButton.styleFrom(),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: const Color(0xffeff2f8),
                              ),
                              height: 48,
                              width: 48,
                              child: const Icon(
                                Icons.home_outlined,
                                size: 28,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Text(
                                  "Imate pitanje?",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.32,
                                    color: const Color(0xFF190C3F),
                                  ),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5),
                    child: Column(
                      children: [
                        if (_isQuestionPosted)
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: Colors.green,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Pitanje uspješno postavljeno!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
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
          ),
        ),
      ),
    );
  }
}
