import 'package:apk_iman_ba/src/features/home/presentation/widgets/topic_item.dart';
import 'package:apk_iman_ba/src/features/questions/cubit/questions_cubit.dart';
import 'package:apk_iman_ba/src/features/questions/cubit/questions_state.dart';
import 'package:apk_iman_ba/src/shared/common_widgets/custom_fab.dart';
import 'package:apk_iman_ba/src/shared/common_widgets/custom_listview.dart';
import 'package:apk_iman_ba/src/shared/enums/topics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsCubit, QuestionsState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: const CustomFAB(shouldRebuild: true),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: Topic.values.length,
                      itemBuilder: (context, index) {
                        return TopicItem(
                          topic: Topic.values[index].label,
                          isSelected: index == state.selectedTopicIndex,
                          onTap: () {
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      context.read<QuestionsCubit>().updateCurrentTopic(
                            Topic.values[index],
                            index,
                          );
                    },
                    itemCount: Topic.values.length,
                    itemBuilder: (context, index) {
                      final currentTopic = Topic.values[index];
                      final questions =
                          state.questionsByTopic[currentTopic] ?? [];

                      return CustomListView(
                        loadingFlag: state.isLoading,
                        itemCount: questions.length,
                        questionList: questions,
                        useSubtitle: true,
                        detailViewSelector: 1,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
