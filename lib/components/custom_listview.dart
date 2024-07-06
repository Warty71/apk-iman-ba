import "package:apk_iman_ba/components/custom_shimmer.dart";
import "package:apk_iman_ba/src/features/questions/domain/models/question_model.dart";
import "package:apk_iman_ba/src/features/questions/presentation/pages/details_page.dart";
import 'package:apk_iman_ba/src/features/questions/presentation/pages/wait_answer_page.dart';
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class CustomListView extends StatefulWidget {
  final bool loadingFlag;
  final bool useSubtitle;
  final int itemCount;
  final int detailViewSelector;
  final List<Question> questionList;

  const CustomListView({
    super.key,
    required this.loadingFlag,
    required this.useSubtitle,
    required this.itemCount,
    required this.detailViewSelector,
    required this.questionList,
  });

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.loadingFlag ? 10 : widget.itemCount,
      itemBuilder: (context, index) {
        if (widget.loadingFlag) {
          // Display shimmer while loading
          return const CustomShimmer();
        } else {
          // Display actual list item
          final question = widget.questionList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 8,
            ),
            child: InkWell(
              onTap: () {
                if (widget.detailViewSelector == 1) {
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
                } else if (widget.detailViewSelector == 2) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => WaitAnswerpage(
                        questionTitle: question.question,
                      ),
                    ),
                  );
                }
              },
              splashColor: Colors.blue.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10.0),
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
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Text(
                      question.question,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        letterSpacing: 0.32,
                        color: const Color(0xff201d22),
                      ),
                    ),
                  ),
                  subtitle: widget.useSubtitle
                      ? Text(
                          question.answer,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            letterSpacing: 0.28,
                            color: const Color(0xff626164),
                          ),
                        )
                      : null,
                  tileColor: const Color(0xffeff2f8),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
