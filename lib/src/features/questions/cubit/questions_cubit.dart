import 'package:apk_iman_ba/services/database_service.dart';
import 'package:apk_iman_ba/src/features/questions/cubit/questions_state.dart';
import 'package:apk_iman_ba/src/shared/utils.dart';
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

  void updateCurrentTopic(String topic, int index) {
    final cleanTopic = Utils().removeEmojis(topic);
    emit(state.copyWith(
      currentTopic: cleanTopic,
      selectedTopicIndex: index,
    ));

    if (cleanTopic == "Novo") {
      fetchQuestionsByDate();
    } else {
      fetchQuestionsByTopic(cleanTopic);
    }
  }
}
