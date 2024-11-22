import 'package:apk_iman_ba/services/database_service.dart';
import 'package:apk_iman_ba/src/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:apk_iman_ba/src/features/questions/cubit/questions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsPage extends StatefulWidget {
  final String id;
  final String title;
  final String answer;
  final String answeredBy;
  final int views;

  const DetailsPage({
    super.key,
    required this.id,
    required this.title,
    required this.answer,
    required this.answeredBy,
    required this.views,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    context
        .read<QuestionsCubit>()
        .increaseViewCount(widget.title, widget.views);
    checkFavoriteStatus();
  }

  void checkFavoriteStatus() {
    final favorites = context.read<FavoritesCubit>().state.favorites;
    setState(() {
      isFavorite = favorites.any((question) => question.id == widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      SizedBox(
                        width: 205,
                        child: Center(
                          child: Text(
                            widget.answeredBy,
                            softWrap: true,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          DatabaseService().updateFavoriteQuestion(widget.id);

                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        style: TextButton.styleFrom(),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: const Color(0xffeff2f8),
                          ),
                          height: 48,
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.black : Colors.black,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Text(
                    "Pitanje: ",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.14,
                      color: const Color(0xFF626164),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    widget.title,
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF201E22)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                  child: Text(
                    "Odgovor: ",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.14,
                      color: const Color(0xFF626164),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Text(
                    widget.answer,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.28,
                      color: const Color(0xFF626164),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
