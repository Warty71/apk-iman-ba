import 'package:apk_iman_ba/pages/detailspage.dart';
import 'package:apk_iman_ba/pages/homepage.dart';
import 'package:apk_iman_ba/pages/userpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'favoritespage.dart';

List<Map<String, String>> qaList = [
  {
    'question': "Sta je Kur'an?",
    'answer':
        "Kur'an je posljednja objava našeg Gospodara. Objavljen je na čistom arapskom jeziku poslaniku Muhammedu s.a.w.s.",
  },
  {
    'question': "Koja je vrijednost okupljanja radi učenja Kur’ana?",
    'answer':
        "Ebu Hurejre prenosi da je Poslanik, sallallahu alejhi ve sellem, kazao: „ Kada god se okupi grupa ljudi u nekoj Allahovoj kući radi učenja i proučavanja Kur’ana, na njih se spusti smirenost, obaspe ih milost, okruže ih meleki i Allah ih spomene kod onih koji su kod Njega. Ko zaostaje zbog svojih dijela, njegovo porijeklo mu neće pomoći da napreduje.“ (Bilježi Muslim)",
  },
  {
    'question': "Šta je Kur’an?",
    'answer':
        "Kur'an je posljednja objava našeg Gospodara. Objavljen je na čistom arapskom jeziku poslaniku Muhammedu s.a.w.s.",
  },
  {
    'question': 'Question 4',
    'answer': 'Answer 4',
  },
  {
    'question': 'Question 5',
    'answer': 'Answer 5',
  },
];

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  ValueNotifier<bool> isTextFieldEmptyNotifier = ValueNotifier<bool>(true);
  bool isTextFieldEmpty = true;

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
                          onChanged: (value) {
                            isTextFieldEmptyNotifier.value = value.isEmpty;
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
                          for (Map<String, String> qa in qaList)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => DetailsPage(
                                          answer: qa['answer'] ?? '',
                                          title: qa['question'] ?? '',
                                        ),
                                      ),
                                    );
                                  },
                                  splashColor: Colors.blue.withOpacity(
                                      0.5), // Customize the splash color
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Card(
                                    child: ListTile(
                                      title: qa['question'] != null
                                          ? Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 5, 0, 5),
                                              child: Text(
                                                qa['question']!,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  letterSpacing: 0.32,
                                                  color:
                                                      const Color(0xff201d22),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      subtitle: qa['answer'] != null
                                          ? Text(
                                              qa['answer']!,
                                              maxLines: 5,
                                              overflow: TextOverflow.fade,
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                letterSpacing: 0.28,
                                                color: const Color(0xff626164),
                                              ),
                                            )
                                          : Container(),
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
