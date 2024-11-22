import 'package:apk_iman_ba/src/features/home/presentation/widgets/topic_item.dart';
import 'package:apk_iman_ba/src/features/questions/cubit/questions_cubit.dart';
import 'package:apk_iman_ba/src/features/questions/cubit/questions_state.dart';
import 'package:apk_iman_ba/src/shared/common_widgets/custom_fab.dart';
import 'package:apk_iman_ba/src/shared/common_widgets/custom_listview.dart';
import 'package:apk_iman_ba/src/shared/enums/topics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                            context.read<QuestionsCubit>().updateCurrentTopic(
                                  Topic.values[index],
                                  index,
                                );
                          },
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: CustomListView(
                    loadingFlag: state.isLoading,
                    itemCount: state.questions.length,
                    questionList: state.questions,
                    useSubtitle: true,
                    detailViewSelector: 1,
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
