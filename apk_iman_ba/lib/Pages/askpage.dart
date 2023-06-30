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
  bool _isEmpty = true;

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
                            "lib/Images/back.png",
                            height: 4,
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
              const Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
                child: TextFormField(
                  controller: questionController,
                  maxLength: null,
                  maxLines: null,
                  autofocus: true,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    suffixIcon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
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
                          : Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    filled: true,
                    fillColor: const Color(0xFF554AD2),
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
            ],
          ),
        ),
      ),
    );
  }
}
