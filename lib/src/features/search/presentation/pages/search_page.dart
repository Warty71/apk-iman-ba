import 'package:apk_iman_ba/components/custom_shimmer.dart';
import 'package:apk_iman_ba/src/features/questions/domain/models/question_model.dart';
import 'package:apk_iman_ba/services/database_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../questions/presentation/pages/details_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  ValueNotifier<bool> isTextFieldEmptyNotifier = ValueNotifier<bool>(true);
  bool isTextFieldEmpty = true;
  bool isLoading = true;

  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("Baza");
  final DatabaseService _database = DatabaseService();

  List<Question> questionList = [];

  @override
  void dispose() {
    searchController.dispose();
    isTextFieldEmptyNotifier.dispose();
    super.dispose();
  }

  void clearTextFormField() {
    setState(() {
      searchController.clear();
      isTextFieldEmptyNotifier.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: SizedBox(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: searchController,
                          onChanged: (value) async {
                            setState(() {
                              isLoading = true;
                            });
                            isTextFieldEmptyNotifier.value = value.isEmpty;
                            final result =
                                await _database.filterBySearch(value);
                            setState(() {
                              questionList = result;
                              isLoading = false;
                            });
                          },
                          onFieldSubmitted: (value) {
                            if (value.isNotEmpty) {
                              isTextFieldEmptyNotifier.value = false;
                            }
                          },
                          decoration: InputDecoration(
                            fillColor: const Color(0xffeff2f8),
                            filled: true,
                            hintText: "Traži pitanje...",
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 15.0,
                            ),
                            prefixIcon: const Icon(
                              Icons.search_outlined,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                width: 1.5,
                                color: Color(0xffa6a6ad),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                width: 1.5,
                                color: Color.fromARGB(255, 135, 196, 222),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: TextButton(
                          onPressed: () {
                            clearTextFormField();
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
                              "assets/images/close.png",
                              height: 4,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: isTextFieldEmptyNotifier,
                builder: (context, isTextFieldEmpty, _) {
                  if (!isTextFieldEmpty && !isLoading) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: questionList.length,
                        itemBuilder: (context, index) {
                          final question = questionList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 8,
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => DetailsPage(
                                      id: question.id,
                                      answer: question.answer,
                                      answeredBy: question.answeredBy,
                                      title: question.question,
                                      views: question.views,
                                    ),
                                  ),
                                );
                              },
                              splashColor: Colors.blue.withOpacity(0.5),
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
                                    color: Colors.transparent,
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    child: Text(
                                      question.question,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: 0.32,
                                        color: const Color(0xff201d22),
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
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
                        },
                      ),
                    );
                  } else if (isLoading && !isTextFieldEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return const CustomShimmer();
                        },
                      ),
                    );
                  } else {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          margin: const EdgeInsets.all(25.0),
                          child: Column(
                            children: [
                              Text(
                                "Tražite neko od već postavljenih pitanja?",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFA7A7AD),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Image.asset(
                                "assets/images/compass.png",
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
