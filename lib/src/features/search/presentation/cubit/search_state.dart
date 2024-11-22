import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:apk_iman_ba/src/features/questions/domain/models/question_model.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    @Default([]) List<Question> searchResults,
    @Default(true) bool isLoading,
    @Default('') String searchQuery,
  }) = _SearchState;
}
