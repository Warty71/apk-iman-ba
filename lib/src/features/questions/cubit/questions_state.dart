import 'package:apk_iman_ba/src/features/questions/domain/models/question_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'questions_state.freezed.dart';

@freezed
class QuestionsState with _$QuestionsState {
  const factory QuestionsState({
    @Default([]) List<Question> questions,
    @Default(true) bool isLoading,
    @Default("Novo") String currentTopic,
    @Default(0) int selectedTopicIndex,
  }) = _QuestionsState;
}
