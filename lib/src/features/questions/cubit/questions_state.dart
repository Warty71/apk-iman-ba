import 'package:apk_iman_ba/src/features/questions/domain/models/question_model.dart';
import 'package:apk_iman_ba/src/shared/enums/topics.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'questions_state.freezed.dart';

@freezed
class QuestionsState with _$QuestionsState {
  const factory QuestionsState({
    @Default([]) List<Question> questions,
    @Default(true) bool isLoading,
    @Default(Topic.novo) Topic currentTopic,
    @Default(0) int selectedTopicIndex,
    @Default({}) Map<Topic, List<Question>> questionsByTopic,
  }) = _QuestionsState;
}
