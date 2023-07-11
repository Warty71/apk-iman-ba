import 'package:apk_iman_ba/models/question_model.dart';
import 'package:apk_iman_ba/services/database_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'detailspage.dart';
import 'homepage.dart';
import 'userpage.dart';
import 'favoritespage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  ValueNotifier<bool> isTextFieldEmptyNotifier = ValueNotifier<bool>(true);
  bool isTextFieldEmpty = true;

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
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const RadialGradient(
                  center: Alignment(-1.538, -3.615),
                  radius: 4,
                  colors: <Color>[Color(0xff5959e4), Color(0xff140632)],
                  stops: <double>[0, 0.99],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const HomePage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.home_outlined),
                      color: Colors.white54,
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search_outlined),
                      color: Colors.white,
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const FavoritesPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.favorite_outline),
                      color: Colors.white54,
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const UserPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.person_2_outlined),
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
                            isTextFieldEmptyNotifier.value = value.isEmpty;
                            final result =
                                await _database.filterBySearch(value);
                            setState(() {
                              questionList = result;
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
                            hintText: "Trazi pitanje...",
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
                  return Visibility(
                    visible: isTextFieldEmpty,
                    child: Container(
                      margin: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          Text(
                            "Trazite neko od vec postavljenih pitanja?",
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
                  );
                },
              ),
              ValueListenableBuilder<bool>(
                valueListenable: isTextFieldEmptyNotifier,
                builder: (context, isTextFieldEmpty, _) {
                  if (!isTextFieldEmpty) {
                    return Expanded(
                      child: ListView(
                        children: [
                          for (Question question in questionList)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => DetailsPage(
                                          answer: question.answer,
                                          title: question.question,
                                          views: question.views,
                                        ),
                                      ),
                                    );
                                  },
                                  splashColor: Colors.blue.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Card(
                                    child: ListTile(
                                      title: Text(
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        question.question,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          letterSpacing: 0.32,
                                          color: const Color(0xff201d22),
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
                    );
                  } else {
                    return const SizedBox.shrink();
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
