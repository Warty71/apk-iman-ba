import 'package:apk_iman_ba/services/database_service.dart';
import 'package:apk_iman_ba/src/features/questions/cubit/questions_state.dart';
import 'package:apk_iman_ba/src/shared/enums/topics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  final DatabaseService _database;

  QuestionsCubit({required DatabaseService database})
      : _database = database,
        super(const QuestionsState()) {
    fetchQuestionsByDate();
  }

  Future<void> fetchQuestionsByTopic(String topic) async {
    emit(state.copyWith(isLoading: true));

    final questions = await _database.filterByTopic(topic);

    emit(state.copyWith(
      questions: questions,
      isLoading: false,
    ));
  }

  Future<void> fetchQuestionsByDate() async {
    emit(state.copyWith(isLoading: true));

    final questions = await _database.filterByDate();

    emit(state.copyWith(
      questions: questions,
      isLoading: false,
    ));
  }

  void updateCurrentTopic(Topic topic, int index) {
    emit(
      state.copyWith(
        currentTopic: topic,
        selectedTopicIndex: index,
      ),
    );

    if (topic == Topic.novo) {
      fetchQuestionsByDate();
    } else {
      fetchQuestionsByTopic(topic.withoutEmoji);
    }
  }

  Future<void> increaseViewCount(String title, int currentViews) async {
    await _database.updateViews("pitanje", title, "pregledi", currentViews);
  }
}
