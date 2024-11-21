import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:apk_iman_ba/src/features/questions/domain/models/question_model.dart';

part 'favorites_state.freezed.dart';

@freezed
class FavoritesState with _$FavoritesState {
  const factory FavoritesState({
    @Default([]) List<Question> favorites,
    @Default(true) bool isLoading,
  }) = _FavoritesState;
}
