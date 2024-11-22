import 'package:apk_iman_ba/services/database_service.dart';
import 'package:apk_iman_ba/src/features/questions/cubit/questions_state.dart';
import 'package:apk_iman_ba/src/features/questions/domain/models/question_model.dart';
import 'package:apk_iman_ba/src/shared/enums/topics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  final DatabaseService _database;

  QuestionsCubit({required DatabaseService database})
      : _database = database,
        super(const QuestionsState()) {
    _initializeData();
  }

  Future<void> _initializeData() async {
    // Show loading state initially
    emit(state.copyWith(isLoading: true));

    // Load all data for each topic
    final Map<Topic, List<Question>> allData = {};

    // Load "Novo" questions first
    final newQuestions = await _database.filterByDate();
    allData[Topic.novo] = newQuestions;

    // Load questions for each topic
    for (final topic in Topic.values.where((t) => t != Topic.novo)) {
      final questions = await _database.filterByTopic(topic.withoutEmoji);
      allData[topic] = questions;
    }

    // Update state with all data and show initial (Novo) questions
    emit(state.copyWith(
      questionsByTopic: allData,
      questions: allData[Topic.novo] ?? [],
      isLoading: false,
    ));
  }

  void updateCurrentTopic(Topic topic, int index) {
    emit(
      state.copyWith(
        currentTopic: topic,
        selectedTopicIndex: index,
        questions: state.questionsByTopic[topic] ?? [],
      ),
    );
  }

  Future<void> increaseViewCount(String title, int currentViews) async {
    await _database.updateViews("pitanje", title, "pregledi", currentViews);
  }
}
